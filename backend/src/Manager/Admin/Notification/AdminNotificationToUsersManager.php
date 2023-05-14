<?php

namespace App\Manager\Admin\Notification;

use App\AutoMapping;
use App\Entity\AdminNotificationToUsersEntity;
use App\Repository\AdminNotificationToUsersEntityRepository;
use App\Request\Admin\Notification\AdminNotificationCreateRequest;
use App\Request\Admin\Notification\AdminNotificationUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Constant\Notification\NotificationConstant;

class AdminNotificationToUsersManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AdminNotificationToUsersEntityRepository $adminNotificationToUsersEntityRepository
    )
    {
    }

    public function createAdminNotificationToUsers(AdminNotificationCreateRequest $request): AdminNotificationToUsersEntity
    {
        $adminNotificationToUsersEntity = $this->autoMapping->map(AdminNotificationCreateRequest::class, AdminNotificationToUsersEntity::class, $request);
        $adminNotificationToUsersEntity->setUserId(0);
       
        $this->entityManager->persist($adminNotificationToUsersEntity);
        $this->entityManager->flush();

        return $adminNotificationToUsersEntity;
    }

    public function updateAdminNotification(AdminNotificationUpdateRequest $request): string|AdminNotificationToUsersEntity
    {
        $adminNotificationToUsersEntity = $this->adminNotificationToUsersEntityRepository->find($request->getId());

        if (! $adminNotificationToUsersEntity) {
            return NotificationConstant::NOT_FOUND;
        } 
        
        $entity = $this->autoMapping->mapToObject(AdminNotificationUpdateRequest::class, AdminNotificationToUsersEntity::class, $request, $adminNotificationToUsersEntity);

        $this->entityManager->flush();

        return $entity;
    }

    public function deleteAdminNotification($id): string|AdminNotificationToUsersEntity
    {
        $adminNotificationToUsersEntity = $this->adminNotificationToUsersEntityRepository->find($id);

        if (! $adminNotificationToUsersEntity) {
            return NotificationConstant::NOT_FOUND;
        } 

        $this->entityManager->remove($adminNotificationToUsersEntity);
    
        $this->entityManager->flush();

        return $adminNotificationToUsersEntity;
    }

    public function getAllNotificationsForAdmin(): array
    {
        return $this->adminNotificationToUsersEntityRepository->findBy(['userId' => NotificationConstant::USER_ID_NULL],
            ['id' => 'DESC']);
    }

    public function getNotificationByIdForAdmin(int $id): AdminNotificationToUsersEntity|null
    {
        return $this->adminNotificationToUsersEntityRepository->find($id);
    }
}
