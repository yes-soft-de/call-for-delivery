<?php

namespace App\Service\AnnouncementOrderDetails;

use App\AutoMapping;
use App\Entity\AnnouncementOrderDetailsEntity;
use App\Manager\AnnouncementOrderDetails\AnnouncementOrderDetailsManager;
use App\Request\AnnouncementOrderDetails\AnnouncementOrderPriceOfferValueUpdateRequest;
use App\Response\AnnouncementOrderDetails\AnnouncementOrderDetailsUpdateResponse;

class AnnouncementOrderDetailsService
{
    private AutoMapping $autoMapping;
    private AnnouncementOrderDetailsManager $announcementOrderDetailsManager;

    public function __construct(AutoMapping $autoMapping, AnnouncementOrderDetailsManager $announcementOrderDetailsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->announcementOrderDetailsManager = $announcementOrderDetailsManager;
    }

    public function updateAnnouncementOrderDetailsPriceOfferValueBySupplier(AnnouncementOrderPriceOfferValueUpdateRequest $request): ?AnnouncementOrderDetailsUpdateResponse
    {
        $announcementOrderDetails = $this->announcementOrderDetailsManager->updateAnnouncementOrderDetailsPriceOfferValueBySupplier($request);

        return $this->autoMapping->map(AnnouncementOrderDetailsEntity::class, AnnouncementOrderDetailsUpdateResponse::class, $announcementOrderDetails);
    }
}
