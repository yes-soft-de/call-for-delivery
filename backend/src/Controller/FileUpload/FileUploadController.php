<?php

namespace App\Controller\FileUpload;

use App\Request\Image\UploadImageRequest;
use App\Service\FileUpload\UploadFileService;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class FileUploadController extends AbstractController
{
    private $uploadFile;
    private $validator;

    public function __construct(UploadFileService $uploadFile, ValidatorInterface $validator)
    {
        $this->uploadFile = $uploadFile;
        $this->validator = $validator;
    }

    /**
     * @Route("uploadfile", name="fileUpload", methods={"POST"})
     * @param Request $request
     * @return jsonResponse
     *
     * @OA\Tag(name="File Upload")
     *
     * @OA\RequestBody(
     *      description="Upload a file",
     *     @OA\MediaType(
     *          mediaType="multipart/form-data",
     *             @OA\Schema(
     *                 type="object",
     *                   @OA\Property(
     *                     property="image",
     *                     type="image/png"
     *                 )
     *             )
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the path of the image on the host server"
     * )
     */
    public function fileUpload(Request $request): JsonResponse
    {
        $uploadedFile = $request->files->get('image');

        if ($uploadedFile) {
            $imageUploadRequest = new UploadImageRequest();
            $imageUploadRequest->setUploadedFile($uploadedFile);

            $violations = $this->validator->validate($imageUploadRequest);
            if (count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $filePath = $this->uploadFile->uploadImage($uploadedFile, null);

            return new JsonResponse($filePath, Response::HTTP_OK);
        }
    }
}
