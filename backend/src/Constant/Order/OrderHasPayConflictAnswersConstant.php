<?php

namespace App\Constant\Order;

final class OrderHasPayConflictAnswersConstant
{
    /**
     * Following constants are for the field hasPayConflictAnswers of an order
     * which indicates if the order has conflict answers (from store and captain) about cash payments
     */
    const ORDER_HAS_PAYMENT_CONFLICT_ANSWERS = 1;

    const ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS = 2;

    const ORDER_PAYMENT_CONFLICT_ANSWER_RESOLVED_BY_COMMAND = 3;

    const ORDER_PAYMENT_CONFLICT_ANSWER_RESOLVED_BY_API = 4;
}
