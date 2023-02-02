<?php

namespace App\Manager\DirectSupportScript;

use App\Repository\DirectSupportScriptEntityRepository;
use App\Request\DirectSupportScript\DirectSupportScriptFilterRequest;

class DirectSupportScriptManager
{
    public function __construct(
        private DirectSupportScriptEntityRepository $directSupportScriptEntityRepository
    )
    {
    }

    public function filterDirectSupportScript(DirectSupportScriptFilterRequest $request): array
    {
        return $this->directSupportScriptEntityRepository->filterDirectSupportScript($request);
    }
}
