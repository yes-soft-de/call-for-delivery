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
}
