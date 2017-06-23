<?php

namespace App\Services\Mail;

use App\Services\Config;
use App\Services\DbConfig;
use Mailgun\Mailgun as MailgunService;

class Mailgun extends Base
{
    private $config, $mg, $domain, $sender;

    /**
     * @codeCoverageIgnore
     */
    public function __construct()
    {
        $this->config = $this->getConfig();
        $this->mg = new MailgunService($this->config["key"]);
        $this->domain = $this->config["domain"];
        $this->sender = $this->config["sender"];
    }

    /**
     * @codeCoverageIgnore
     */
    public function getConfig()
    {
        return [
            "key" => Config::get('mailgun_key'),
            "domain" => Config::get('mailgun_domain'),
            "sender" => Config::get('mailgun_sender')
        ];
    }

    /**
     * @codeCoverageIgnore
     */
    public function send($to, $subject, $text, $file)
    {
        $appName = DbConfig::get('app-name');
        if ($appName == null || $appName == "") {
            $appName = Config::get("appName");
        }
        $this->mg->sendMessage($this->domain,
            [
                'from' => "$appName <{$this->sender}>",
                'to' => $to,
                'subject' => $subject,
                'html' => $text
            ],
            [
                'inline' => $file
            ]
        );
    }
}
