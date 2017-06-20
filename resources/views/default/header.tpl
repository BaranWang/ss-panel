<!DOCTYPE html>
<html ng-app="myApp" lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="stylesheet" href="//cdn.bootcss.com/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <link rel="stylesheet" href="/assets/angular/css/angular-material.min.css">
</head>
<body>
  <md-toolbar>
    <div class="md-toolbar-tools">
      <h1>
        <md-icon class="material-icons">&#xE163;</md-icon>
        {$config["appName"]}
      </h1>
      <span flex></span>
      <md-button ng-href="/">首页</md-button>
      <md-button ng-href="/code">邀请码</md-button>
      {if $user->isLogin}
      <md-button ng-href="/user">用户中心</md-button>
      <md-button ng-href="/user/logout">退出</md-button>
      {else}
      <md-button ng-href="/auth/login">登录/注册</md-button>
      {/if}
    </div>
  </md-toolbar>
