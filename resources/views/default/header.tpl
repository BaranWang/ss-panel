<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>{$config["appName"]}</title>
    <!-- CSS fonts.googleapis.com -->
    <!-- <link href="//fonts.lug.ustc.edu.cn/icon?family=Material+Icons" rel="stylesheet"> -->
    <!-- <link href="/assets/materialize/css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection"/> -->
    <!-- <link href="/assets/materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/> -->
    <link rel="stylesheet" href="/assets/p-ss.men/material.blue_grey-indigo.min.css">
</head>
<body>
<header class="mdl-layout__header">
  <div class="mdl-layout__header-row">
    <span class="mdl-layout-title">{$config["appName"]}</span>
    <nav class="mdl-navigation">
      <a href="/">首页</a>
      <a href="/code">邀请码</a>
    </nav>
    <div class="mdl-layout-spacer"></div>
    <nav class="mdl-navigation">
      {if $user->isLogin}
      <a href="/user">用户中心</a>
      <a href="/user/logout">退出</a>
      {else}
      <a href="/auth/login">登录</a>
      <a href="/auth/register">注册</a>
      {/if}
    </nav>
  </div>
</header>
<nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container"><a id="logo-container" href="/" class="brand-logo"></a>
        <ul class="right hide-on-med-and-down">
            <li><a href="/">首页</a></li>
            <li><a href="https://shadowsocks.org/en/download/clients.html">客户端下载</a></li>
            <li><a href="/code">邀请码</a></li>
            {if $user->isLogin}
                <li><a href="/user">用户中心</a></li>
                <li><a href="/user/logout">退出</a></li>
            {else}
                <li><a href="/auth/login">登录</a></li>
                <li><a href="/auth/register">注册</a></li>
            {/if}

        </ul>

        <ul id="nav-mobile" class="side-nav">
            <li><a href="/">首页</a></li>
            <li><a href="https://shadowsocks.org/en/download/clients.html">客户端下载</a></li>
            <li><a href="/code">邀请码</a></li>
            {if $user->isLogin}
                <li><a href="/user">用户中心</a></li>
                <li><a href="/user/logout">退出</a></li>
            {else}
                <li><a href="/auth/login">登录</a></li>
                <li><a href="/auth/register">注册</a></li>
            {/if}
        </ul>
        <!-- To be compatible with some old browsers(especially mobile browsers), use &#xE5D2 instead of menu. For more information visit the link below.
         http://google.github.io/material-design-icons/#using-the-icons-in-html
         -->
        <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">&#xE5D2</i></a>
    </div>
</nav>
