<?php

namespace App\Controller\Image;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Image\ImageCreateRequest;
use App\Service\Image\ImageService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/imagetest/")
 */
class ImageController extends BaseController
{
    public function __construct(SerializerInterface $serializer, private AutoMapping $autoMapping, private ValidatorInterface $validator, private ImageService $imageService)
    {
        parent::__construct($serializer);
    }

    /**
     * Create new image. THIS JUST FOR TESTING CREATE IMAGE FUNCTIONS
     * @Route("create", name="createImage", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Image Test")
     *
     * @OA\RequestBody(
     *      description="Create new image",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="imagePath"),
     *          @OA\Property(type="string", property="entityType"),
     *          @OA\Property(type="string", property="imageAim"),
     *          @OA\Property(type="integer", property="itemId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new image info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="imagePath"),
     *                  @OA\Property(type="string", property="entityType"),
     *                  @OA\Property(type="string", property="imageAim"),
     *                  @OA\Property(type="integer", property="itemId")
     *          )
     *      )
     * )
     */
    public function createImage(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ImageCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->imageService->create($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * Get images. THIS JUST FOR TESTING CREATE IMAGE FUNCTIONS
     * @Route("images/{itemId}/{entityType}/{imageAim}", name="getImagesByItemIdAndEntityTypeAndImageAim", methods={"GET"})
     * @param int $itemId
     * @param string $entityType
     * @param string $imageAim
     * @return JsonResponse
     *
     * @OA\Tag(name="Image Test")
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the images info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="string", property="entityType"),
     *                  @OA\Property(type="string", property="imageAim"),
     *                  @OA\Property(type="integer", property="itemId")
     *          )
     *      )
     * )
     */
    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, string $entityType, string $imageAim): JsonResponse
    {
        $response = $this->imageService->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $imageAim);

        return $this->response($response, self::CREATE);
    }
}
