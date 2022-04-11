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
   
    const TOTAL_IS_MAIN_YES = "yes";

    const TOTAL_IS_MAIN_NO = "no";
}
