<?php

namespace App\Constant\EPaymentFromStore;

final class EPaymentFromStoreConstant
{
    // payment getaway
    const PAYMENT_GETAWAY_IN_APP_PURCHASE_APPLE_CONST = 225;

    const PAYMENT_GETAWAY_IN_APP_PURCHASE_GOOGLE_CONST = 226;

    const PAYMENT_GETAWAY_TAP_PAYMENT_CONST = 227;

    // used when testing or payment pass by admin
    const PAYMENT_GETAWAY_NOT_SPECIFIED_CONST = 235;

    const PAYMENT_GETAWAY_MANUAL_CONST = 236;

    // payment for what
    // the payment is for opening package
    const PAYMENT_FOR_SUBSCRIPTION_CONST = 228;
    // the payment is for uniform subscription
    const PAYMENT_FOR_UNIFORM_SUBSCRIPTION_CONST = 229;

    // payment type
    const REAL_PAYMENT_BY_STORE_CONST = 229;

    const REAL_PAYMENT_BY_ADMIN_CONST = 230;

    const MOCK_PAYMENT_BY_STORE_CONST = 231;

    const MOCK_PAYMENT_BY_ADMIN_CONST = 232;

    const MOCK_PAYMENT_BY_SUPER_ADMIN_CONST = 233;

    // *** Log Constant ***
    // action
    const NEW_REAL_PAYMENT_CREATED_SUCCESSFULLY_BY_ADMIN_ACTION_CONST = 252;

    const NEW_REAL_PAYMENT_CREATED_SUCCESSFULLY_BY_STORE_ACTION_CONST = 253;

    const NEW_REAL_PAYMENT_CREATED_FAILED_BY_STORE_ACTION_CONST = 254;

    const NEW_REAL_PAYMENT_CREATED_FAILED_BY_ADMIN_ACTION_CONST = 255;

}
