<?php

namespace App\Controller\Image;

use App\Controller\BaseController;
use App\Service\Image\ImageService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;

/**
 * @Route("v1/image/")
 */
class ImageController extends BaseController
{
    private ImageService $imageService;

    public function __construct(SerializerInterface $serializer, ImageService $imageService)
    {
        parent::__construct($serializer);
        $this->imageService = $imageService;
    }

    /**
     * Get images by specific parameters. THIS JUST FOR TESTING CREATE IMAGE FUNCTIONS
     * @Route("images/{itemId}/{entityType}/{usedAs}", name="getImagesByItemIdAndEntityTypeAndImageAim", methods={"GET"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param int $itemId
     * @param int $entityType
     * @param int $usedAs
     * @return JsonResponse
     *
     * @OA\Tag(name="Image Test")
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the images info which meet the passed parameters",
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
     *                  @OA\Property(type="integer", property="usedAs"),
     *                  @OA\Property(type="integer", property="itemId"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="object", property="updatedAt")
     *          )
     *      )
     * )
     */
    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): JsonResponse
    {
        $response = $this->imageService->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("fetchallimages", name="getAllImages", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Image Test")
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the images info which meet the passed parameters",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Image\ImageGetResponse")
     *              )
     *          )
     *      )
     * )
     */
    public function getAllImages(): JsonResponse
    {
        $response = $this->imageService->getAllImages();

        return $this->response($response, self::FETCH);
    }
}
