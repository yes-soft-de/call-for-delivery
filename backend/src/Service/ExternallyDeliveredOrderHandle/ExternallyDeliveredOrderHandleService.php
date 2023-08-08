<?php

namespace App\Service\ExternallyDeliveredOrderHandle;

use App\Constant\AppFeature\AppFeatureNameConstant;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\AppFeature\AppFeatureStatusConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyIdentityConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsDistanceConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsFromAllStoresConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaPaymentConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Request\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminRequest;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateRequest;
use App\Service\AppFeature\AppFeatureGetService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\ExternalDeliveryCompany\ExternalDeliveryCompanyGetService;
use App\Service\ExternallyDeliveredOrder\ExternallyDeliveredOrderService;
use App\Service\Order\OrderGetService;
use App\Service\StreetLine\StreetLineOrderSendService;
use DateTimeInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

/**
 * Responsible for handling the process of sending order to an external party (company)
 */
class ExternallyDeliveredOrderHandleService
{
    public function __construct(
        private AppFeatureGetService $appFeatureGetService,
        private ExternalDeliveryCompanyGetService $externalDeliveryCompanyGetService,
        private MrsoolDeliveredOrderService $mrsoolDeliveredOrderService,
        private ExternallyDeliveredOrderService $externallyDeliveredOrderService,
        private OrderGetService $orderGetService,
        private DateFactoryService $dateFactoryService,
        private StreetLineOrderSendService $streetLineOrderSendService
    )
    {
    }

    /**
     * Checks if the feature of sending order to external party is activated or not
     */
    public function checkSendingOrderToExternalDeliveryCompanyFeatureStatus(): bool|int
    {
        return $this->appFeatureGetService->getAppFeatureStatusByAppFeatureName(AppFeatureNameConstant::APP_FEATURE_SEND_ORDER_TO_EXTERNAL_PARTY);
    }

