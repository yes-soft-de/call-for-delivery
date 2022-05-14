<?php

namespace App\Response\SupplierCategory;

use OpenApi\Annotations as OA;

class SupplierCategoryForStoreOwnerGetResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $name;

    /**
     * @var string|null
     */
    public $description;

    /**
     * @var bool|null
     */
    public $status;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $image;
}
