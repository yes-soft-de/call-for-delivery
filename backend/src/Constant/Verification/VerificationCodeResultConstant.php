<?php

namespace App\Constant\Verification;

final class VerificationCodeResultConstant
{
    const INCORRECT_ENTERED_DATA_RESULT = "incorrectEnteredData";

    const ACTIVATED_RESULT = "activated";

    const NOT_VALID_CODE_DATE_RESULT = "codeDateIsNotValid";

    const NEW_CODE_WAS_CREATED = "newCodeWasCreated";

    const USER_ALREADY_VERIFIED = "userAlreadyVerified";

    const VERIFICATION_CODE_WAS_NOT_CREATED_SUCCESSFULLY = "verificationCodeWasNotCreatedSuccessfully";
}
