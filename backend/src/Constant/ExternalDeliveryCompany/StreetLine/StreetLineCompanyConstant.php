<?php

namespace App\Constant\ExternalDeliveryCompany\StreetLine;

final class StreetLineCompanyConstant
{
    const PICKUP_LAT_FIELD_CONST = "pickup_lat";

    const PICKUP_LNG_FIELD_CONST = "pickup_lng";

    const CUSTOMER_LAT_FIELD_CONST = "lat";

    const CUSTOMER_LNG_FIELD_CONST = "lng";

    const PAYMENT_TYPE_FIELD_CONST = "payment_type";

    const CUSTOMER_PHONE_FIELD_CONST = "customer_phone";

    const ORDER_VALUE_FIELD_CONST = "value";

    const CUSTOMER_NAME_FIELD_CONST = "customer_name";

    const ORDER_DETAILS_FIELD_CONST = "details";

    const ORDER_DELIVER_AT_FIELD_CONST = "deliver_at";

    const CLIENT_ORDER_ID_FIELD_CONST = "client_order_id";

    const SHOP_ID_FIELD_CONST = "ingr_shop_id";

    const SHOP_NAME_FIELD_CONST = "ingr_shop_name";

    const PICKUP_ID_FIELD_CONST = "pickup_id";
    // order status
    const ORDER_CREATED_STATUS_CONST = "Order created";

    const PENDING_DRIVER_ACCEPTANCE_STATUS_CONST = "Pending driver acceptance";

    const PENDING_ORDER_PREPARATION_STATUS_CONST = "Pending order preparation";

    const ARRIVED_TO_PICKUP_STATUS_CONST = "Arrived to pickup";

    const ORDER_PICKED_UP_STATUS_CONST = "Order picked up";

    const ARRIVED_TO_DROP_OFF_STATUS_CONST = "Arrived to dropoff";

    const ORDER_DELIVERED_STATUS_CONST = "Order delivered";

    const ORDER_CANCELLED_STATUS_CONST = "Order cancelled";

    const DRIVER_ACCEPTANCE_TIMEOUT_STATUS_CONST = "Driver acceptance timeout";

    const DRIVER_REJECTED_ORDER_STATUS_CONST = "Driver rejected the order";

    const ORDER_UNASSIGNED_STATUS_CONST = "Order Unassigned";

    const ORDER_FAILED_STATUS_CONST = "Order failed";
}
