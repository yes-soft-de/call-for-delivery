<?php

namespace App\Service\Admin\StreetLine;

use App\Constant\HTTP\HttpMethodConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

class AdminStreetLineOrderService
{
    public function __construct(
        private HttpClientInterface $client,
        private ParameterBagInterface $params
    )
    {
    }

    /**
     * Execute a cancel order get request to Street Line
     */
    public function createCancelOrderGetRequest(string $url): ResponseInterface
    {
        return $this->client->request(HttpMethodConstant::GET_METHOD_CONST, $url);
    }

    /**
     * Cancel an exist order in Street Line and returns the response
     */
    public function cancelOrderInStreetLine(int $externalOrderId): ResponseInterface
    {
        return $this->createCancelOrderGetRequest(
            $this->params->get('streetLine_base_url')
            . $this->params->get('streetLine_token')
            . $this->params->get('streetLine_cancel_order_url')
            . $externalOrderId
        );
    }
}
