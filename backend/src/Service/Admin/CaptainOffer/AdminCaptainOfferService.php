<?php

namespace App\Service\Admin\CaptainOffer;

use App\AutoMapping;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;
use App\Entity\CaptainOfferEntity;
use App\Manager\Admin\CaptainOffer\AdminCaptainOfferManager;
use App\Request\Admin\CaptainOffer\CaptainOfferCreateRequest;
use App\Response\Admin\CaptainOffer\CaptainOfferCreateResponse;

class AdminCaptainOfferService
{
    private AutoMapping $autoMapping;
    private AdminCaptainOfferManager $adminCaptainOfferManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainOfferManager $adminCaptainOfferManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainOfferManager = $adminCaptainOfferManager;
    }

    public function createCaptainOfferByAdmin(CaptainOfferCreateRequest $request): CaptainOfferCreateResponse
    {
        $captainOffer = $this->adminCaptainOfferManager->createCaptainOfferByAdmin($request);

        return $this->autoMapping->map(CaptainOfferEntity::class, CaptainOfferCreateResponse::class, $captainOffer);
    }

    public function updateCaptainOfferByAdmin($request): string|CaptainOfferCreateResponse
    {
        $captainOffer = $this->adminCaptainOfferManager->updateCaptainOfferByAdmin($request);

        if($captainOffer === CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST) {
            return CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST;

        }
        
        return $this->autoMapping->map(CaptainOfferEntity::class, CaptainOfferCreateResponse::class, $captainOffer);
    }

    public function getCaptainOffersByAdmin(): ?array
    {
        $response = [];

        $captainOffers = $this->adminCaptainOfferManager->getCaptainOffersByAdmin();

        foreach ($captainOffers as $captainOffer) {

            $response[] = $this->autoMapping->map(CaptainOfferEntity::class, CaptainOfferCreateResponse::class, $captainOffer);
        }

        return $response;
    }
    
    public function getCaptainOfferByAdmin($id): ?CaptainOfferCreateResponse
    {
        $captainOffer = $this->adminCaptainOfferManager->getCaptainOfferByAdmin($id);

        return $this->autoMapping->map(CaptainOfferEntity::class, CaptainOfferCreateResponse::class, $captainOffer);
    }
}
