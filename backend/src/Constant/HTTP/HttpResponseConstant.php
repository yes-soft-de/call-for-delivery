<?php

namespace App\Constant\HTTP;

final class HttpResponseConstant
{
    const SUCCESSFULLY_CREATED_STATUS_CODE_CONST = 201;

    const INVALID_CREDENTIALS_STATUS_CODE_CONST = 401;

    const INVALID_INPUT_STATUS_CODE_CONST = 422;

    const ORDER_NOT_FOUND_STATUS_CODE_CONST = 404;

    const ORDER_FOUND_STATUS_CODE_CONST = 200;

    // constants for using as an internal result const
    const INVALID_INPUT_RESULT_CODE_CONST = 219;

    const INVALID_CREDENTIALS_RESULT_CONST = 220;

    const UN_RECOGNIZED_STATUS_CODE_RESULT_CONST = 221;

    const ORDER_NOT_FOUND_RESULT_CONST = 222;
}
