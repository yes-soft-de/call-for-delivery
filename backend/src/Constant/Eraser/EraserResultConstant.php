<?php

namespace App\Constant\Eraser;

final class EraserResultConstant
{
    const BID_ORDERS_IMAGES_PRICE_OFFERS_DELETE_RESULT = "Bid orders, their images, and their prices offers deleted successfully";

    const DELETION_USER_PASSWORD_INCORRECT = "incorrectDeletionUserPassword";

    const CAN_NOT_DELETE_USER_HAS_ORDERS = "canNotDeleteUseWhoHasOrders";

    const CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS = "canNotDeleteUseWhoHasCashOrdersPayments";

    const CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES = "canNotDeleteUseWhoHasFinancialDues";

    const CAN_NOT_DELETE_USER_HAS_PAYMENTS = "canNotDeleteUseWhoHasPayments";

    const CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY = "canNotDeleteUseWhoHasPaymentsToCompany";

    const CAN_NOT_DELETE_STORE_HAS_DUES_FROM_CASH_ORDERS = 0;

    const CAN_NOT_DELETE_STORE_HAS_PAYMENTS = 1;

    const CAN_NOT_DELETE_STORE_HAS_PAYMENTS_FROM_COMPANY = 2;

    const STORE_HAS_NOT_ORDERS = 3;

    const STORE_HAS_ORDERS = 4;

    const CAPTAIN_ACCOUNT_AND_PROFILE_CAN_BE_DELETED = 5;
}
