<?php

namespace App\Service\Mrsool;

use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
use App\Constant\HTTP\HttpMethodConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

class MrsoolOrderGetService
{
    public function __construct(
        private HttpClientInterface $client,
        private ParameterBagInterface $params
    )
    {
    }

    /**
     * Execute a Get order request to Mrsool
     */
    public function executeGetOrderRequest(string $url): ResponseInterface
    {
        return $this->client->request(
            HttpMethodConstant::GET_METHOD_CONST,
            $url,
            [
                'auth_bearer' => $this->params->get('mrsool_token')
            ]);
    }

    public function getOrderById(int $orderId): ResponseInterface
    {
        return $this->executeGetOrderRequest(
            MrsoolCompanyConstant::BASE_URL_PROD_CONST
            .MrsoolCompanyConstant::GET_ORDER_PROD_URL_CONST
            .$orderId);
    }
}
