<?php

namespace App\Service\DateFactory;

use DateTime;
use DateTimeInterface;

class DateFactoryService
{
    public function subtractTwoDates($firstDate, $lastDate)
    {
        $difference = $firstDate->diff($lastDate);

        return $this->format_interval($difference);
    }

    public function format_interval($interval)
    {
        $result = "";

        if ($interval->y) { $result .= $interval->format("%y years "); }
        if ($interval->m) { $result .= $interval->format("%m months "); }
        if ($interval->d) { $result .= $interval->format("%d days "); }
        if ($interval->h) { $result .= $interval->format("%h hours "); }
        if ($interval->i) { $result .= $interval->format("%i minutes "); }
        if ($interval->s) { $result .= $interval->format("%s seconds "); }

        return $result;
    }

//    public function getStartAndEndDatesAndTimeOfToday(): array
//    {
//        return [
//            // to get start date and time of today
//            new \DateTime('midnight today'),
//            // to get start date and time of tomorrow
//            new \DateTime('midnight tomorrow')
//        ];
//    }

//    public function getStartAndEndDatesAndTimeOfPreviousWeek(): array
//    {
//        return [
//            // to get start date and time of first day of previous week (last 7 days)
//            new \DateTime("midnight -1 week"),
//            // to get start date and time of yesterday
//            new \DateTime("midnight yesterday")
//        ];
//    }

    public function getDateTimeMinusThirteenMinutesByDateTimeInterface(DateTimeInterface $dateTimeInterface): DateTime|bool
    {
        $dateTime = DateTime::createFromInterface($dateTimeInterface);

        return date_modify($dateTime, '-30 minutes');
    }
}
