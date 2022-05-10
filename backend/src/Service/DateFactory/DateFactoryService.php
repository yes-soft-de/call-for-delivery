<?php

namespace App\Service\DateFactory;


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

   public function subtractTwoDatesHours($firstDate, $lastDate)
   {
      $difference = $firstDate->diff($lastDate);

         return $this->format_interval_hours($difference);
   }

   public function format_interval_hours($interval)
   {
      $result = "";
      if ($interval->h) { $result .= $interval->format("%h"); }
      return $result;
   }
}