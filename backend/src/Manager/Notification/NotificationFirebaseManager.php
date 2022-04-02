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
    private $notificationFirebaseTokenEntityRepository;
    private UserManager $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationFirebaseTokenEntityRepository = $notificationFirebaseTokenEntityRepository;
        $this->userManager = $userManager;
    }

    public function createNotificationFirebaseToken(NotificationFirebaseTokenCreateRequest $request): ?NotificationFirebaseTokenEntity
    {
        $notificationFirebaseTokenEntity = $this->notificationFirebaseTokenEntityRepository->findOneBy(['user' => $request->getUserId()]);
      
        if ($notificationFirebaseTokenEntity) {
            $this->entityManager->remove($notificationFirebaseTokenEntity);
            $this->entityManager->flush();
        }

        $notificationFirebaseTokenEntity = $this->autoMapping->map(NotificationFirebaseTokenCreateRequest::class, NotificationFirebaseTokenEntity::class, $request);
          
        $notificationFirebaseTokenEntity->setUser($this->userManager->getUser($request->getUserId()));
      
        $this->entityManager->persist($notificationFirebaseTokenEntity);
        $this->entityManager->flush();

        return $notificationFirebaseTokenEntity;
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
