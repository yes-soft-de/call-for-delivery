<?php

namespace App\Response\Admin\DirectSupportScript;

use DateTime;

class DirectSupportScriptUpdateByAdminResponse
{
    public int $id;

    public int $action;

    public string $message;

    // type of the app that the script relates to
    public int $appType;

    public string $adminName;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
