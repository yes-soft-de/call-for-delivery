<?php

namespace App\Request\Admin\DirectSupportScript;

class DirectSupportScriptDeleteByRequest
{
    private int $id;

    public function getId(): int
    {
        return $this->id;
    }
}
