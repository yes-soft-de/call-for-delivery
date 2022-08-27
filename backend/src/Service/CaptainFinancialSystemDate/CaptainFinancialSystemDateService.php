<?php

namespace App\Service\CaptainFinancialSystemDate;

use DateTime;

class CaptainFinancialSystemDateService
{    
    //get date in string format
    public function getFromDateAndToDateForCaptainFinancialSystemOneAndThtree() {
        $date = new datetime('now');
        $fromDate = $date->format('Y-m-d');
        $toDate = $date->format('Y-m-d');

        return ["fromDate" => $fromDate, "toDate" => $toDate];
    }

    //get date from 20 to 19 next month
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
    //get date in date format
    public function getFromDateAndToDate() {
        $date = new datetime('now');
        $fromDate = $date->format('Y-m-d');
        $toDate = $date->format('Y-m-d');

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
        //The captain works for a full 30 days
        $toDate = $date->modify('+30 day')->format('y-m-d');

        return ["fromDate" =>  new datetime($fromDate), "toDate" =>  new datetime($toDate)];
    }
    //Returns the number of days between two dates 
    public function subtractTwoDates(DateTime $firstDate, DateTime $lastDate) : int
    {
        $countDays = 0;
        $difference = $firstDate->diff($lastDate);

        $countDays = $difference?->d; 
        if($difference?->d === 0 && $difference?->h === 23 && $difference?->i === 59 && $difference?->s === 59) {
            $countDays += 1;
        }

        return $countDays;
    }

    public function subtractTwoDatesTest(DateTime $firstDate, DateTime $lastDate) : int
    {
        $countDays = 0;
        $difference = $firstDate->diff($lastDate);

        $countDays = $difference?->d; 
        if($difference?->h === 23 && $difference?->i === 59 && $difference?->s === 59) {
            $countDays += 1;
        }

        return $countDays;
    }
}
