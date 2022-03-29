<?php

namespace App\DataFixtures\Processor;

use App\Entity\UserEntity;
use Fidry\AliceDataFixtures\ProcessorInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserProcessor implements ProcessorInterface
{
    private UserPasswordHasherInterface $passwordHasher;

    public function __construct(UserPasswordHasherInterface $passwordHasher)
    {
        $this->passwordHasher = $passwordHasher;
    }

    /**
     * This function for handling issues before persisting fixtures data into database.
     * Ex: hashing user password before inserting user record.
     */
    public function preProcess(string $id, object $object): void
    {
        if (false === $object instanceof UserEntity) {
            return;
        }

        /** @var UserEntity $object */
        $object->setPassword($this->passwordHasher->hashPassword($object, $object->getPassword()));
    }

    public function postProcess(string $id, object $object): void
    {
        // TODO: Implement postProcess() method.
    }
}
