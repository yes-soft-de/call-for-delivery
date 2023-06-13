<?php

namespace App\Request\Admin\OrderDistanceConflict;

class OrderDistanceConflictRefuseByAdminRequest
{
    private int $id;

    private string $adminNote;

    /**
     * admin profile id
     */
    private int $conflictResolvedBy;

    public function getId(): int
    {
        return $this->id;
    }

    public function setConflictResolvedBy(int $conflictResolvedBy): void
    {
        $this->conflictResolvedBy = $conflictResolvedBy;
    }
}
