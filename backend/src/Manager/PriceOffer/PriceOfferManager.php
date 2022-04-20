<?php

namespace App\Manager\PriceOffer;

use App\AutoMapping;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Entity\PriceOfferEntity;
use App\Manager\BidOrder\BidOrderManager;
use App\Manager\Supplier\SupplierProfileManager;
use App\Repository\PriceOfferEntityRepository;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Request\PriceOffer\PriceOfferStatusUpdateRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;

class PriceOfferManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private BidOrderManager $bidOrderManager;
    private SupplierProfileManager $supplierProfileManager;
    private PriceOfferEntityRepository $priceOfferEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, BidOrderManager $bidOrderManager, SupplierProfileManager $supplierProfileManager, PriceOfferEntityRepository $priceOfferEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->bidOrderManager = $bidOrderManager;
        $this->supplierProfileManager = $supplierProfileManager;
        $this->priceOfferEntityRepository = $priceOfferEntityRepository;
    }

    public function createPriceOffer(PriceOfferCreateRequest $request): PriceOfferEntity
    {
        // Set the bid order entity in the create request
        $bidOrderEntity = $this->bidOrderManager->getBidOrderEntityByBidOrderId($request->getBidOrder());
        $request->setBidOrder($bidOrderEntity);

        // Set the supplier profile entity in the create request
        $supplierProfileEntity = $this->supplierProfileManager->getSupplierProfileEntityBySupplierId($request->getSupplierProfile());
        $request->setSupplierProfile($supplierProfileEntity);

        // now create the price offer
        $priceOfferEntity = $this->autoMapping->map(PriceOfferCreateRequest::class, PriceOfferEntity::class, $request);

        $priceOfferEntity->setOfferDeadline(new DateTime ($request->getOfferDeadline()));
        $priceOfferEntity->setPriceOfferStatus(PriceOfferStatusConstant::PRICE_OFFER_PENDING_STATUS);

        $this->entityManager->persist($priceOfferEntity);
        $this->entityManager->flush();

        return $priceOfferEntity;
    }

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidOrderId): array
    {
        return $this->priceOfferEntityRepository->getPriceOffersByBidOrderIdForStoreOwner($bidOrderId);
    }

    public function updatePriceOfferStatusByStoreOwner(PriceOfferStatusUpdateRequest $request): ?PriceOfferEntity
    {
        $priceOfferEntity = $this->priceOfferEntityRepository->find($request->getId());

        if (! $priceOfferEntity) {
            return $priceOfferEntity;
        }

        if ($request->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_REFUSED_STATUS) {
            // store owner refused the offer, so update its status to be refused
            $priceOfferEntity = $this->autoMapping->mapToObject(PriceOfferStatusUpdateRequest::class, PriceOfferEntity::class, $request, $priceOfferEntity);

            $this->entityManager->flush();

            return $priceOfferEntity;

        } elseif ($request->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_ACCEPTED_STATUS) {
            // store owner accepted the offer,
            // firstly, update the offer status
            $priceOfferEntity = $this->autoMapping->mapToObject(PriceOfferStatusUpdateRequest::class, PriceOfferEntity::class, $request, $priceOfferEntity);

            $this->entityManager->flush();

            // then, update the status of the other offers (for the same order) to be refused
            $this->updateAllPricesOffersStatusExceptTheAcceptedOne($request->getId(), $priceOfferEntity->getBidOrder()->getId());

            // thirdly, set the order to be closed for further price offers
            $this->bidOrderManager->updateBidOrderToBeClosedForPriceOffer($priceOfferEntity->getBidOrder()->getId());

            return $priceOfferEntity;
        }
    }

    // This function update the status of all prices offers of a bid order except the accepted offer
    public function updateAllPricesOffersStatusExceptTheAcceptedOne(int $acceptedPriceOfferId, int $bidOrderId)
    {
        $pricesOffersEntities = $this->priceOfferEntityRepository->getAllPricesOffersOfBidOrderExceptedOne($bidOrderId, $acceptedPriceOfferId);

        if (! empty($pricesOffersEntities)) {
            foreach ($pricesOffersEntities as $priceOfferEntity) {
                    $priceOfferEntity->setPriceOfferStatus(PriceOfferStatusConstant::PRICE_OFFER_REFUSED_STATUS);
            }

            $this->entityManager->flush();
        }
    }

    public function updatePriceOfferStatusBySupplier(PriceOfferStatusUpdateRequest $request): ?PriceOfferEntity
    {
        $priceOfferEntity = $this->priceOfferEntityRepository->find($request->getId());

        if (! $priceOfferEntity) {
            return $priceOfferEntity;
        }

        if ($request->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_CONFIRMED_STATUS) {
            // supplier confirmed the price offer status after the acceptance of the store owner
            $priceOfferEntity = $this->autoMapping->mapToObject(PriceOfferStatusUpdateRequest::class, PriceOfferEntity::class, $request, $priceOfferEntity);

            $this->entityManager->flush();

            return $priceOfferEntity;
        }
    }
}
