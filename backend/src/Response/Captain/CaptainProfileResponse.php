<?php

namespace App\Response\Captain;

class CaptainProfileResponse
{
    public int $captainId;

    public null|string $captainName;

    public  null|array $images;

    public null|array $location = [];

    public null|int $age;

    public null|string $car;

    public null|float $salary;

    public null|string $status;
   
    public null|float $bounce;
   
    public null|string $phone;

    public bool $isOnline;
   
    public null|string $bankName;
   
    public null|string $bankAccountNumber;

    public null|string $stcPay;
   
    public null|array $mechanicLicense;
    
    public  null|array $identity;

    public  null|array $drivingLicence;

    public string $roomId;
}
