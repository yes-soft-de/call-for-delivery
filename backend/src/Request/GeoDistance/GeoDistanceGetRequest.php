<?php

namespace App\Request\GeoDistance;

class GeoDistanceGetRequest
{
    private float $originLat;

    private float $originLng;

    private float $destinationLat;

    private float $destinationLng;

    public function getOriginLat(): float
    {
        return $this->originLat;
    }

    public function getOriginLng(): float
    {
        return $this->originLng;
    }

    public function getDestinationLat(): float
    {
        return $this->destinationLat;
    }

    public function getDestinationLng(): float
    {
        return $this->destinationLng;
    }
}
