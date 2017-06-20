<!DOCTYPE html>
<html ng-app="myApp" ng-cloak lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>{$config["appName"]}</title>
    <!-- CSS fonts.googleapis.com -->
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
      <md-nav-bar>
        <md-nav-item md-nav-href="/">首页</md-nav-item>
        <md-nav-item md-nav-href="/code">邀请码</md-nav-item>
        {if $user->isLogin}
        <md-nav-item md-nav-href="/user">用户中心</md-nav-item>
        <md-nav-item md-nav-href="/user/logout">退出</md-nav-item>
        {else}
        <md-nav-item md-nav-href="/auth/login">登录</md-nav-item>
        <md-nav-item md-nav-href="/auth/register">注册</md-nav-item>
        {/if}
      </md-nav-bar>
    </div>
  </md-toolbar>
