<?php

namespace App\Services\Pay;

use App\Models\MoneyLog as MoneyLogModel;
use App\Utils\Tools;

class MoneyLog
{
    public static function add($userId, $type, $money, $log)
    {
        $moneyLog = new MoneyLogModel();
        $moneyLog->user_id = $userId;
        $moneyLog->type = $type;
        $moneyLog->money = $money;
        $moneyLog->log = json_encode($log);
        if (!$moneyLog->save()) {
            return false;
        }
        return true;
    }
    public static function find($userId)
    {
        $result = MoneyLogModel::all()->where('user_id', $userId);
        foreach ($result as $key => $value) {
            $result[$key]['log'] = json_decode($value['log']);
        }
        return $result;
    }
    public static function findByOrder($order)
    {
        $result = MoneyLogModel::where('log', 'LIKE', '%'.$order.'%')->first();
        foreach ($result as $key => $value) {
            $result[$key]['log'] = json_decode($value['log']);
        }
        return $result;
    }
}