    /**
     * Get single available external delivery company, if exist
     */
    public function checkAvailableExternalDeliveryCompany(): int|ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompanyGetService->getSingleAvailableExternalDeliveryCompany();
    }

    public function checkIfTimeIsBetweenSpecificTwoTime(DateTimeInterface $fromDate, DateTimeInterface $toDate, DateTimeInterface $specificDate): bool
    {
        return $this->dateFactoryService->checkIfTimeIsBetweenSpecificTwoTime($fromDate, $toDate, $specificDate);
    }

    /**
     * Checks if the order being passed meets the setting or not
     */
    public function checkIfOrderMatchTheSetting(OrderEntity $orderEntity, ExternalDeliveryCompanyEntity $externalDeliveryCompanyEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): int|bool
    {
        $deliveryCompanyCriteria = $externalDeliveryCompanyEntity->getExternalDeliveryCompanyCriteriaEntities()->toArray();

        // If no criteria were found, then exit the process with the result
        if (empty($deliveryCompanyCriteria)) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        // There is/are criteria for the company, compare order within them
        /**
         * Comparing law:
         * foreach criteria of the group of criteria: true result if order matched criteria, otherwise false result.
         * The final result is the consequence of logic OR operation between the results of each criteria
         */
        $criteriaMatchArrayResult = [];

        $orderCreatedAt = $orderEntity->getCreatedAt();
        $orderStoreBranchToClientDistance = $orderEntity->getStoreBranchToClientDistance();
        $orderPayment = $orderEntity->getPayment();
        $orderCost = $orderEntity->getOrderCost();
        $orderStoreBranchId = $storeOrderDetailsEntity->getBranch()->getId();

        foreach ($deliveryCompanyCriteria as $externalDeliveryCompanyCriteriaEntity) {
            // check criteria status
            if ($externalDeliveryCompanyCriteriaEntity->getStatus() === ExternalDeliveryCompanyCriteriaStatusConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS_FALSE_CONST) {
                // set the result of this criteria to false, and move to next criteria
                $criteriaMatchArrayResult[] = false;
                continue;
            }
            // first condition - check order creation date
            if ($externalDeliveryCompanyCriteriaEntity->getIsSpecificDate()) {
                // ($orderCreatedAt > $externalDeliveryCompanyCriteriaEntity->getToDate())
                //                    || ($orderCreatedAt < $externalDeliveryCompanyCriteriaEntity->getFromDate())
                if ($this->checkIfTimeIsBetweenSpecificTwoTime($externalDeliveryCompanyCriteriaEntity->getFromDate(),
                    $externalDeliveryCompanyCriteriaEntity->getToDate(), $orderCreatedAt) === false) {
                    // set the result of this criteria to false, and move to next criteria
                    $criteriaMatchArrayResult[] = false;
                    continue;
                }

            }
            // move to the second condition - check distance
            if ($externalDeliveryCompanyCriteriaEntity->getIsDistance() === ExternalDeliveryCompanyCriteriaIsDistanceConstant::IS_DISTANCE_STORE_BRANCH_TO_CLIENT_DISTANCE_CONST) {
                if (($orderStoreBranchToClientDistance < $externalDeliveryCompanyCriteriaEntity->getFromDistance()) ||
                    ($orderStoreBranchToClientDistance > $externalDeliveryCompanyCriteriaEntity->getToDistance())) {
                    // set the result of this criteria to false, and move to next criteria
                    $criteriaMatchArrayResult[] = false;
                    continue;
                }
            }
            // move to the third condition - check payment, and cash limit if exist
            $conditionPayment = $externalDeliveryCompanyCriteriaEntity->getPayment();

            if (($conditionPayment !== ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_OFF_CONST)
                || ($conditionPayment !== ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_BOTH_CARD_AND_CASH_CONST)) {
                if ((($conditionPayment === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_CARD_CONST)
                    && ($orderPayment === OrderTypeConstant::ORDER_PAYMENT_CASH))
                    ||
                    (($conditionPayment === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_CASH_CONST)
                        && ($orderPayment === OrderTypeConstant::ORDER_PAYMENT_CARD))) {
                    // set the result of this criteria to false, and move to next criteria
                    $criteriaMatchArrayResult[] = false;
                    continue;

                } elseif ((($conditionPayment === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_CASH_CONST)
                    && ($orderPayment === OrderTypeConstant::ORDER_PAYMENT_CASH))
                    || (($conditionPayment === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_BOTH_CARD_AND_CASH_CONST)
                        && ($orderPayment === OrderTypeConstant::ORDER_PAYMENT_CASH))) {
                    if (($externalDeliveryCompanyCriteriaEntity->getCashLimit())
                        && ($orderCost > $externalDeliveryCompanyCriteriaEntity->getCashLimit())) {
                        // set the result of this criteria to false, and move to next criteria
                        $criteriaMatchArrayResult[] = false;
                        continue;
                    }
                }
            }
            // move to the fourth condition - check stores' branches
            $storesBranches = $externalDeliveryCompanyCriteriaEntity->getFromStoresBranches();
            if (($externalDeliveryCompanyCriteriaEntity->getIsFromAllStores() === ExternalDeliveryCompanyCriteriaIsFromAllStoresConstant::IS_FROM_ALL_STORES_FALSE_CONST)
                && (! empty($storesBranches))) {
                if (! in_array($orderStoreBranchId, $externalDeliveryCompanyCriteriaEntity->getFromStoresBranches())) {
                    // set the result of this criteria to false, and move to next criteria
                    $criteriaMatchArrayResult[] = false;
                    continue;
                }
            }
            // As long as all of the criteria conditions are matched with order, then set the result of this criteria to true
            $criteriaMatchArrayResult[] = true;
            // and move to the next criteria, if exist
        }

        $finalResult = false;

        // Final function result is the OR operation between all criteria results
        foreach ($criteriaMatchArrayResult as $singleCriteriaResult) {
            $finalResult = $finalResult || $singleCriteriaResult;
        }

        return $finalResult;
    }

    /**
     * Creates a new order in Mrsool and returns the response
     */
    public function createOrderInMrsool(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): ResponseInterface
    {
        return $this->mrsoolDeliveredOrderService->createOrderInMrsool($orderEntity, $storeOrderDetailsEntity);
    }

    /**
     * Actually, this creates the order in the passed delivery company
     */
    public function sendOrderToExternalDeliveryCompany(OrderEntity $orderEntity, ExternalDeliveryCompanyEntity $externalDeliveryCompanyEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): int|ResponseInterface
    {
        // According to external delivery company send the order
        if ($externalDeliveryCompanyEntity->getId() === ExternalDeliveryCompanyIdentityConstant::MRSOOL_COMPANY_CONST) {
            // delivery company is Mrsool
            return $this->createOrderInMrsool($orderEntity, $storeOrderDetailsEntity);

        } elseif ($externalDeliveryCompanyEntity->getId() === ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST) {
            // delivery company is Street Line
            return $this->createOrderInStreetLine($orderEntity, $storeOrderDetailsEntity);
        }

        return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST;
    }

    /**
     * Handles ResponseInterface object
     */
    public function handleResponseInterface(ResponseInterface $response, int $externalDeliveryCompanyId): int|array
    {
        $statusCode = $response->getStatusCode();

        if ($externalDeliveryCompanyId === ExternalDeliveryCompanyIdentityConstant::MRSOOL_COMPANY_CONST) {
            if ($statusCode === HttpResponseConstant::INVALID_CREDENTIALS_STATUS_CODE_CONST) {
                return HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST;

            } elseif ($statusCode === HttpResponseConstant::INVALID_INPUT_STATUS_CODE_CONST) {
                return HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST;

            } elseif ($statusCode === HttpResponseConstant::SUCCESSFULLY_CREATED_STATUS_CODE_CONST) {
                // While the create post request done successfully, then return the response content
                return json_decode($response->getContent(), true);
            }

        } elseif ($externalDeliveryCompanyId === ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST) {
            if ($statusCode === HttpResponseConstant::DONE_SUCCESSFULLY_STATUS_CODE_CONST) {
                return json_decode($response->getContent(), true);

            } elseif ($statusCode === HttpResponseConstant::METHOD_NOT_ALLOWED_STATUS_CODE_CONST) {
                return HttpResponseConstant::METHOD_NOT_ALLOWED_RESULT_CONST;

            } elseif ($statusCode === HttpResponseConstant::NOT_ACCEPTABLE_STATUS_CODE_CONST) {
                return HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST;
            }
        }

        return HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST;
    }

    /**
     * Return new object of ExternallyDeliveredOrderCreateRequest
     */
    public function initializeExternallyDeliveredOrderCreateRequest(): ExternallyDeliveredOrderCreateRequest
    {
        return new ExternallyDeliveredOrderCreateRequest();
    }

    /**
     * Create new record of ExternallyDeliveredOrder
     */
    public function createExternallyDeliveredOrder(OrderEntity $orderEntity, ExternalDeliveryCompanyEntity $externalDeliveryCompanyEntity, array $createOrderResponse): ExternallyDeliveredOrderEntity
    {
        $createExternalOrderRequest = $this->initializeExternallyDeliveredOrderCreateRequest();

        $createExternalOrderRequest->setOrderId($orderEntity);
        $createExternalOrderRequest->setExternalDeliveryCompany($externalDeliveryCompanyEntity);

        if ($externalDeliveryCompanyEntity->getId() === ExternalDeliveryCompanyIdentityConstant::MRSOOL_COMPANY_CONST) {
            $createExternalOrderRequest->setExternalOrderId($createOrderResponse['data']['id']);
            $createExternalOrderRequest->setStatus($createOrderResponse['data']['status']);

        } elseif ($externalDeliveryCompanyEntity->getId() === ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST) {
            $createExternalOrderRequest->setExternalOrderId($createOrderResponse['order_id']);
            $createExternalOrderRequest->setStatus($createOrderResponse['status']);
        }

        return $this->externallyDeliveredOrderService->createExternallyDeliveredOrder($createExternalOrderRequest);
    }

    /**
     * Main function
     * Responsible for handling the process of sending order to an external party
     */
    public function handleSendingOrderToExternalDeliveryCompany(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): int|ExternallyDeliveredOrderEntity
    {
        // 1 check if sending order feature is On.
        $sendOrderExternallyFeatureStatus = $this->checkSendingOrderToExternalDeliveryCompanyFeatureStatus();

        if ($sendOrderExternallyFeatureStatus === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;

        } elseif ($sendOrderExternallyFeatureStatus === AppFeatureStatusConstant::FEATURE_STATUS_FALSE_CONST) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST;
        }

        // 2 check which company is available in order to send order to.
        $externalDeliveryCompany = $this->checkAvailableExternalDeliveryCompany();

        if ($externalDeliveryCompany === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        // 3 check if order meet the setting options
        $orderMatchResult = $this->checkIfOrderMatchTheSetting($orderEntity, $externalDeliveryCompany, $storeOrderDetailsEntity);

        if ($orderMatchResult === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;

        } elseif ($orderMatchResult === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_DOES_NOT_MATCH_ORDER_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::ORDER_DOES_NOT_MATCH_CRITERIA_RESULT;
        }

        // 4 while order is matching with one of the criteria, then send it
        $orderCreateResponse = $this->sendOrderToExternalDeliveryCompany($orderEntity, $externalDeliveryCompany, $storeOrderDetailsEntity);

        if ($orderCreateResponse === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST;
        }

        // 5 According to the response that being resulted from previous step, handle the situation
        $arrayResponse = $this->handleResponseInterface($orderCreateResponse, $externalDeliveryCompany->getId());

        if (($arrayResponse === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
            || ($arrayResponse === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)
            || ($arrayResponse === HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST)
            || ($arrayResponse === HttpResponseConstant::METHOD_NOT_ALLOWED_RESULT_CONST)) {
            return $arrayResponse;
        }

        // 6 Create externally delivered order
        return $this->createExternallyDeliveredOrder($orderEntity, $externalDeliveryCompany, $arrayResponse);
    }

    /**
     * Get single external delivery company by id, if exist
     */
    public function getExternalDeliveryCompanyById(int $externalCompanyId): int|ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompanyGetService->getExternalDeliveryCompanyById($externalCompanyId);
    }

    public function getOrderEntityById(int $orderId): OrderEntity|string
    {
        return $this->orderGetService->getOrderEntityById($orderId);
    }

    /**
     * Main function
     * Responsible for handling the process of sending order to an external party by admin
     * Note: because admin has different conditions for sending order externally
     */
    public function createExternallyDeliveredOrderByAdmin(ExternallyDeliveredOrderCreateByAdminRequest $request): int|ExternallyDeliveredOrderEntity|string
    {
        // 1 check if sending order feature is On.
        $sendOrderExternallyFeatureStatus = $this->checkSendingOrderToExternalDeliveryCompanyFeatureStatus();

        if ($sendOrderExternallyFeatureStatus === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;

        }
//        elseif ($sendOrderExternallyFeatureStatus === AppFeatureStatusConstant::FEATURE_STATUS_FALSE_CONST) {
//            return AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST;
//        }

        // 2 check if external company is exist.
        $externalDeliveryCompany = $this->getExternalDeliveryCompanyById($request->getExternalCompanyId());

        if ($externalDeliveryCompany === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        // 3 Send order to the external company
        $orderEntity = $this->getOrderEntityById($request->getOrderId());

        if ($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        if ($orderEntity->getState() !== OrderStateConstant::ORDER_STATE_PENDING) {
            return OrderResultConstant::ORDER_STATE_IS_NOT_PENDING_CONST;
        }

        $orderCreateResponse = $this->sendOrderToExternalDeliveryCompany($orderEntity, $externalDeliveryCompany,
            $orderEntity->getStoreOrderDetailsEntity());

        if ($orderCreateResponse === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST;
        }

        // 4 According to the response that being resulted from previous step, handle the situation
        $arrayResponse = $this->handleResponseInterface($orderCreateResponse, $request->getExternalCompanyId());

        if (($arrayResponse === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
            || ($arrayResponse === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)
            || ($arrayResponse === HttpResponseConstant::METHOD_NOT_ALLOWED_RESULT_CONST)) {
            return $arrayResponse;
        }

        // 5 Create externally delivered order
        return $this->createExternallyDeliveredOrder($orderEntity, $externalDeliveryCompany, $arrayResponse);
    }

    /**
     * Creates a new order in Street Line and returns the response
     */
    public function createOrderInStreetLine(OrderEntity $orderEntity, StoreOrderDetailsEntity $storeOrderDetailsEntity): ResponseInterface
    {
        return $this->streetLineOrderSendService->createOrderInStreetLine($orderEntity, $storeOrderDetailsEntity);
    }
}
