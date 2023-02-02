<?php

namespace App\Service\DirectSupportScript;

use App\AutoMapping;
use App\Entity\DirectSupportScriptEntity;
use App\Manager\DirectSupportScript\DirectSupportScriptManager;
use App\Request\DirectSupportScript\DirectSupportScriptFilterRequest;
use App\Response\DirectSupportScript\DirectSupportScriptFilterResponse;

class DirectSupportScriptService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private DirectSupportScriptManager $directSupportScriptManager
    )
    {
    }

    public function filterDirectSupportScript(DirectSupportScriptFilterRequest $request): array
    {
        $directSupportScripts = $this->directSupportScriptManager->filterDirectSupportScript($request);

        if (count($directSupportScripts) > 0) {
            $response = [];

            foreach ($directSupportScripts as $key => $value) {
                $response[$key] = $this->autoMapping->map(DirectSupportScriptEntity::class, DirectSupportScriptFilterResponse::class,
                    $value);

                $response[$key]->adminName = $value->getAdminProfile()->getName();
            }

            return $response;
        }

        return $directSupportScripts;
    }
}
