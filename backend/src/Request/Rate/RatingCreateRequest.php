<?php

namespace App\Request\Rate;

class RatingCreateRequest
{
    private string $comment;
    
    private int $rating;

    private $rater;
    
    private $rated;

    private int $orderId;

    /**
     * Get the value of rater
     */ 
    public function getRater()
    {
        return $this->rater;
    }

    /**
     * Set the value of rater
     *
     * @return  self
     */ 
    public function setRater($rater)
    {
        $this->rater = $rater;

        return $this;
    }

    /**
     * Get the value of rated
     */ 
    public function getRated()
    {    
        return $this->rated;
    }

    /**
     * Set the value of rated
     *
     * @return  self
     */ 
    public function setRated($rated)
    {
        $this->rated = $rated;

        return $this;
    }

    /**
     * Get the value of orderId
     */ 
    public function getOrderId()
    {
        return $this->orderId;
    }

    /**
     * Set the value of orderId
     *
     * @return  self
     */ 
    public function setOrderId(int $orderId)
    {
        $this->orderId = $orderId;

        return $this;
    }
}
