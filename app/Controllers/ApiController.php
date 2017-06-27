<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Models\Node,App\Models\User;
use App\Services\Factory;
use App\Services\Config;
use App\Services\Pay\PayOrder;
use App\Utils\Tools,App\Utils\Hash,App\Utils\Helper;
use Omnipay\Omnipay;
/**
 *  ApiController
 */

class ApiController extends BaseController
{

    public function index(){

    }

    public function token($request, $response, $args){
        $accessToken = $id = $args['token'];
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($token==null){
            $res['ret'] = 0;
            $res['msg'] = "token is null";
            return $this->echoJson($response,$res);
        }
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $token;
        return $this->echoJson($response,$res);
    }

    public function newToken($request, $response, $args){
        // $data = $request->post('sdf');
        $email =  $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');

        // Handle Login
        $user = User::where('email','=',$email)->first();

        if ($user == null){
            $res['ret'] = 0;
            $res['msg'] = "401 邮箱或者密码错误";
            return $this->echoJson($response,$res);
        }

        if (!Hash::checkPassword($user->pass,$passwd)){
            $res['ret'] = 0;
            $res['msg'] = "402 邮箱或者密码错误";
            return $this->echoJson($response,$res);
        }
        $tokenStr = Tools::genToken();
        $storage = Factory::createTokenStorage();
        $expireTime = time() + 3600*24*7;
        if($storage->store($tokenStr,$user,$expireTime)){
            $res['ret'] = 1;
            $res['msg'] = "ok";
            $res['data']['token'] = $tokenStr;
            $res['data']['user_id'] = $user->id;
            return $this->echoJson($response,$res);
        }
        $res['ret'] = 0;
        $res['msg'] = "system error";
        return $this->echoJson($response,$res);
    }

    public function node($request, $response, $args){
        $nodes = Node::where('type',1)->orderBy('sort')->get();
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $nodes;
        return $this->echoJson($response,$res);
    }

    public function userInfo($request, $response, $args){
        $id = $args['id'];
        $accessToken = Helper::getTokenFromReq($request);
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        if($id != $token->userId){
            $res['ret'] = 0;
            $res['msg'] = "access denied";
            return $this->echoJson($response,$res);
        }
        $user = User::find($token->userId);
        $user->pass = null;
        $data = $user;
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $data;
        return $this->echoJson($response,$res);

    }
    public function reCAPTCHA($request, $response, $args){
      $curl = curl_init();

      curl_setopt($curl, CURLOPT_URL, 'https://www.google.com/recaptcha/api/siteverify');
      curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

      // curl_setopt($curl, CURLOPT_PROXY, 'http://127.0.0.1:8123'); // 上线注释
      curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, "10");
      curl_setopt($curl, CURLOPT_TIMEOUT, "10");
      curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query([
        'secret'   => '6LcJyCYUAAAAAMfYPlB2_QbNwA-UF_i60fnZrOq3',
        'response' => $request->getParam('g-recaptcha-response')
        ]));
      $res = curl_exec($curl);
      curl_close($curl);
      return $res;
    }
    public function alipay($request, $response, $args){
      $money = $request->getParam('money');
      $gateway = $this->intAliPay();
      $request = $gateway->purchase();
      $request->setBizContent([
        'subject'      => Config::get('appName').' 充值',
        'out_trade_no' => date('YmdHis') . mt_rand(1000, 9999),
        'total_amount' => $money
      ]);
      $response = $request->send();
      var_dump($response);exit;
      return json_encode($response->getAlipayResponse());
    }
    public function alipayCallback($request, $response, $args){
      // $gateway = $this->intAliPay();
      // $request = $gateway->completePurchase();
      // $request->setParams($_POST); //Optional
      // var_dump($request->getParsedBody());exit;
      PayOrder::add(1, json_encode($_POST));
      echo json_encode($_POST);exit;
      // try {
      //   $response = $request->send();
      //   if($response->isPaid()){
      //     die('success'); //The response should be 'success' only
      //   }else{
      //     die('fail');
      //   }
      // } catch (Exception $e) {
      //     die('fail');
      // }
    }
    private function intAliPay(){
      $gateway = Omnipay::create('Alipay_AopF2F');
      $gateway->setSignType(Config::get('alipay_setSignType'));
      $gateway->setAppId(Config::get('alipay_sandbox') ? Config::get('alipay_sandbox_appId') : Config::get('alipay_appId'));
      $gateway->setPrivateKey(Config::get('alipay_privateKey'));
      $gateway->setAlipayPublicKey(Config::get('alipay_publicKey'));
      $gateway->setNotifyUrl(Config::get('baseUrl').'/api/pay/alipay/callback');
      if (Config::get('alipay_sandbox')) {
        $gateway->sandbox();
      }
      return $gateway;
    }

}
