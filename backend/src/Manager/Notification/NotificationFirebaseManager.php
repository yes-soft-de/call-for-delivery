<?php


namespace App\Manager\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Repository\NotificationFirebaseTokenEntityRepository;
use App\Request\Notification\NotificationFirebaseTokenCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;

class NotificationFirebaseManager
{
    private $autoMapping;
    private $entityManager;
    private $notificationLocalEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationFirebaseTokenEntityRepository = $notificationFirebaseTokenEntityRepository;
    }

    public function createNotificationFirebaseToken(NotificationFirebaseTokenCreateRequest $request)
    {
        $create = $this->autoMapping->map(NotificationFirebaseTokenRequest::class, NotificationFirebaseTokenEntity::class, $request);

        $item = $this->notificationFirebaseTokenEntityRepository->findBy(['userID' => $request->getUserID()]);
        if ($item)
        {
            $this->entityManager->remove($item[0]);
            $this->entityManager->flush();
        }

        $this->entityManager->persist($create);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $create;
    }

    public function getCaptainTokens()
    {
        return $this->notificationTokenEntityRepository->getCaptainTokens();
    }

    public function getAdminsTokens()
    {
        return $this->notificationTokenEntityRepository->getAdminsTokens();
    }

    public function getAnonymouseNameByChaRoomID($chatRoomID)
    {
        return $this->notificationTokenEntityRepository->getAnonymouseNameByChaRoomID($chatRoomID);
    }

    public function getStoreTokens($storeIDs)
    {
        return $this->notificationTokenEntityRepository->getStoreTokens($storeIDs);
    }

    public function deleteToken($id)
    {
        $item = $this->notificationTokenEntityRepository->find($id);

        if ($item)
        {
            $this->entityManager->remove($item);
            $this->entityManager->flush();
        }
    }

    public function getNotificationTokenByUserID($userID)
    {
        $token = $this->notificationTokenEntityRepository->findBy(['userID' => $userID]);

        return $token[0]->getToken();
    }

    public function getClientNameByUserID($userID)
    {
        return $this->notificationTokenEntityRepository->getClientNameByUserID($userID);

    }

    public function getAnonymousToken($anonymousChatID)
    {
        return $this->notificationTokenEntityRepository->getAnonymousToken($anonymousChatID);
    }
}
