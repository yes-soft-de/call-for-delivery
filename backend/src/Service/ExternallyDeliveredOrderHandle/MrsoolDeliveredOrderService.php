<?php

namespace App\Service\ExternallyDeliveredOrderHandle;

use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
use App\Constant\HTTP\HttpMethodConstant;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

/**
 * Responsible for sending order externally to be delivered by Mrsool
 * ////todo to be moved to Service\Mrsool path
 */
class MrsoolDeliveredOrderService
{
    public function __construct(
        private HttpClientInterface $client,
        private ParameterBagInterface $params
    )
    {
    }

    /**
     * Initialize and prepare the json body of the create order request
     */
    public function initializeCreateOrderRequest(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): array
    {
        // fields can not be null
//        $description = $storeOrderDetailsEntity->getDetail() ? : MrsoolCompanyConstant::ORDER_DEFAULT_DESCRIPTION_CONST;
//        $orderCost = $orderEntity->getOrderCost() ? : 0;
        $description = "الطلب جاهز بإسم" . " " . $storeOrderDetailsEntity->getRecipientName() . "\n".
            "رقم الجوال" . " +" . $storeOrderDetailsEntity->getRecipientPhone() . "\n".
            "من" . " " . $orderEntity->getStoreOwner()->getStoreOwnerName();

        $orderCost = $orderEntity->getOrderCost();

//        if ((! $description) || ($description === "")) {
//            if ($orderEntity->getStoreOwner()->getId() === 42) {
//                $description = "واحد سويتز بوكس";
//
//            } elseif ($orderEntity->getStoreOwner()->getId() === 2) {
//                $description = "باقة ورد";
//
//            } elseif ($orderEntity->getStoreOwner()->getId() === 111) {
//                $description = "وجبة سكرت رول";
//
//            } elseif ($orderEntity->getStoreOwner()->getId() === 282) {
//                $description = "نص كيلوا كباب";
//            }
//        }

        if ((! $orderCost) || ($orderCost == 0)) {
            if ($orderEntity->getStoreOwner()->getId() === 42) {
                $orderCostsArray = [49, 50, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130];
                $orderCost = $orderCostsArray[array_rand($orderCostsArray)];

            } elseif ($orderEntity->getStoreOwner()->getId() === 2) {
                $orderCostsArray = [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
                $orderCost = $orderCostsArray[array_rand($orderCostsArray)];

            } elseif ($orderEntity->getStoreOwner()->getId() === 111) {
                $orderCostsArray = [60, 65, 70, 75, 80, 85, 90, 95, 100, 150, 200];
                $orderCost = $orderCostsArray[array_rand($orderCostsArray)];

            } elseif ($orderEntity->getStoreOwner()->getId() === 282) {
                $orderCostsArray = [60, 65, 70, 75, 80, 85, 90, 95, 100];
                $orderCost = $orderCostsArray[array_rand($orderCostsArray)];

            } elseif ($orderEntity->getStoreOwner()->getId() === 29) {
                $orderCost = 70;

            } elseif (($orderEntity->getStoreOwner()->getId() === 73)
                || ($orderEntity->getStoreOwner()->getId() === 89)
                || ($orderEntity->getStoreOwner()->getId() === 173)
                || ($orderEntity->getStoreOwner()->getId() === 193)
                || ($orderEntity->getStoreOwner()->getId() === 203)
                || ($orderEntity->getStoreOwner()->getId() === 207)
                || ($orderEntity->getStoreOwner()->getId() === 283)
                || ($orderEntity->getStoreOwner()->getId() === 291)) {
                $orderCostsArray = [60, 65, 70, 75, 80, 85, 90, 95, 100];
                $orderCost = $orderCostsArray[array_rand($orderCostsArray)];
            }
        }

        return [
            MrsoolCompanyConstant::PICKUP_FIELD_CONST => [
                MrsoolCompanyConstant::LATITUDE_FIELD_CONST => (string) $storeOrderDetailsEntity->getBranch()->getLocation()['lat'],
                MrsoolCompanyConstant::LONGITUDE_FIELD_CONST => (string) $storeOrderDetailsEntity->getBranch()->getLocation()['lon']
            ],
            MrsoolCompanyConstant::DROPOFF_FIELD_CONST => [
                MrsoolCompanyConstant::LATITUDE_FIELD_CONST => (string) $storeOrderDetailsEntity->getDestination()['lat'],
                MrsoolCompanyConstant::LONGITUDE_FIELD_CONST => (string) $storeOrderDetailsEntity->getDestination()['lon']
            ],
            MrsoolCompanyConstant::BUYER_FIELD_CONST => [
                MrsoolCompanyConstant::PHONE_FIELD_CONST => $storeOrderDetailsEntity->getRecipientPhone(),
                MrsoolCompanyConstant::FULL_NAME_FIELD_CONST => $storeOrderDetailsEntity->getRecipientName()
            ],
            MrsoolCompanyConstant::STORE_FIELD_CONST => [
                MrsoolCompanyConstant::NAME_FIELD_CONST => $orderEntity->getStoreOwner()->getStoreOwnerName(),
                MrsoolCompanyConstant::PHONE_FIELD_CONST => $orderEntity->getStoreOwner()->getPhone()
            ],
            MrsoolCompanyConstant::SHIPMENT_VALUE_FIELD_CONST => $orderCost,
            MrsoolCompanyConstant::DESCRIPTION_FIELD_CONST => $description
        ];
    }

    /**
     * Execute a create order post request to Mrsool
     */
    public function createOrderPostRequest(string $url, array $body): ResponseInterface
    {
        return $this->client->request(
            HttpMethodConstant::POST_METHOD_CONST,
            $url,
            [
                'json' => $body,
                'auth_bearer' => $this->params->get('mrsool_token')
            ]);
    }

    /**
     * Creates a new order in Mrsool and returns the response
     */
    public function createOrderInMrsool(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): ResponseInterface
    {
        $createOrderJsonRequest = $this->initializeCreateOrderRequest($orderEntity, $storeOrderDetailsEntity);

        return $this->createOrderPostRequest(
            $this->params->get('mrsool_base_url') . $this->params->get('mrsool_create_order_url'),
            $createOrderJsonRequest
        );
    }
}
