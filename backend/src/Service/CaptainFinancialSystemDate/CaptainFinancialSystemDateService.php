<?php

namespace App\Service\CaptainFinancialSystemDate;

use DateTime;

class CaptainFinancialSystemDateService
{    
    public function getFromDateAndToDateForCaptainFinancialSystemOneAndThtree() {
        $date = new datetime('now');
        //get 20 month with fromDate)
        $fromDate = $date->format('Y-m-20');
        //get (fromDate) as integer
        $timestamp = strtotime($fromDate);
        //get next Month
        $month = date('m', $timestamp ) + 1;
        ///get 19 next Month
        $toDate = $date->format('Y-'.$month.'-19');

        return ["fromDate" => $fromDate, "toDate" => $toDate];
    }

    public function getFromDateAndToDateForCaptainFinancialSystemTwo() {
        $date = new datetime('now');
        //get 20 month with fromDate)
        $fromDate = $date->format('Y-m-20');
        //get (fromDate) as integer
        $timestamp = strtotime($fromDate);
        //get next Month
        $month = date('m', $timestamp ) + 1;
        ///get 19 next Month
        $toDate = $date->format('Y-'.$month.'-19');

        return ["fromDate" => $fromDate, "toDate" => $toDate];
    }

    public function getFromDateAndToDate() {
        $date = new datetime('now');
        //get 20 month with fromDate)
        $fromDate = $date->format('Y-m-20');
        //get (fromDate) as integer
        $timestamp = strtotime($fromDate);
        //get next Month
        $month = date('m', $timestamp ) + 1;
        ///get 19 next Month
        $toDate = $date->format('Y-'.$month.'-19');

        return ["fromDate" =>  new datetime($fromDate), "toDate" =>  new datetime($toDate)];
    }

    public function getCurrentMonthDate() {
        $date = new datetime('now');

        return (new datetime($date->format('Y-m-d')));
    }

    //Fetch the start and end date of the financial cycle
    public function getStartAndEndDateOfFinancialCycle() {
        $date = new datetime('now');
        $fromDate = $date->format('y-m-d');
        //The captain works for a full 30 days, at the beginning of the 31st day the financial cycle ends
        $toDate = $date->modify('+31 day')->format('y-m-d');

        return ["fromDate" =>  new datetime($fromDate), "toDate" =>  new datetime($toDate)];
    }
}
