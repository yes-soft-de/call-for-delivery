<?php

namespace App\Service\DateFactory;

use App\Constant\Order\OrderUpdateStateConstant;
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

    public function getSendNotificationDateTimeDependingOnDeliveredDateTime(DateTimeInterface $deliveryDateTimeInterface): DateTime|bool
    {
        $deliveryDateTime = DateTime::createFromInterface($deliveryDateTimeInterface);

        return date_modify($deliveryDateTime, '30 minutes ago');
    }

    public function getLastSevenDaysDatesAsArray(): array
    {
        return [
            (new DateTime('now'))->format('Y-m-d'),
            (new DateTime('-1 day'))->format('Y-m-d'),
            (new DateTime('-2 day'))->format('Y-m-d'),
            (new DateTime('-3 day'))->format('Y-m-d'),
            (new DateTime('-4 day'))->format('Y-m-d'),
            (new DateTime('-5 day'))->format('Y-m-d'),
            (new DateTime('-6 day'))->format('Y-m-d')
        ];
    }

    public function getDateTimeMinusThirteenMinutesByDateTimeInterface(DateTimeInterface $dateTimeInterface): DateTime|bool
    {
        $dateTime = DateTime::createFromInterface($dateTimeInterface);

        return date_modify($dateTime, '-30 minutes');
    }

    public function sumDaysWithDateTimeInterface(DateTimeInterface $dateTimeInterface, int $days): DateTime|bool
    {
        $dateTime = DateTime::createFromInterface($dateTimeInterface);

        return date_modify($dateTime, '+'.$days. 'days');
    }

    public function checkIfDifferenceBetweenDateTimeInterfaceAndDateTimeIsMoreThanSpecificMinutes(DateTimeInterface $oldDateInterface, DateTime $newDate, int $minuets): bool
    {
        $oldDate = DateTime::createFromInterface($oldDateInterface);

        $interval = date_diff($oldDate, $newDate);

        $different_days = $interval->format('%d');

        if ($different_days == 0) {
            $different_hours = $interval->format('%h');

            if ($different_hours <= 1) {
                $different_minutes = $interval->format('%i');

                if ($different_minutes < $minuets) {
                    return true;
                }
            }
        }

        return false;
    }

    public function checkIfDateTimeInterfaceIsBetweenTwoDateTime(DateTimeInterface $dateTime, DateTimeInterface $fromDateTime, DateTimeInterface $toDateTime): bool
    {
        if (($dateTime >= $fromDateTime) && ($dateTime <= $toDateTime)) {
            return true;
        }

        return false;
    }

    public function getDateTimeObjectFromDateTimeInterface(DateTimeInterface $dateTime): DateTime
    {
        return DateTime::createFromInterface($dateTime);
    }

    public function getDaysCountBetweenTwoDatesOfTypeString(string $fromDate, string $toDate): bool|int
    {
        return (new DateTime($fromDate))->diff(new DateTime($toDate))->days;
    }
}
