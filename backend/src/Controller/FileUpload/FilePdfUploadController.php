<?php

namespace App\Controller\FileUpload;

use App\Constant\File\FileTypeConstant;
use App\Request\File\UploadPDFFileRequest;
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
    private UploadFileService $uploadFile;
    private ValidatorInterface $validator;

    public function __construct(UploadFileService $uploadFile, ValidatorInterface $validator)
    {
        $this->uploadFile = $uploadFile;
        $this->validator = $validator;
    }

    /**
     * @Route("uploadpdffile", name="uploadPDFFile", methods={"POST"})
     * @param Request $request
     * @return jsonResponse
     *
     * @OA\Tag(name="PDF File Upload")
     *
     * @OA\RequestBody(
     *      description="Upload a PDF file",
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
    public function pdfFileUpload(Request $request): JsonResponse
    {
        $uploadedFile = $request->files->get('file');

        if ($uploadedFile) {
            $imageUploadRequest = new UploadPDFFileRequest();

            $imageUploadRequest->setUploadedFile($uploadedFile);

            $violations = $this->validator->validate($imageUploadRequest);
            if (count($violations) > 0) {
                $violationsString = (string) $violations;

                return new JsonResponse($violationsString, Response::HTTP_OK);
            }

            $filePath = $this->uploadFile->uploadImage($uploadedFile, FileTypeConstant::PDF_FILE_TYPE_CONST, null);

            return new JsonResponse($filePath, Response::HTTP_OK);
        }
    }
}
