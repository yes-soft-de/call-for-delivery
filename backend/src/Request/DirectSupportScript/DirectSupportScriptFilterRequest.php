<?php

namespace App\Request\DirectSupportScript;

class DirectSupportScriptFilterRequest
{
    /**
     * @var int|null
     */
    private $action;

    /**
     * @var int|null
     */
    private $appType;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var null|string
     */
    private $customizedTimezone;

    public function getAction(): ?int
    {
        return $this->action;
    }

    public function getAppType(): ?int
    {
        return $this->appType;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
