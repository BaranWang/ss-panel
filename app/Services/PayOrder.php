<?php

namespace App\Services;

use App\Models\User;
use App\Models\PayOrder;
use App\Utils\Tools;

class PayOrder
{
    public static function addOrder($userId,$data)
    {
      $payOrder = new PayOrderModels();
      $payOrder->user_id = $userId;
      $payOrder->data = $data;
      if (!$pwdRst->save()) {
          return false;
      }
      return true;
    }
}
