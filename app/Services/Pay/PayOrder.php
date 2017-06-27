<?php

namespace App\Services\Pay;

// use App\Models\User;
use App\Models\PayOrder as PayOrderModel;
use App\Utils\Tools;

class PayOrder
{
    public static function add($userId, $data)
    {
      $payOrder = new PayOrderModel();

      $payOrder->user_id = $userId;
      $payOrder->data = $data;
      if (!$payOrder->save()) {
          return false;
      }
      return true;
    }
}
