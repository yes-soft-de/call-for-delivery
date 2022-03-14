<?php

namespace App\Controller\Subscription;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Subscription\SubscriptionCaptainOfferService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use Symfony\Component\HttpFoundation\Response;
use stdClass;
use Symfony\Component\Validator\Validator\ValidatorInterface;
/**
 * fetched Captain Offer.
 * @Route("v1/subscription/subscriptioncaptainoffer/")
 */
class SubscriptionCaptainOfferController extends BaseController
{
    private AutoMapping $autoMapping;
    private SubscriptionCaptainOfferService $subscriptionCaptainOfferService;
    private ValidatorInterface $validator;


    public function __construct(SerializerInterface $serializer, SubscriptionCaptainOfferService $subscriptionCaptainOfferService, AutoMapping $autoMapping, ValidatorInterface  $validator)
    {
        parent::__construct($serializer);
        $this->subscriptionCaptainOfferService = $subscriptionCaptainOfferService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }
    
    /**
     * store:Create Subscription Captain Offer.
     * @Route("create", name="createSubscriptionCaptainOffer", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription Captain Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new subscription captain offer create request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="carCount"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="expired"),
     *          @OA\Property(type="number", property="price"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns new captain offer create",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="status"),
     *           @OA\Property(type="integer", property="expired"),
     *           @OA\Property(type="number", property="price"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createSubscriptionCaptainOffer(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubscriptionCaptainOfferCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);

        }
         
        $result = $this->subscriptionCaptainOfferService->createSubscriptionCaptainOffer($request);
       
        if (isset($result->subscriptionState)) {
      
            return $this->response($result, self::ERROR_SUBSCRIPTION_CAN_NOT_CREATE_OFFER);
        }
       
        return $this->response($result, self::CREATE);
    }
}
