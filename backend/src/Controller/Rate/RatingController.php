<?php

namespace App\Controller\Rate;

use App\AutoMapping;
use App\Request\Rate\RatingCreateRequest;
use App\Service\Rate\RatingService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use App\Controller\BaseController;

/**
 * @Route("v1/rating/")
 */
class RatingController extends BaseController
{
    private $autoMapping;
    private $ratingService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, RatingService $ratingService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->ratingService = $ratingService;
        $this->validator = $validator;
    }

    /**
     * store: Create rating.
     * @Route("ratingbystore", name="createRatingByStore", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Rating")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create Rating",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="rater"),
     *          @OA\Property(type="integer", property="rated"),
     *          @OA\Property(type="integer", property="rating"),
     *          @OA\Property(type="string", property="comment"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the new Rating",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="rating"),
     *                  @OA\Property(type="string", property="comment"),
     *          )
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createRatingByStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RatingCreateRequest::class, (object)$data);
        $request->setRater($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->createRating($request);

        return $this->response($result, self::CREATE);
    }
}
