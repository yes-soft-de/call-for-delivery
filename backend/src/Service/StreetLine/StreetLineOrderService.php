<?php

namespace App\Service\StreetLine;

use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\HTTP\HttpMethodConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

class StreetLineOrderService
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
        $paymentType = 1;

        if ($orderEntity->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CARD) {
            $paymentType = 2;
        }

        return [
            StreetLineCompanyConstant::PICKUP_LAT_FIELD_CONST => $storeOrderDetailsEntity->getBranch()->getLocation()['lat'],
            StreetLineCompanyConstant::PICKUP_LNG_FIELD_CONST => $storeOrderDetailsEntity->getBranch()->getLocation()['lon'],
            StreetLineCompanyConstant::CUSTOMER_LAT_FIELD_CONST => $storeOrderDetailsEntity->getDestination()['lat'],
            StreetLineCompanyConstant::CUSTOMER_LNG_FIELD_CONST => $storeOrderDetailsEntity->getDestination()['lon'],
            StreetLineCompanyConstant::CUSTOMER_PHONE_FIELD_CONST => $storeOrderDetailsEntity->getRecipientPhone(),
            StreetLineCompanyConstant::PAYMENT_TYPE_FIELD_CONST => $paymentType,
            StreetLineCompanyConstant::ORDER_VALUE_FIELD_CONST => $orderEntity->getOrderCost(),
            StreetLineCompanyConstant::ORDER_DETAILS_FIELD_CONST => $storeOrderDetailsEntity->getDetail(),
            StreetLineCompanyConstant::CUSTOMER_NAME_FIELD_CONST => $storeOrderDetailsEntity->getRecipientName(),
            StreetLineCompanyConstant::CLIENT_ORDER_ID_FIELD_CONST => $orderEntity->getId()
        ];
    }

    /**
     * Execute a create order post request to Street Line
     */
    public function createOrderPostRequest(string $url, array $body): ResponseInterface
    {
        return $this->client->request(
            HttpMethodConstant::POST_METHOD_CONST,
            $url,
            [
                'json' => $body
            ]);
    }

    /**
     * Creates a new order in Street Line and returns the response
     */
    public function createOrderInStreetLine(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): ResponseInterface
    {
        $createOrderJsonRequest = $this->initializeCreateOrderRequest($orderEntity, $storeOrderDetailsEntity);

        return $this->createOrderPostRequest(
            $this->params->get('streetLine_base_url')
            . $this->params->get('streetLine_token')
            . $this->params->get('streetLine_create_order_url'),
            $createOrderJsonRequest
        );
    }
}
