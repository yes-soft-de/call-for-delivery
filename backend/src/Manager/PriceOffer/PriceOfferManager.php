<?php

namespace App\Manager\PriceOffer;

use App\AutoMapping;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Entity\PriceOfferEntity;
use App\Manager\BidOrder\BidOrderManager;
use App\Manager\Supplier\SupplierProfileManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;

class PriceOfferManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private BidOrderManager $bidOrderManager;
    private SupplierProfileManager $supplierProfileManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, BidOrderManager $bidOrderManager, SupplierProfileManager $supplierProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->bidOrderManager = $bidOrderManager;
        $this->supplierProfileManager = $supplierProfileManager;
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
}
