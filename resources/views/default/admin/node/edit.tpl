{extends file='admin/layout.tpl'}
{block name=main}

<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog, $window) {
    $scope.node = {if $node}{$node}{else}{
      traffic_rate: 1,
      type: 1,
      status: ' ',
      sort: 0,
      info: ' '
    }{/if};
    $scope.nodeFunction = function() {
      {if $node}
      $http.put('/admin/node/{$node->id}', $scope.node)
      {else}
      $http.post('/admin/node', $scope.node)
      {/if}
      .then(function(res) {
        res.data.ret && $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent(res.data.msg)
          .ok('知道了')).then(function() {
            $window.location = '/admin/node'
          })
      })
    }
  })
</script>

<div class="page-title" layout-padding>
  {if $node}
  <h2 class="md-headline">编辑节点 #{$node->id} <span class="md-subhead">Edit Node {$node->id}</span></h2>
  {else}
  <h2 class="md-headline">添加节点 <span class="md-subhead">Add Node</span></h2>
  {/if}
</div>
<md-content>
  <form name="nodeForm" ng-submit="nodeFunction()" layout="column">
    <div layout-xs="column" layout="row">
      <div flex-xs flex-gt-xs="50" layout="column">
        <md-card>
          <md-card-title>
            <md-card-title-text class="md-headline">连接信息</md-card-title-text>
          </md-card-title>
          <md-card-content layout="column">
            <md-input-container>
              <label>节点名称</label>
              <input type="text" name="name" ng-model="node.name" required>
            </md-input-container>
            <md-input-container>
              <label>节点地址</label>
              <input type="text" name="server" ng-model="node.server" required>
            </md-input-container>
            <div layout="row">
              <md-input-container flex="50">
                <label>加密方式</label>
                <md-select name="method" ng-model="node.method" required>
                  {foreach $method as $cipher}
                  <md-option value="{$cipher}">{$cipher}</md-option>
                  {/foreach}
                </md-select>
              </md-input-container>
              <md-input-container flex="50">
                <label>流量比例</label>
                <input type="number" name="traffic_rate" ng-model="node.traffic_rate" required>
              </md-input-container>
            </div>
            <md-switch md-invert name="custom_method" ng-model="node.custom_method" ng-true-value="1" ng-false-value="0">自定义加密</md-switch>
          </md-card-content>
        </md-card>
      </div>
      <div flex-xs flex-gt-xs="50" layout="column">
        <md-card>
          <md-card-title>
            <md-card-title-text class="md-headline">描述信息</md-card-title-text>
          </md-card-title>
          <md-card-content layout="column">
            <md-switch name="type" ng-model="node.type" ng-true-value="1" ng-false-value="0">是否显示（{literal}{{ node.type ? '显示' : '隐藏' }}{/literal}）</md-switch>
            <md-input-container>
              <label>节点状态</label>
              <input type="text" name="status" ng-model="node.status" required>
            </md-input-container>
            <md-input-container>
              <label>排序</label>
              <input type="number" name="sort" ng-model="node.sort" required>
            </md-input-container>
            <md-input-container>
              <label>节点描述</label>
              <textarea name="info" ng-model="node.info" rows="1" required></textarea>
            </md-input-container>
          </md-card-content>
        </md-card>
      </div>
    </div>
    <div layout="row" layout-align="end center">
      <md-button type="submit" class="md-raised md-primary" flex-xs flex-sm>{if $node}修改{else}添加{/if}</md-button>
    </div>
  </form>
</md-content>
{/block}
