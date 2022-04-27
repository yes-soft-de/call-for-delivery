<?php

namespace App\Constant\CaptainFinancialSystem;

final class CaptainFinancialSystem
{
    const CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE = "youHaveFinancialSystem,canNotChooseAnotherFinancialSystemNow";
   
    const CAPTAIN_FINANCIAL_SYSTEM_ACTIVE= true;

    const CAPTAIN_FINANCIAL_SYSTEM_INACTIVE= false;
//CaptainFinancialSystemAccordingToCountOfHours
    const CAPTAIN_FINANCIAL_SYSTEM_ONE = 1;

//CaptainFinancialSystemAccordingToCountOfOrders
    const CAPTAIN_FINANCIAL_SYSTEM_TWO = 2;
    
///CaptainFinancialSystemAccordingOnOrderEntity
    const CAPTAIN_FINANCIAL_SYSTEM_THREE = 3;

    const YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM = "youNotHaveCaptainFinancialSystem";
    
    //It is recommended to add this field to the entity
    const KILOMETER_TO_DOUBLE_ORDER = 19;
   
    const ADVANCE_PAYMENT_YES = true;

    const ADVANCE_PAYMENT_NO = false;

    // const TARGET_SUCCESS = "success";
    const TARGET_SUCCESS = "حققت الهدف";

    // const TARGET_SUCCESS_AND_INCREASE = "successTheTargetAndIncrease";
    const TARGET_SUCCESS_AND_INCREASE = "حققت الهدف و زيادة";

    const TARGET_NOT_ARRIVED = "notArrivedYet";

    // const TARGET_FAILED = "failed";
    const TARGET_FAILED = "لم تحقق الهدف";

    const TARGET_FAILED_SALARY = 12.86;

    const COUNT_REMAINING_ORDER = "The count of remaining orders";

    const FOR_BOUNCE = "for a bonus";

    const CONGRATULATIONS_CAPTAIN= "congratulations, you got the bonus";

    const CAPTAIN_GOT_BOUNCE_ADMIN= "captain's got the bonus";
}
