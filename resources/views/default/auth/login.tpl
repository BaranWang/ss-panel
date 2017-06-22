{extends file='layout.tpl'}
{block name=title}登录 - {/block}
{block name=main}
<script>
  MyApp.controller('LoginController', function($scope, $http, $window) {
    $scope.loginFunction = function() {
      $http.post('/auth/login',$scope.user).then(function(res) {
        res.data.ret ? $window.location.href='/user' : $scope.errorMsg=res.data.msg
      })
    }
  })
</script>
<div class="card-page" layout="row" layout-align="center center" ng-controller="LoginController">
  <md-card layout-padding>
    <md-card-title>
      <md-card-title-text>
        <span class="md-headline">登录 {$config["appName"]}</span>
      </md-card-title-text>
    </md-card-title>
    <md-card-content>
      <form layout="column" name="loginForm" ng-submit="loginFunction()">
        <md-input-container>
          <label>E-mail</label>
          <md-icon class="material-icons">&#xE0BE;</md-icon>
          <input type="email" name="email" ng-model="user.email" required>
        </md-input-container>
        <md-input-container>
          <md-icon class="material-icons">&#xE897;</md-icon>
          <label>密码</label>
          <input type="password" name="passwd" ng-model="user.passwd" required>
        </md-input-container>
        <md-input-container layout="row" layout-align="center start">
          <md-checkbox class="md-primary" name="remember_me" ng-model="user.remember_me">记住我</md-checkbox>
          <span flex></span>
          <a class="md-primary" href="/password/reset">忘记密码？</a>
        </md-input-container>
        <md-button type="submit" class="md-raised md-primary" ng-disabled="loginForm.$invalid">登录</md-button>
        <md-input-container ng-if="errorMsg">
          <span class="md-input-message-animation" ng-bind="errorMsg"></span>
        </md-input-container>
      </form>
    </md-card-content>
    <md-card-actions layout="row" layout-align="center center">
      <a class="md-primary" href="/auth/register">没有账号？立即注册</a>
    </md-card-actions>
  </md-card>
</div>
{/block}
