
<div class="body" style="background-color: #f5f5f5; padding: 24px 0 16px 0; text-align: center; width: 100%;">
  <div class="wrap" style="display: inline-block; font-family: sans-serif; max-width: 680px; min-width: 280px; text-align: left; width: 90%;">
    <img src="{$config['baseUrl']}/res/logo?color=white" alt="{$config['appName']}">
    <div style="display:block;padding:0 2px">
      <div style="display:block;background:#fff;height:2px"></div>
    </div>
    <div class="card-wrap" style="border: 1px solid #f0f0f0; border-width: 0 1px;">
      <div class="card-wrap-content" style="background: #fff; border: 1px solid #eaeaea; border-width: 0 1px; padding: 24px 32px;">
        <p>你的邮箱验证码为 <b style="background-color:#eee">{$verification->token}</b>，验证码 {$ttl} 分钟内有效。</p>
      </div>
    </div>
    <table style="width:100%;border-collapse:collapse" role="presentation"><tbody><tr><td style="padding:0px"><table style="border-collapse:collapse;width:3px" role="presentation"><tbody><tr height="1"><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td><td width="1" bgcolor="#eaeaea" style="padding:0px"></td><td width="1" bgcolor="#e5e5e5" style="padding:0px"></td></tr><tr height="1"><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td><td width="1" bgcolor="#eaeaea" style="padding:0px"></td><td width="1" bgcolor="#eaeaea" style="padding:0px"></td></tr><tr height="1"><td width="1" bgcolor="#f5f5f5" style="padding:0px"></td><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td></tr></tbody></table></td><td style="width:100%;padding:0px"><div style="height:1px;width:auto;border-top:1px solid #ddd;background:#eaeaea;border-bottom:1px solid #f0f0f0"></div></td><td style="padding:0px"><table style="border-collapse:collapse;width:3px" role="presentation"><tbody><tr height="1"><td width="1" bgcolor="#e5e5e5" style="padding:0px"></td><td width="1" bgcolor="#eaeaea" style="padding:0px"></td><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td></tr><tr height="1"><td width="1" bgcolor="#eaeaea" style="padding:0px"></td><td width="1" bgcolor="#eaeaea" style="padding:0px"></td><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td></tr><tr height="1"><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td><td width="1" bgcolor="#f0f0f0" style="padding:0px"></td><td width="1" bgcolor="#f5f5f5" style="padding:0px"></td></tr></tbody></table></td></tr></tbody></table>
  </div>
</div>

{*
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
</head>

<body>
  <p>尊敬的用户：</p>
  <p>您的邮箱验证代码为: <b>{$verification->token}</b>，请在网页中填写，完成验证。<br>(本验证代码有效期 {$ttl} 分钟)</p><br>
  <p>{$config["appName"]}</p>
</body>

</html> *}
