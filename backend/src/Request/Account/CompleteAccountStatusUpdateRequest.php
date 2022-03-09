<?php

namespace App\Request\Account;

class CompleteAccountStatusUpdateRequest
{
    private string $userId;

    private string $completeAccountStatus;

    /**
     * @return string|null
     */
    public function getUserId(): ?string
    {
        return $this->userId;
    }

    public function setUserId($userId)
    {
        $this->userId = $userId;
    }

    /**
     * @return string|null
     */
    public function getCompleteAccountStatus(): ?string
    {
        return $this->completeAccountStatus;
    }

    public function setCompleteAccountStatus($completeAccountStatus)
    {
        $this->completeAccountStatus = $completeAccountStatus;
    }
}
