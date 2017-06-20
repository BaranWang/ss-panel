{extends file='layout.tpl'}
{block name=title}注册 - {/block}
{block name=main}
<style>
  md-input-container { margin: 8px 0; }
  [ng-controller] { margin-top: 64px; }
</style>
<script>
  myApp.controller('registerController', ['$scope', '$http', '$window', '$mdDialog', function($scope, $http, $window, $mdDialog) {
    $scope.registerFunction = function() {
      $http.post('/auth/register',$scope.user).then(function(res) {
        if (res.data.ret) {
          $http.post('/auth/login',$scope.user)
          $window.location.href='/user'
        }else {
          $mdDialog.show(
            $mdDialog.alert()
            .clickOutsideToClose(true)
            .textContent(res.data.msg)
            .ok('知道了')
          )
        }
      })
    }
  }])
</script>
<div layout="row" layout-align="center center" ng-controller="registerController">
  <md-card flex="30" layout-padding>
    <md-card-title>
      <md-card-title-text>
        <span class="md-headline">注册 {$config["appName"]}</span>
      </md-card-title-text>
    </md-card-title>
    <md-card-content>
      <form layout="column" name="registerForm" ng-submit="registerFunction()">
        <md-input-container>
          <label>E-mail</label>
          <md-icon class="material-icons">&#xE0BE;</md-icon>
          <input type="email" ng-model="user.email" required>
        </md-input-container>
        <md-input-container>
          <label>昵称</label>
          <md-icon class="material-icons">&#xE853;</md-icon>
          <input type="text" ng-model="user.name" required>
        </md-input-container>
        <md-input-container>
          <label>密码</label>
          <md-icon class="material-icons">&#xE897;</md-icon>
          <input type="password" ng-model="user.passwd" ng-minlength="8" required>
        </md-input-container>
        <md-input-container>
          <label>邀请码</label>
          <md-icon class="material-icons">&#xE638;</md-icon>
          <input type="text" ng-model="user.code" ng-init="user.code='{$code}'" required>
        </md-input-container>
        <md-input-container layout="row" layout-align="start start">
          <md-checkbox ng-model="agree" ng-init="agree=true">我已阅读并同意</md-checkbox><a href="/tos" target="_blank">《服务条款》</a>
        </md-input-container>
        <md-button type="submit" class="md-raised md-primary" ng-disabled="registerForm.$invalid||!agree">立即注册</md-button>
      </form>
    </md-card-content>
    <md-card-actions layout="row" layout-align="center center">
      <md-button class="md-primary" href="/auth/login">已有账号？立即登录</md-button>
    </md-card-actions>
  </md-card>
</div>
{/block}
