<?php

namespace App\Manager\PriceOffer;

use App\AutoMapping;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Entity\PriceOfferEntity;
use App\Manager\BidDetails\BidDetailsManager;
use App\Manager\Order\OrderManager;
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
    private BidDetailsManager $bidDetailsManager;
    private SupplierProfileManager $supplierProfileManager;
    private OrderManager $orderManager;
    private PriceOfferEntityRepository $priceOfferEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, BidDetailsManager $bidDetailsManager, SupplierProfileManager $supplierProfileManager, OrderManager $orderManager,
                                PriceOfferEntityRepository $priceOfferEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->bidDetailsManager = $bidDetailsManager;
        $this->supplierProfileManager = $supplierProfileManager;
        $this->orderManager = $orderManager;
        $this->priceOfferEntityRepository = $priceOfferEntityRepository;
    }

    public function createPriceOffer(PriceOfferCreateRequest $request): PriceOfferEntity
    {
        // Set the bid order entity in the create request
        $bidDetailsEntity = $this->bidDetailsManager->getBidDetailsEntityByBidOrderId($request->getBidDetails());
        $request->setBidDetails($bidDetailsEntity);

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

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidDetailsId): array
    {
        return $this->priceOfferEntityRepository->getPriceOffersByBidOrderIdForStoreOwner($bidDetailsId);
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
            $this->updateAllPricesOffersStatusExceptTheAcceptedOne($request->getId(), $priceOfferEntity->getBidDetails()->getId());

            // thirdly, set the order to be closed for further price offers
            $this->bidDetailsManager->updateBidDetailsToBeClosedForPriceOffer($priceOfferEntity->getBidDetails()->getId());

            return $priceOfferEntity;
        }

        // note: we can add new elseif section, which will be used when the store want to re-open the order for prices offers
        // and that's happen when supplier didn't confirmed the acceptance of a store owner for a price offer
    }

    // This function update the status of all prices offers of a bid order except the accepted offer
    public function updateAllPricesOffersStatusExceptTheAcceptedOne(int $acceptedPriceOfferId, int $bidDetailsId)
    {
        $pricesOffersEntities = $this->priceOfferEntityRepository->getAllPricesOffersOfBidOrderExceptedOne($bidDetailsId, $acceptedPriceOfferId);

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

            // then, we update order status from 'initialized' to 'pending'
            $this->orderManager->updateBidOrderStateToPendingBySupplier($priceOfferEntity->getBidDetails()->getOrderId()->getId());

            return $priceOfferEntity;
        }
    }

    public function deleteAllPricesOffers(): array
    {
        $pricesOffers = $this->priceOfferEntityRepository->findAll();

        if ($pricesOffers) {
            foreach ($pricesOffers as $pricesOffer) {
                $this->entityManager->remove($pricesOffer);

                $this->entityManager->flush();
            }
        }

        return $pricesOffers;
    }
}
