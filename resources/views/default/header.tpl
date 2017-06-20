<!DOCTYPE html>
<html ng-app="myApp" lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>{$config["appName"]}</title>
    <!-- CSS fonts.googleapis.com -->
    <link rel="stylesheet" href="//cdn.bootcss.com/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <link rel="stylesheet" href="/assets/angular/css/angular-material.min.css">
</head>
<body>
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
<header class="mdl-layout__header mdl-layout__header--scroll mdl-color--primary">
  <div class="mdl-layout--large-screen-only mdl-layout__header-row"></div>
  <div class="mdl-layout--large-screen-only mdl-layout__header-row">
    <i class="material-icons">&#xE163;</i>{$config["appName"]}
  </div>
  <div class="mdl-layout--large-screen-only mdl-layout__header-row"></div>
  <div class="mdl-layout__tab-bar mdl-js-ripple-effect mdl-color--primary-dark">
    <a class="mdl-layout__tab" href="/">首页</a>
    <a class="mdl-layout__tab" href="/code">邀请码</a>
    {if $user->isLogin}
    <a class="mdl-layout__tab" href="/user">用户中心</a>
    <a class="mdl-layout__tab" href="/user/logout">退出</a>
    {else}
    <a class="mdl-layout__tab" href="/auth/login">登录</a>
    <a class="mdl-layout__tab" href="/auth/register">注册</a>
    {/if}
  </div>
</header>
