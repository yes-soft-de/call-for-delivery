<?php

namespace App\Constant\ExternalDeliveryCompany\Mrsool;

final class MrsoolCompanyConstant
{
    // URL constant
    // dev
    const BASE_URL_CONST = "https://api.staging.mrsool.co/";

    const CREATE_ORDER_URL_CONST = "laas/v1/orders";

    const GET_ORDER_URL_CONST = "laas/v1/orders/";

    // prod
    const BASE_URL_PROD_CONST = "https://logistics.mrsool.co/";

    const CREATE_ORDER_PROD_URL_CONST = "api/v1/orders";

    const GET_ORDER_PROD_URL_CONST = "api/v1/orders/";

    // Post order request
    const PICKUP_FIELD_CONST = "pickup";

    const DROPOFF_FIELD_CONST = "dropoff";

    const BUYER_FIELD_CONST = "buyer";

    const STORE_FIELD_CONST = "store";

    const SHIPMENT_VALUE_FIELD_CONST = "shipment_value";

    const DESCRIPTION_FIELD_CONST = "description";

    const LATITUDE_FIELD_CONST = "latitude";

    const LONGITUDE_FIELD_CONST = "longitude";

    const PHONE_FIELD_CONST = "phone";

    const FULL_NAME_FIELD_CONST = "full_name";

    const NAME_FIELD_CONST = "name";

    const ORDER_DEFAULT_DESCRIPTION_CONST = "The order had been created by C4D Store application";

    // order status
    const COURIER_PENDING_ORDER_STATUS_CONST = "COURIER_PENDING";

    const COLLECTING_ORDER_STATUS_CONST = "COLLECTING";

    const DELIVERING_ORDER_STATUS_CONST = "DELIVERING";

    const DROPOFF_ARRIVED_ORDER_STATUS_CONST = "DROPOFF_ARRIVED";

    const DELIVERED_ORDER_STATUS_CONST = "DELIVERED";

    const CANCELED_ORDER_STATUS_CONST = "CANCELED";

    const EXPIRED_ORDER_STATUS_CONST = "EXPIRED";

    const ONGOING_ORDER_CONST = [
        self::COLLECTING_ORDER_STATUS_CONST,
        self::DELIVERING_ORDER_STATUS_CONST,
        self::DROPOFF_ARRIVED_ORDER_STATUS_CONST
    ];

    const NOT_CANCELLED_OR_DELIVERED_OR_EXPIRED_CONST = [
        self::COURIER_PENDING_ORDER_STATUS_CONST,
        self::COLLECTING_ORDER_STATUS_CONST,
        self::DELIVERING_ORDER_STATUS_CONST,
        self::DROPOFF_ARRIVED_ORDER_STATUS_CONST
    ];

}
