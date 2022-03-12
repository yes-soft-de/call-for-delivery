<?php

namespace App\Request\Rate;
use App\Entity\UserEntity;
class RatingCreateRequest
{
    private string $comment;
    
    private int $rating;

    private $rater;
    
    private $rated;

    /**
     * Get the value of rater
     */ 
    public function getRater(): UserEntity|int
    {
        return $this->rater;
    }

    /**
     * Set the value of rater
     *
     * @return  self
     */ 
    public function setRater(UserEntity|int $rater)
    {
        $this->rater = $rater;

        return $this;
    }

    /**
     * Get the value of rated
     */ 
    public function getRated(): UserEntity|int
    {    
        return $this->rated;
    }

    /**
     * Set the value of rated
     *
     * @return  self
     */ 
    public function setRated(UserEntity|int $rated)
    {
        $this->rated = $rated;

        return $this;
    }
}
