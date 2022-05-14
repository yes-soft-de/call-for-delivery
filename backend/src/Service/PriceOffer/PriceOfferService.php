<?php

namespace App\Service\PriceOffer;

use App\AutoMapping;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\PriceOfferEntity;
use App\Manager\PriceOffer\PriceOfferManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Request\PriceOffer\PriceOfferStatusUpdateRequest;
use App\Response\PriceOffer\PriceOfferByBidOrderIdGetForStoreOwnerResponse;
use App\Response\PriceOffer\PriceOfferDeleteResponse;
use App\Response\PriceOffer\PriceOfferUpdateResponse;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Notification\NotificationLocalService;

class PriceOfferService
{
    private AutoMapping $autoMapping;
    private PriceOfferManager $priceOfferManager;
    private NotificationFirebaseService $notificationFirebaseService;
    private NotificationLocalService $notificationLocalService;

    public function __construct(AutoMapping $autoMapping, PriceOfferManager $priceOfferManager, NotificationFirebaseService $notificationFirebaseService,
                                NotificationLocalService $notificationLocalService)
    {
        $this->autoMapping = $autoMapping;
        $this->priceOfferManager = $priceOfferManager;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->notificationLocalService = $notificationLocalService;
    }

    public function createPriceOffer(PriceOfferCreateRequest $request): string|PriceOfferEntity
    {
        $priceOfferResult = $this->priceOfferManager->createPriceOffer($request);

        // Check if price offer created successfully, then send create firebase and local notification
        if ($priceOfferResult !== SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_RESULT) {
            // create firebase notification
            $this->sendNotificationToStoreOwnerOfNewPriceOffer($priceOfferResult);

            // create local notification
            $this->createPriceOfferNotificationLocal($priceOfferResult);
        }

        return $priceOfferResult;
    }

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidDetailsId, int $userId): array
    {
        $response = [];

        $priceOffers = $this->priceOfferManager->getPriceOffersByBidOrderIdForStoreOwner($bidDetailsId);

        // Get store profit margin (either private or common one)
        $storeProfitMargin = $this->priceOfferManager->getStoreProfitMarginForStoreOwner($userId);

        foreach ($priceOffers as $key=>$value) {
            $response[$key] = $this->autoMapping->map("array", PriceOfferByBidOrderIdGetForStoreOwnerResponse::class, $value);

            // this condition can be removed later when old data is replaced by new one
            if ($response[$key]->transportationCount !== null && $response[$key]->deliveryCost !== null) {
                // Calculate the total delivery cost of a price offer
                // Total Delivery Cost = the delivery cost of one transportation of a specific car X transportation count
                $response[$key]->totalDeliveryCost = round($response[$key]->transportationCount * $response[$key]->deliveryCost, 2);
            }

            // set the store profit margin
            $response[$key]->profitMargin = $storeProfitMargin;
        }

        return $response;
    }

    public function updatePriceOfferStatusByStoreOwner(PriceOfferStatusUpdateRequest $request): ?PriceOfferUpdateResponse
    {
        $priceOfferResult = $this->priceOfferManager->updatePriceOfferStatusByStoreOwner($request);

        if ($priceOfferResult) {
            // send firebase notification/s of price offer status update to the supplier
            //$this->sendNotificationOfPriceOfferStatusUpdateToSupplier($priceOfferResult);

            // create local notification/s of price offer status update
            $this->createLocalNotificationOfPriceOfferStatusUpdate($priceOfferResult);
        }

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferUpdateResponse::class, $priceOfferResult);
    }

    public function updatePriceOfferStatusBySupplier(PriceOfferStatusUpdateRequest $request): ?PriceOfferUpdateResponse
    {
        $priceOfferResult = $this->priceOfferManager->updatePriceOfferStatusBySupplier($request);

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferUpdateResponse::class, $priceOfferResult);
    }

    public function deletePendingPriceOfferById(int $id): ?PriceOfferDeleteResponse
    {
        $priceOfferResult = $this->priceOfferManager->deletePendingPriceOfferById($id);

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferDeleteResponse::class, $priceOfferResult);
    }

    public function deleteAllPricesOffers(): PriceOfferDeleteResponse
    {
        $pricesOffers = $this->priceOfferManager->deleteAllPricesOffers();

        return $this->autoMapping->map("array", PriceOfferDeleteResponse::class, $pricesOffers);
    }

    // handle the notification about newly created price offer which will be sent to store owner
    public function sendNotificationToStoreOwnerOfNewPriceOffer(PriceOfferEntity $priceOfferEntity)
    {
        $this->notificationFirebaseService->sendNotificationToStoreOwnerOfNewPriceOffer($priceOfferEntity->getBidDetails()->getOrderId()->getStoreOwner()->getStoreOwnerId(),
            $priceOfferEntity->getBidDetails()->getOrderId()->getId());
    }

    public function createPriceOfferNotificationLocal(PriceOfferEntity $priceOfferEntity)
    {
        $this->notificationLocalService->createPriceOfferNotificationLocal($priceOfferEntity->getBidDetails()->getOrderId()->getStoreOwner()->getStoreOwnerId(),
            NotificationConstant::NEW_PRICE_OFFER, NotificationConstant::NEW_PRICE_OFFER_ADDED, $priceOfferEntity->getBidDetails()->getOrderId()->getId(),
            $priceOfferEntity->getBidDetails()->getId(), $priceOfferEntity->getId());
    }

    // handle the notification about price offer status which will be sent to the supplier
    public function sendNotificationOfPriceOfferStatusUpdateToSupplier(PriceOfferEntity $priceOfferEntity)
    {
        if ($priceOfferEntity->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_ACCEPTED_STATUS) {
            /**
             * As long as one price offer is being accepted, then other prices offers for the same bid order were being refused
             * So that, we have also send notification to their suppliers as well.
             */
            foreach ($priceOfferEntity->getBidDetails()->getPriceOfferEntities()->toArray() as $priceOffer) {
                if ($priceOffer->getId() !== $priceOfferEntity->getId()) {
                    // this is not the accepted price offer, so send a 'refused' notification
                    $this->notificationFirebaseService->sendNotificationOfPriceOfferStatusUpdateToSupplier($priceOffer->getSupplierProfile()->getUser()->getId(),
                        $priceOffer->getId(), NotificationFirebaseConstant::PRICE_OFFER_REFUSED);

                } else {
                    $this->notificationFirebaseService->sendNotificationOfPriceOfferStatusUpdateToSupplier($priceOffer->getSupplierProfile()->getUser()->getId(),
                        $priceOffer->getId(), NotificationFirebaseConstant::PRICE_OFFER_ACCEPTED);
                }
            }

        } elseif ($priceOfferEntity->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_REFUSED_STATUS) {
            $this->notificationFirebaseService->sendNotificationOfPriceOfferStatusUpdateToSupplier($priceOfferEntity->getSupplierProfile()->getUser()->getId(),
                $priceOfferEntity->getId(), NotificationFirebaseConstant::PRICE_OFFER_REFUSED);
        }
    }

    // handle the notification about price offer status which will be sent to the supplier
    public function createLocalNotificationOfPriceOfferStatusUpdate(PriceOfferEntity $priceOfferEntity)
    {
        if ($priceOfferEntity->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_ACCEPTED_STATUS) {
            /**
             * As long as one price offer is being accepted, then other prices offers for the same bid order were being refused
             * So that, we have also send notification to their suppliers as well.
             */
            foreach ($priceOfferEntity->getBidDetails()->getPriceOfferEntities()->toArray() as $priceOffer) {
                if ($priceOffer->getId() !== $priceOfferEntity->getId()) {
                    // this is not the accepted price offer, so send a 'refused' notification
                    $this->notificationLocalService->createPriceOfferNotificationLocal($priceOffer->getSupplierProfile()->getUser()->getId(), NotificationConstant::PRICE_OFFER_STATUS_UPDATE,
                        NotificationConstant::PRICE_OFFER_STATUS_REFUSED, $priceOffer->getBidDetails()->getOrderId()->getId(), $priceOffer->getBidDetails()->getId(), $priceOffer->getId());

                } else {
                    $this->notificationLocalService->createPriceOfferNotificationLocal($priceOffer->getSupplierProfile()->getUser()->getId(), NotificationConstant::PRICE_OFFER_STATUS_UPDATE,
                        NotificationConstant::PRICE_OFFER_STATUS_ACCEPTED, $priceOffer->getBidDetails()->getOrderId()->getId(), $priceOffer->getBidDetails()->getId(), $priceOffer->getId());
                }
            }

        } elseif ($priceOfferEntity->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_REFUSED_STATUS) {
            $this->notificationLocalService->createPriceOfferNotificationLocal($priceOfferEntity->getSupplierProfile()->getUser()->getId(), NotificationConstant::PRICE_OFFER_STATUS_UPDATE,
                NotificationConstant::PRICE_OFFER_STATUS_REFUSED, $priceOfferEntity->getBidDetails()->getOrderId()->getId(), $priceOfferEntity->getBidDetails()->getId(), $priceOfferEntity->getId());
        }
    }
}
