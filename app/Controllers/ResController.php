<?php


namespace App\Controllers;

use Gregwar\Captcha\CaptchaBuilder;
use Endroid\QrCode\QrCode;

class ResController
{
    public function captcha($request, $response, $args){
        $id = $args['id'];
        $builder = new CaptchaBuilder;
        $builder->build();
        //$builder->getPhrase();
        $newResponse = $response->withHeader('Content-type', ' image/jpeg');//->getBody()->write($builder->output());
        $newResponse->getBody()->write($builder->output());
        return $newResponse;
    }
    public function qrcode($request, $response, $args){
        $qr_size = $request->getParam('size');
        $qr_type = $request->getParam('type');
        $qrCode = new QrCode($request->getParam('text'));
        $qrCode
          ->setSize($qr_size ? $qr_size : '256')
          // ->setMargin(0)
          ->setEncoding('UTF-8')
          ->setWriterByName($qr_type ? $qr_type : 'png')
        ;
        $newResponse = $response->withHeader('Content-type', $qrCode->getContentType());
        $newResponse->getBody()->write($qrCode->writeString());
        return $newResponse;
    }
}
