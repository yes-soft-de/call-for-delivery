<?php

namespace App\Manager\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
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

    public function getExternallyDeliveredOrdersByStatus(string $status): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['status' => $status]);
    }

    public function getOnGoingExternallyDeliveredOrders(): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['status' => MrsoolCompanyConstant::ONGOING_ORDER_CONST]);
    }

    public function getAllExternallyDeliveredOrdersByOrderId(int $orderId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['orderId' => $orderId]);
    }

    public function getExternallyDeliveredOrderByExternalOrderId(int $externalOrderId): ?ExternallyDeliveredOrderEntity
    {
        return $this->externallyDeliveredOrderEntityRepository->findOneBy(['externalOrderId' => $externalOrderId,
            'externalDeliveryCompany' => 1]);
    }
}
