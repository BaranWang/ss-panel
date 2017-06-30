{extends file='admin/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.config = {
      appName: "{$conf['app-name']}",
      analyticsCode: "{$conf['analytics-code']|escape:'javascript'}",
      homeCode: "{$conf['home-code']}",
      userIndex: "{$conf['user-index']}",
      userNode: "{$conf['user-node']}"
    }
    $scope.updateConfig = function () {
      $http.put('', $scope.config).then(function(res) {
        res.data.ret && $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent('更新成功')
          .ok('知道了')
        )
      })
    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">站点配置 <span class="md-subhead">App Config</span></h2>
</div>
<form ng-submit="updateConfig()" layout-padding>
  <md-tabs md-dynamic-height md-border-bottom>
    <md-tab label="信息管理">
      <md-content layout="column">
        <span flex style="height:32px"></span>
        <md-input-container>
          <label>网站名</label>
          <input type="text" name="appName" ng-model="config.appName">
        </md-input-container>
        <md-input-container>
          <label>统计代码</label>
          <textarea name="analyticsCode" ng-model="config.analyticsCode" rows="1"></textarea>
        </md-input-container>
      </md-content>
    </md-tab>
    <md-tab label="公告管理">
      <md-content layout="column">
        <span flex style="height:32px"></span>
        <md-input-container>
          <label>邀请页公告</label>
          <textarea name="homeCode" ng-model="config.homeCode" rows="1"></textarea>
        </md-input-container>
        <md-input-container>
          <label>用户中心公告</label>
          <textarea name="userIndex" ng-model="config.userIndex" rows="1"></textarea>
        </md-input-container>
        <md-input-container>
          <label>用户节点公告</label>
          <textarea name="userNode" ng-model="config.userNode" rows="1"></textarea>
        </md-input-container>
      </md-content>
    </md-tab>
  </md-tabs>
  <div>
    <md-button type="submit" class="md-raised md-primary">更新配置</md-button>
  </div>
</form>
{/block}
