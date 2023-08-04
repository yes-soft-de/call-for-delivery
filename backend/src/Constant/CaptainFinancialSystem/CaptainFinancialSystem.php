<?php

namespace App\Constant\CaptainFinancialSystem;

final class CaptainFinancialSystem
{
    const CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE = "youHaveFinancialSystem,canNotChooseAnotherFinancialSystemNow";
   
    const CAPTAIN_FINANCIAL_SYSTEM_ACTIVE= true;

    const CAPTAIN_FINANCIAL_SYSTEM_INACTIVE= false;

    // CaptainFinancialSystemAccordingToCountOfHours
    const CAPTAIN_FINANCIAL_SYSTEM_ONE = 1;

    // CaptainFinancialSystemAccordingToCountOfOrders
    const CAPTAIN_FINANCIAL_SYSTEM_TWO = 2;
    
    // CaptainFinancialSystemAccordingOnOrderEntity
    const CAPTAIN_FINANCIAL_SYSTEM_THREE = 3;

    // CaptainFinancialDefaultSystemEntity
    const CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST = 4;

    const YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM = "youNotHaveCaptainFinancialSystem";
    
    //It is recommended to add this field to the entity
    const KILOMETER_TO_DOUBLE_ORDER = 19;
   
    const ADVANCE_PAYMENT_YES = true;

    const ADVANCE_PAYMENT_NO = false;

    // const TARGET_SUCCESS = "success";
    const TARGET_SUCCESS = "حققت الهدف";

    // const TARGET_SUCCESS_AND_INCREASE = "successTheTargetAndIncrease";
    const TARGET_SUCCESS_AND_INCREASE = "حققت الهدف و زيادة";

    // const TARGET_NOT_ARRIVED = "notArrivedYet";
    const TARGET_NOT_ARRIVED = "لم تصل للهدف بعد";

    // const TARGET_FAILED = "failed";
    const TARGET_FAILED = "لم تحقق الهدف";

    const TARGET_FAILED_SALARY = 12.86;

    const COUNT_REMAINING_ORDER = "The count of remaining orders";

    const FOR_BOUNCE = "for a bonus";

    const CONGRATULATIONS_CAPTAIN= "congratulations, you got the bonus";

    const CAPTAIN_GOT_BOUNCE_ADMIN= "captain's got the bonus";

    const FINANCIAL_SYSTEM_INACTIVE = "financial inactive";

    const NOT_UPDATE_FINANCIAL_SYSTEM_ACTIVE = "not update because financial System is active";

    const TARGET_SUCCESS_INT = 1;

    const TARGET_SUCCESS_AND_INCREASE_INT = 2;
  
    const TARGET_FAILED_INT = 3;

    const OK_RESULT_CONST = 'ok';

    const ADVANCED_PAYMENT_BALANCE_CONST = 158;

    const ADVANCED_PAYMENT_NOT_EXIST_CONST = 159;

    const ADVANCED_PAYMENT_EXIST_CONST = 160;

    const CANCELLED_ORDER_DIVISION_FACTOR_CONST = 2.0;

    const FIRST_THREE_CAPTAIN_FINANCIAL_SYSTEMS_ARRAY_CONST = [
        self::CAPTAIN_FINANCIAL_SYSTEM_ONE,
        self::CAPTAIN_FINANCIAL_SYSTEM_TWO,
        self::CAPTAIN_FINANCIAL_SYSTEM_THREE,
    ];

    const CAPTAIN_ORDER_PROFIT_EXIST_CONST = 242;

    const CAPTAIN_FINANCIAL_SYSTEM_IS_NOT_THE_DEFAULT_SYSTEM_CONST = 244;

    const OPERATION_TYPE_ADDITION_CONST = 250;

    const OPERATION_TYPE_SUBTRACTION_CONST = 251;

    const HALF_ORDER_VALUE_CONST = true;
}
