<?php

namespace App\Manager\Admin\ExternallyDeliveredOrder;

use App\Entity\ExternallyDeliveredOrderEntity;
use App\Repository\ExternallyDeliveredOrderEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminExternallyDeliveredOrderManager
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ExternallyDeliveredOrderEntityRepository $externallyDeliveredOrderEntityRepository
    )
    {
    }

    public function getExternallyDeliveredOrdersByExternalDeliveryCompanyId(int $externallyDeliveryCompanyId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['externalDeliveryCompany' => $externallyDeliveryCompanyId]);
    }

    public function getExternallyDeliveredOrdersByOrderId(int $orderId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['orderId' => $orderId]);
    }

    public function updateExternallyDeliveredOrderStatusById(int $id, string $status): ?ExternallyDeliveredOrderEntity
    {
        $externallyDeliveredOrder = $this->externallyDeliveredOrderEntityRepository->findOneBy(['id' => $id]);

        if ($externallyDeliveredOrder) {
            $externallyDeliveredOrder->setStatus($status);

            $this->entityManager->flush();
        }

        return $externallyDeliveredOrder;
    }

    public function getLastExternallyDeliveredOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['orderId' => $orderId,
            'externalDeliveryCompany' => $externalDeliveryCompanyId], ['id' => 'DESC'], 1);
    }
}
