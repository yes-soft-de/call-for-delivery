<?php

namespace App\Service\ExternalOrderGetHandler;

use App\Constant\HTTP\HttpResponseConstant;
use App\Service\Mrsool\MrsoolOrderGetService;
use Symfony\Contracts\HttpClient\ResponseInterface;

/**
 * Responsible for get external order info (status)
 */
class ExternalOrderGetHandlerService
{
    public function __construct(
        private MrsoolOrderGetService $mrsoolOrderGetService
    )
    {
    }

    public function handleUpdateExternalOrders()
    {

    }

    public function getOrderByIdFromMrsool(int $orderId): ResponseInterface
    {
        return $this->mrsoolOrderGetService->getOrderById($orderId);
    }

    /**
     * Handles ResponseInterface object
     */
    public function handleResponseInterface(ResponseInterface $response): int|array
    {
        $statusCode = $response->getStatusCode();
        //$arrayResponse = json_decode($response->getContent(), true);

        if ($statusCode === HttpResponseConstant::INVALID_CREDENTIALS_STATUS_CODE_CONST) {
            return HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST;

        } elseif ($statusCode === HttpResponseConstant::ORDER_NOT_FOUND_STATUS_CODE_CONST) {
            return HttpResponseConstant::ORDER_NOT_FOUND_RESULT_CONST;

        } elseif ($statusCode === HttpResponseConstant::ORDER_FOUND_STATUS_CODE_CONST) {
            // While the create post request done successfully, then return the response content
            //return $arrayResponse;
            return json_decode($response->getContent(), true);
        }

        return HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST;
    }

    public function getExternalOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): int|array
    {
        // according to company, get the order
        if ($externalDeliveryCompanyId === 1) {
            // get order from Mrsool
            $orderResponseInterface = $this->getOrderByIdFromMrsool($orderId);

            return $this->handleResponseInterface($orderResponseInterface);
        }
    }
}
