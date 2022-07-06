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

class FilePdfUploadController extends AbstractController
{
    private $uploadFile;
    private $validator;

    public function __construct(UploadFileService $uploadFile, ValidatorInterface $validator)
    {
        $this->uploadFile = $uploadFile;
        $this->validator = $validator;
    }

    /**
     * @Route("uploadpdffile", name="filePdfUpload", methods={"POST"})
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
     *                     property="filePdf",
     *                     type="file/pdf"
     *                 )
     *             )
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the path of the file on the host server"
     * )
     */
    public function fileUpload(Request $request): JsonResponse
    {
        $uploadedFile = $request->files->get('filePdf');

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
