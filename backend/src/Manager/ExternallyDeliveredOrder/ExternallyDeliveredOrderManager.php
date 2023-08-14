<?php

namespace App\Manager\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Repository\ExternallyDeliveredOrderEntityRepository;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateRequest;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderStatusUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ExternallyDeliveredOrderManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private ExternallyDeliveredOrderEntityRepository $externallyDeliveredOrderEntityRepository
    )
    {
    }

    public function createExternallyDeliveredOrder(ExternallyDeliveredOrderCreateRequest $request): ExternallyDeliveredOrderEntity
    {
        $externallyDeliveredOrderEntity = $this->autoMapping->map(ExternallyDeliveredOrderCreateRequest::class,
            ExternallyDeliveredOrderEntity::class, $request);

        $this->entityManager->persist($externallyDeliveredOrderEntity);
        $this->entityManager->flush();

        return $externallyDeliveredOrderEntity;
    }

    public function updateExternallyDeliveredOrderStatus(ExternallyDeliveredOrderStatusUpdateRequest $request)
    {
        $externallyDeliveredOrderEntity = $this->externallyDeliveredOrderEntityRepository->findOneBy(['id' => $request->getId()]);

        if ($externallyDeliveredOrderEntity) {
            $externallyDeliveredOrderEntity = $this->autoMapping->mapToObject(ExternallyDeliveredOrderStatusUpdateRequest::class,
                ExternallyDeliveredOrderEntity::class, $request, $externallyDeliveredOrderEntity);

            $this->entityManager->flush();
        }

        return $externallyDeliveredOrderEntity;
    }

    public function getAllExternallyDeliveredOrdersByOrderId(int $orderId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['orderId' => $orderId]);
    }

    /**
     * Gets Externally Delivered Order By External Order Id And External Company Id
     */
    public function getExternallyDeliveredOrderByExternalOrderIdAndExternalCompanyId(int $externalOrderId, int $externalCompanyId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderEntityRepository->findOneBy(['externalOrderId' => $externalOrderId,
            'externalDeliveryCompany' => $externalCompanyId]);
    }

    public function updateExternallyDeliveredOrderStatusByExternalOrderIdAndExternalCompanyId(int $externalOrderId, int $externalDeliveryCompanyId, string $status): int|ExternallyDeliveredOrderEntity
    {
        $externalOrder = $this->externallyDeliveredOrderEntityRepository->findOneBy(['externalOrderId' => $externalOrderId,
            'externalDeliveryCompany' => $externalDeliveryCompanyId]);

        if ($externalOrder) {
            $externalOrder->setStatus($status);

            $this->entityManager->flush();
        }

        return $externalOrder;
    }
}
