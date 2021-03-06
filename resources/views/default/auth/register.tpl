{extends file='layout.tpl'}
{block name=title}注册 - {/block}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $window, $mdDialog) {
    $scope.registerFunction = function() {
      $http.post('/auth/register',$scope.user).then(function(res) {
        if (res.data.ret) {
          $http.post('/auth/login',$scope.user)
          $window.location.href='/user'
        } else {
          $mdDialog.show(
            $mdDialog.alert()
            .clickOutsideToClose(true)
            .textContent(res.data.msg)
            .ok('知道了')
          )
        }
      })
    }
  })
</script>
<div class="card-page" layout="row" layout-align="center center">
  <md-card layout-padding>
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
          <input type="email" ng-model="user.email" ng-init="user.email='{$email}'" required>
        </md-input-container>
        <md-input-container>
          <label>昵称</label>
          <md-icon class="material-icons">&#xE853;</md-icon>
          <input type="text" ng-model="user.name">
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
          <md-checkbox class="md-primary" ng-model="agree" ng-init="agree=true">我已阅读并同意</md-checkbox><a class="md-primary" href="/tos" target="_blank">《服务条款》</a>
        </md-input-container>
        <md-button type="submit" class="md-raised md-primary" ng-disabled="registerForm.$invalid||!agree">立即注册</md-button>
      </form>
    </md-card-content>
    <md-card-actions layout="row" layout-align="center center">
      <a class="md-primary" href="/auth/login">已有账号？立即登录</a>
    </md-card-actions>
  </md-card>
</div>
{/block}
