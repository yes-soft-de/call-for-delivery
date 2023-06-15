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
        $description = $storeOrderDetailsEntity->getDetail();
        $orderCost = $orderEntity->getOrderCost();

        if ((! $description) || ($description === "")) {
            if ($orderEntity->getStoreOwner()->getId() === 42) {
                $description = "واحد سويتز بوكس";

            } elseif ($orderEntity->getStoreOwner()->getId() === 2) {
                $description = "باقة ورد";

            } elseif ($orderEntity->getStoreOwner()->getId() === 111) {
                $description = "وجبة سكرت رول";

            } elseif ($orderEntity->getStoreOwner()->getId() === 282) {
                $description = "نص كيلوا كباب";
            }
        }

        if ((! $orderCost) || ($orderCost == 0)) {
            if ($orderEntity->getStoreOwner()->getId() === 42) {
                $orderCost = 49;

            } elseif ($orderEntity->getStoreOwner()->getId() === 2) {
                $orderCost = 60;

            } elseif ($orderEntity->getStoreOwner()->getId() === 111) {
                $orderCost = 115;

            } elseif ($orderEntity->getStoreOwner()->getId() === 282) {
                $orderCost = 70;
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
            MrsoolCompanyConstant::BASE_URL_CONST . MrsoolCompanyConstant::CREATE_ORDER_URL_CONST,
            $createOrderJsonRequest
        );
    }
}
