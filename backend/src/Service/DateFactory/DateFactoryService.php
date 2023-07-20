<?php

namespace App\Service\DateFactory;

use App\Constant\DateFactory\DateFactoryMonthConstant;
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

    /**
     * Get last seven days dates (without time) depending on optional time zone
     */
    public function getLastSevenDaysDatesAsArrayAndDependingOnOptionalTimeZone(string $timeZone = null): array
    {
        return [
            (new DateTime('now'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-1 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-2 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-3 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-4 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-5 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d'),
            (new DateTime('-6 day'))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d')
        ];
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

    /**
     * Converts a string date to a DateTime object, and return it with another 30-days date
     */
    public function getDateTimeObjectOfStringObjectPlusThirtyDays(string $stringDate): array
    {
        $dateTime = new DateTime($stringDate);

        return [$dateTime, $dateTime->modify('+30 day')];
    }

    /**
     * Get array of the start and end dates of each month of an array
     */
    public function getStartAndEndDateTimeOfEachMonthByYear(string $year, string $timeZone = null): array
    {
        return [
                [DateFactoryMonthConstant::JANUARY_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::JANUARY_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                (new DateTime($year.DateFactoryMonthConstant::JANUARY_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::FEBRUARY_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::FEBRUARY_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::FEBRUARY_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::MARCH_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::MARCH_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::MARCH_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::APRIL_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::APRIL_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::APRIL_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::MAY_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::MAY_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::MAY_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::JUNE_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::JUNE_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::JUNE_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::JULY_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::JULY_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::JULY_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::AUGUST_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::AUGUST_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::AUGUST_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::SEPTEMBER_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::SEPTEMBER_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::SEPTEMBER_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::OCTOBER_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::OCTOBER_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::OCTOBER_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::NOVEMBER_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::NOVEMBER_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::NOVEMBER_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],

                [DateFactoryMonthConstant::DECEMBER_MONTH_CONST,
                    (new DateTime($year.DateFactoryMonthConstant::DECEMBER_MONTH_CONST."01"." "."00:00:00"))->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i'),
                    (new DateTime($year.DateFactoryMonthConstant::DECEMBER_MONTH_CONST."01"." "."23:59:59"))->modify('last day of this month')->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC'))->format('Y-m-d h:m:i')],
        ];
    }

    public function getDateOnlyFromStringDateTime(string $dateTime): DateTime
    {
        return (new DateTime(date("Y-m-d", strtotime($dateTime))));
    }

    public function checkIfTimeIsBetweenSpecificTwoTime(DateTimeInterface $fromDate, DateTimeInterface $toDate, DateTimeInterface $specificDate, string $timeZone = null): bool
    {
        $fromTime = new DateTime(strftime('%T', $fromDate->getTimestamp()));
        $toTime = new DateTime(strftime('%T', $toDate->getTimestamp()));
        $specificTime = new DateTime(strftime('%T', $specificDate->getTimestamp()));

        if ((date_timestamp_get($specificTime) >= date_timestamp_get($fromTime))
            && (date_timestamp_get($specificTime) <= date_timestamp_get($toTime))) {
            return true;
        }

        return false;
    }

    public function getStartAndEndDateTimeOfToday(string $timeZone = null): array
    {
        $today = new DateTime('today');

        $startOfToday = clone $today;
        $startOfToday->setTimezone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));

        $endOfToday = clone $today;
        $endOfToday->setTime(23, 59, 59);
        $endOfToday->setTimezone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));

        return [$startOfToday, $endOfToday];
    }

    public function getDateTimeOfToday(string $timeZone = null): DateTime
    {
        return (new DateTime('today'))->setTimezone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
    }
}
