<?php

namespace App\Services\Pay;

// use App\Models\User;
use App\Models\PayOrder as PayOrderModel;
use App\Utils\Tools;

class PayOrder
{
    public static function add($userId, $orderId, $data)
    {
      $payOrder = new PayOrderModel();

      $payOrder->user_id = $userId;
      $payOrder->order_id = $orderId;
      $payOrder->data = $data;
      if (!$payOrder->save()) {
          return false;
      }
      return true;
    }
    public static function update($orderId, $data)
    {
      $payOrder = PasswordReset::where('order_id', $orderId)->first();

      $payOrder->data = $data;
      if (!$payOrder->save()) {
          return false;
      }
      return true;
    }
}
