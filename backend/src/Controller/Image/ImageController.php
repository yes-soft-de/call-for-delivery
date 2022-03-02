<?php

namespace App\Controller\Image;

use App\Controller\BaseController;
use App\Service\Image\ImageService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/imagetest/")
 */
class ImageController extends BaseController
{
    public function __construct(SerializerInterface $serializer, private ImageService $imageService)
    {
        parent::__construct($serializer);
    }

    /**
     * Get images. THIS JUST FOR TESTING CREATE IMAGE FUNCTIONS
     * @Route("images/{itemId}/{entityType}/{usedAs}", name="getImagesByItemIdAndEntityTypeAndImageAim", methods={"GET"})
     * @param int $itemId
     * @param int $entityType
     * @param int $usedAs
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
     *                  @OA\Property(type="string", property="imagePath"),
     *                  @OA\Property(type="string", property="entityType"),
     *                  @OA\Property(type="string", property="imageAim"),
     *                  @OA\Property(type="integer", property="itemId")
     *          )
     *      )
     * )
     */
    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): JsonResponse
    {
        $response = $this->imageService->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);

        return $this->response($response, self::FETCH);
    }
}
