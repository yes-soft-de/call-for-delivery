<?php

namespace App\Service\SuperAdmin\Order;

use DateTime;

interface SuperAdminServiceInterface
{
    public function updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand();
    public function updateOrderHasPayConflictAnswersByCommand();
}
