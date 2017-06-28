<?php

namespace App\Command;

use App\Models\User;
use App\Services\Config;
use App\Utils\Tools;

class autoToll
{
    public static function toll()
    {
        $users = User::all();
        foreach ($users as $user) {
            // 当下行流量加上行流量等于总流量时扣费，否则总流量等于下行流量加上行流量
            if ($user->d + $user->u < $user->transfer_enable) {
                $user->transfer_enable = $user->transfer_enable - Tools::toGB("1");
            } else {
                $user->transfer_enable = $user->d + $user->u;
            }
            $user->save();
        }
    }
}
