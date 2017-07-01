<!DOCTYPE html>
<html ng-app="MyApp" ng-controller="MyController" lang="zh">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <title>{block name=title}{/block}{$config["appName"]}</title>
  <link rel="shortcut icon" href="favicon.ico">
  <link rel="stylesheet" href="//cdn.bootcss.com/material-design-icons/3.0.1/iconfont/material-icons.min.css">
  <link rel="stylesheet" href="//cdn.bootcss.com/angular-material/1.1.4/angular-material.min.css">
  <link rel="stylesheet" href="/assets/p-ss.men/css/style.css">
  <script src="//cdn.bootcss.com/angular.js/1.6.4/angular.min.js"></script>
  <script src="//cdn.bootcss.com/angular.js/1.6.4/angular-animate.min.js"></script>
  <script src="//cdn.bootcss.com/angular.js/1.6.4/angular-aria.min.js"></script>
  <script src="//cdn.bootcss.com/angular.js/1.6.4/angular-sanitize.min.js"></script>
  <script src="//cdn.bootcss.com/angular-material/1.1.4/angular-material.min.js"></script>
  {block name=jslink}{/block}
  <script>
    var MyApp = angular.module('MyApp', ['ngMaterial',{block name=ng}{/block}]);
    MyApp.config(function($mdThemingProvider,$mdAriaProvider) {
      $mdThemingProvider.theme('default')
        {*.primaryPalette('pink')
        .dark();*}
      $mdAriaProvider.disableWarnings();
    });
    MyApp.controller('MyController', function($scope, $mdSidenav) {
      $scope.openSideMenu = function() {
        $mdSidenav('left').toggle();
      };
    });
    MyApp.controller('ViewController', function() {});
  </script>
</head>

<body layout="column" flex>
  <md-toolbar>
    <div class="md-toolbar-tools">
      {if $sidenav}
      <md-button class="md-icon-button" hide-gt-sm ng-click="openSideMenu()">
        <md-icon class="material-icons">&#xE5D2;</md-icon>
      </md-button>
      {/if}
      <a href="/"><md-icon id="logo" md-svg-icon="/assets/p-ss.men/img/logo.svg" aria-label="{$config['appName']}"></md-icon></a>
      {* <md-button href="/">首页</md-button>
      <md-button href="//shadowsocks.org/en/download/clients.html" target="_blank">客户端下载</md-button>
      <md-button href="/code">邀请码</md-button> *}
      <span flex></span>
      {if $user->isLogin}
      <md-menu>
        <md-button class="user_ctrl" ng-click="$mdOpenMenu($event)">
          <img ng-src="{$user->gravatar}" alt="{$user->user_name}" class="md-avatar">
        </md-button>
        <md-menu-content width="5" flex>
          <md-list>
            <md-list-item class="md-2-line">
              <img ng-src="{$user->gravatar}" alt="{$user->user_name}" class="md-avatar">
              <div class="md-list-item-text">
                <h3>{$user->user_name}</h3>
                <p>{$user->email}</p>
              </div>
            </md-list-item>
          </md-list>
          <md-menu-item>
            <md-button href="/user">用户中心</md-button>
          </md-menu-item>
          <md-menu-item>
            <md-button href="/user/logout">退出</md-button>
          </md-menu-item>
        </md-menu-content>
      </md-menu>
      {else}
      <md-button href="/auth/login">登录 / 注册</md-button>
      {/if}
    </div>
  </md-toolbar>
  <div layout="row" flex>
    {if $sidenav}
    <md-sidenav class="site-sidenav md-sidenav-left" md-component-id="left" md-is-locked-open="$mdMedia('gt-sm')" md-whiteframe="4" flex>
      <md-content flex>
        {foreach $sidenav as $name => $url}
        <md-menu-item>
          <md-button {if $smarty.server.REQUEST_URI==$url}class="md-primary"{/if} href="{$url}">{$name}</md-button>
        </md-menu-item>
        {/foreach}
      </md-content>
    </md-sidenav>
    {/if}
    <md-content md-scroll-y layout="column" flex>
      <div layout-padding flex="noshrink" ng-controller="ViewController">
        {block name=main}{/block}
      </div>
      <div layout="row" flex="noshrink" layout-padding layout-align="center end">
        <footer id="license-footer" class="md-caption" layout-padding flex>
          <p>
            Copyright &copy; {date("Y")} <a class="md-primary" href="{$config['baseUrl']}">{$config['appName']}</a>
            Powered by <a class="md-primary" href="https://github.com/orvice/ss-panel" title="ss-panel v{$config['version']}">ss-panel</a>
          </p>
        </footer>
      </div>
    </md-content>
  </div>
  {$analyticsCode}
  {block name=ga}{/block}
</body>

</html>
