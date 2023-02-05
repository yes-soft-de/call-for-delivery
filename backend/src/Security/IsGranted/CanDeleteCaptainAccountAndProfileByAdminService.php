<?php

namespace App\Security\IsGranted;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueResultConstant;
use App\Constant\Eraser\EraserResultConstant;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\CaptainPayment\CaptainPaymentToCompanyService;
use App\Service\Order\OrderService;

class CanDeleteCaptainAccountAndProfileByAdminService
{
    private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService;
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private CaptainPaymentService $captainPaymentService;
    private CaptainPaymentToCompanyService $captainPaymentToCompanyService;
    private OrderService $orderService;

    public function __construct(CaptainAmountFromOrderCashService $captainAmountFromOrderCashService, CaptainFinancialDuesService $captainFinancialDuesService,
                                CaptainPaymentService $captainPaymentService, CaptainPaymentToCompanyService $captainPaymentToCompanyService, OrderService $orderService)
    {
        $this->captainAmountFromOrderCashService = $captainAmountFromOrderCashService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainPaymentToCompanyService = $captainPaymentToCompanyService;
        $this->orderService = $orderService;
    }

    /**
     * This function just check if captain account and profile can be deleted
     * captainId refers to the id of the user record
     */
    public function checkIfCaptainAccountAndProfileCanBeDeletedByCaptainId(int $captainId): int|string
    {
        // Check if there are cash orders payments for the captain
        $cashOrdersPayments = $this->captainAmountFromOrderCashService->getCashOrdersPaymentsByCaptainId($captainId);

        if (count($cashOrdersPayments) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS;
        }

        // check if there are financial dues for the captain
        // $financialDues = $this->captainFinancialDuesService->getFinancialDuesByCaptainId($captainId);

        //if (count($financialDues) !== 0) {
          //  return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES;
        //}

        // Check if the financial dues of the captain (if exists) are more than zero
        // $financialDuesSumResult = [amount, amount for store]
        $financialDuesSumResult = $this->captainFinancialDuesService->getFinancialDuesSumByCaptainId($captainId);

        if (count($financialDuesSumResult) > 0) {
            if (($financialDuesSumResult[1] !== null) || ($financialDuesSumResult[2] !== null)) {
                // financial dues are exists
                // check if they equal zero or not
                if (($financialDuesSumResult[1] > 0) || ($financialDuesSumResult[2] > 0)) {
                    return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES;
                }

                return CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_HAVE_ZERO_VALUE_CONST;
            }
        }

        // check if there are payments for the captain
        $payments = $this->captainPaymentService->getPaymentsByCaptainId($captainId);

        if (count($payments) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS;
        }

        // check if there are payments to the company for the captain
        $paymentsToCompany = $this->captainPaymentToCompanyService->getPaymentToCompanyByCaptainId($captainId);

        if (count($paymentsToCompany) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY;
        }

        // check if there is no orders
        $orders = $this->orderService->getOrdersByCaptainId($captainId);

        if (count($orders) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_ORDERS;
        }

        return EraserResultConstant::CAPTAIN_ACCOUNT_AND_PROFILE_CAN_BE_DELETED;
    }
}
