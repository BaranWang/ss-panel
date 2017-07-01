{extends file='user/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.updateFunction = function(url, data) {
      $http.post(url, data).then(function(res) {
        $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent(res.data.msg)
          .ok('知道了')
        )
      })
    };
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">修改资料 <span class="md-subhead">Profile Edit</span></h2>
</div>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">网站登录密码修改</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <form name="webpwdForm" ng-submit="updateFunction('password', webpwd)" layout="column">
          <md-input-container>
            <label>当前密码</label>
            <input type="password" name="oldpwd" ng-model="webpwd.oldpwd" required>
          </md-input-container>
          <md-input-container>
            <label>新密码（8 位以上）</label>
            <input type="password" name="pwd" ng-model="webpwd.pwd" ng-minlength="8" required>
          </md-input-container>
          <md-input-container>
            <label>确认密码</label>
            <input type="password" name="repwd" ng-model="webpwd.repwd" ng-minlength="8" required>
          </md-input-container>
          <md-button type="submit" class="md-raised md-primary" ng-disabled="webpwdForm.$invalid">确认修改</md-button>
          <md-input-container ng-if="errorMsg">
            <span class="md-input-message-animation" ng-bind="errorMsg"></span>
          </md-input-container>
        </form>
      </md-card-content>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">修改 Shadowsocks 连接密码</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <form name="sspwdForm" ng-submit="updateFunction('sspwd', sspwd)" layout="row" layout-align="start start">
          <md-input-container>
            <label>新连接密码</label>
            <input type="text" name="sspwd" ng-model="sspwd.sspwd">
          </md-input-container>
          <md-button type="submit" class="md-raised md-primary">确认修改</md-button>
        </form>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">修改 Shadowsocks 加密方式</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <form name="methodForm" ng-submit="updateFunction('method', method)" layout="row" layout-align="start start">
          <md-input-container>
            <md-select name="method" ng-model="method.method">
              {foreach $method as $cipher}
              <md-option value="{$cipher}" {if $user->method==$cipher}selected{/if} >{$cipher}</md-option>
              {/foreach}
            </md-select>
          </md-input-container>
          <md-button type="submit" class="md-raised md-primary" ng-disabled="!methodForm.method.$touched">确认修改</md-button>
        </form>
      </md-card-content>
    </md-card>
  </div>
</md-content>
{/block}
