{extends file='admin/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.user = {$userinfo};
    $scope.user.user_name = '{$userinfo->user_name}';
    $scope.user.is_admin = '{$userinfo->is_admin}';
    $scope.user.transfer_enable = {$userinfo->enableTrafficInGB()};
    $scope.userFunction = function() {
      $http.put('/admin/user/{$userinfo->id}', $scope.user).then(function(res) {
        $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent(res.data.msg)
          .ok('知道了')
        )
      })
    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">编辑用户 #{$userinfo->id} <span class="md-subhead">Edit User #{$userinfo->id}</span></h2>
</div>
<form ng-submit="userFunction()">
  <div layout-xs="column" layout="row">
    <div flex-xs flex-gt-xs="50" layout="column">
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">帐号信息</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>昵称</label>
            <input type="text" name="user_name" ng-model="user.user_name">
          </md-input-container>
          <md-input-container>
            <label>E-mail</label>
            <input type="email" name="email" ng-model="user.email">
          </md-input-container>
          <md-input-container>
            <label>密码</label>
            <input type="text" name="pass" ng-model="user.pass" placeholder="不修改时留空">
          </md-input-container>
          <md-switch md-invert name="is_admin" ng-model="user.is_admin" ng-true-value="'1'" ng-false-value="'0'" style="margin-top:0">是否为管理员</md-switch>
        </md-card-content>
      </md-card>
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">流量</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>总流量 (GB)</label>
            <input type="number" step="0.001" name="transfer_enable" ng-model="user.transfer_enable">
          </md-input-container>
          <md-input-container>
            <label>已用流量</label>
            <input type="text" value="{$userinfo->usedTraffic()}" disabled>
          </md-input-container>
        </md-card-content>
      </md-card>
    </div>
    <div flex-xs flex-gt-xs="50" layout="column">
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">Shadowsocks 连接信息</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>连接端口</label>
            <input type="number" name="port" ng-model="user.port">
          </md-input-container>
          <md-input-container>
            <label>连接密码</label>
            <input type="text" name="passwd" ng-model="user.passwd">
          </md-input-container>
          <md-input-container>
            <label>自定义加密</label>
            <md-select name="method" ng-model="user.method">
              {foreach $method as $cipher}
              <md-option value="{$cipher}">{$cipher}</md-option>
              {/foreach}
            </md-select>
          </md-input-container>
        </md-card-content>
      </md-card>
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">邀请</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>可用邀请数量</label>
            <input type="number" name="invite_num" ng-model="user.invite_num">
          </md-input-container>
          <md-input-container>
            <label>邀请人 ID</label>
            <input type="text" value="{$userinfo->ref_by}" disabled>
          </md-input-container>
        </md-card-content>
      </md-card>
    </div>
  </div>
  <div layout="row" layout-align="start center">
    <md-button type="submit" class="md-raised md-primary" flex-xs flex-sm>保存修改</md-button>
  </div>
</form>
{/block}
