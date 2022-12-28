<?php

namespace App\Request\Admin\Account;

class CompleteAccountStatusUpdateByAdminRequest
{
    private int $profileId;

    private string $completeAccountStatus;

    public function getProfileId(): int
    {
        return $this->profileId;
    }

    public function setProfileId(int $profileId)
    {
        $this->profileId = $profileId;
    }

    public function getCompleteAccountStatus(): string
    {
        return $this->completeAccountStatus;
    }

    public function setCompleteAccountStatus(string $completeAccountStatus)
    {
        $this->completeAccountStatus = $completeAccountStatus;
    }
}
