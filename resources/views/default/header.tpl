<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>{$config["appName"]}</title>
    <!-- CSS fonts.googleapis.com -->
    <link href="//cdn.bootcss.com/material-design-icons/3.0.1/iconfont/material-icons.min.css" rel="stylesheet">
    <!-- <link href="/assets/materialize/css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection"/> -->
    <!-- <link href="/assets/materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/> -->
    <link rel="stylesheet" href="/assets/p-ss.men/css/material.blue_grey-indigo.min.css">
</head>
<body>
<header class="mdl-layout__header">
  <div class="mdl-layout__header-row">
    <span class="mdl-layout-title">
      <i class="material-icons">&#xE163;</i>
      {$config["appName"]}
    </span>
    <div class="mdl-layout-spacer"></div>
    <nav class="mdl-navigation">
      <a class="mdl-navigation__link" href="/">首页</a>
      <a class="mdl-navigation__link" href="/code">邀请码</a>
      {if $user->isLogin}
      <a class="mdl-navigation__link" href="/user">用户中心</a>
      <a class="mdl-navigation__link" href="/user/logout">退出</a>
      {else}
      <a class="mdl-navigation__link" href="/auth/login">登录</a>
      <a class="mdl-navigation__link" href="/auth/register">注册</a>
      {/if}
    </nav>
  </div>
</header>
