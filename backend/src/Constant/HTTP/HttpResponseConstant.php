<?php

namespace App\Constant\HTTP;

final class HttpResponseConstant
{
    // Marsool's Response Status Code
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

    const DONE_SUCCESSFULLY_RESULT_CONST = 256;

    const METHOD_NOT_ALLOWED_RESULT_CONST = 257;

    const REQUEST_NOT_ACCEPTABLE_RESULT_CONST = 258;

    const UNRECOGNIZED_RESPONSE_CONST = 259;
    // Street Line's Response Status Code
    // 200 is returned in multiple APIs when the operation (creating, getting, updated, etc.) is done successfully
    const DONE_SUCCESSFULLY_STATUS_CODE_CONST = 200;

    const METHOD_NOT_ALLOWED_STATUS_CODE_CONST = 405;

    const NOT_ACCEPTABLE_STATUS_CODE_CONST = 406;
}
