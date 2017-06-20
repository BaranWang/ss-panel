<!DOCTYPE html>
<html ng-app="myApp" lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>{block name=title}{/block}{$config["appName"]}</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <link rel="stylesheet" href="/assets/angular/css/angular-material.min.css">
    <script src="/assets/angular/js/angular.min.js"></script>
    <script src="/assets/angular/js/angular-animate.min.js"></script>
    <script src="/assets/angular/js/angular-aria.min.js"></script>
    <script src="/assets/angular/js/angular-material.min.js"></script>
    <script>
    	var myApp = angular.module('myApp', ['ngMaterial']);
    </script>
</head>
<body>
  <md-toolbar>
    <div class="md-toolbar-tools">
      <h1>
        <md-icon class="material-icons">&#xE163;</md-icon>
        {$config["appName"]}
      </h1>
      {* <md-button href="/">首页</md-button>
      <md-button href="/code">邀请码</md-button> *}
      <span flex></span>
      {if $user->isLogin}
      <md-button href="/user">用户中心</md-button>
      <md-button href="/user/logout">退出</md-button>
      {else}
      <md-button href="/auth/login">登录 / 注册</md-button>
      {/if}
    </div>
  </md-toolbar>
  {* {$smarty.server.REQUEST_URI} *}
  {block name=main}{/block}
  {$analyticsCode}
</body>
</html>
