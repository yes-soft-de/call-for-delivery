<?php

namespace App\Controller\Order;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateRequest;
use App\Service\Order\OrderService;
use Doctrine\ORM\NonUniqueResultException;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * Create and fetch order.
 * @Route("v1/order/")
 */
class OrderController extends BaseController
{
    public function __construct(SerializerInterface $serializer, private AutoMapping $autoMapping, private ValidatorInterface $validator, private OrderService $orderService)
    {
        parent::__construct($serializer);
    }
}
