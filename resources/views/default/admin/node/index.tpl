{extends file='admin/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog, $window) {
    $scope.create = function() {
      $window.location = '/admin/node/create'
    }
    $scope.delete = function(name, id) {
      $mdDialog.show(
        $mdDialog.confirm()
        .clickOutsideToClose(true)
        .textContent('确定删除节点 ' + name + ' 吗？')
        .ok('确认删除')
        .cancel('取消')
      ).then(function() {
        $http.delete('/admin/node/' + id, {
          id: id
        }).then(function(res) {
          res.data.ret && $window.location.reload()
        })
      })

    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">节点列表 <span class="md-subhead">Node List</span></h2>
</div>
<md-button ng-click="create()" class="md-fab md-ink-ripple md-fab-bottom-right" style="position:fixed">
  <md-icon class="material-icons">&#xE145;</md-icon>
</md-button>
<md-content layout-padding layout-margin>
  <table class="md-table md-whiteframe-1dp" width="100%">
    <thead>
      <tr>
        <th>ID</th>
        <th class="cell--non-numeric">节点</th>
        <th>加密</th>
        <th>描述</th>
        <th>排序</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      {foreach $nodes as $node}
      <tr>
        <td>#{$node->id}</td>
        <td class="cell--non-numeric">{$node->name}</td>
        <td>{$node->method}</td>
        <td>{$node->info}</td>
        <td>{$node->sort}</td>
        <td>
          <md-menu md-position-mode="target-right target">
            <md-button class="md-icon-button" ng-click="$mdMenu.open($event)">
              <md-icon class="material-icons">&#xE5D4;</md-icon>
            </md-button>
            <md-menu-content width="4">
              <md-menu-item>
                <md-button href="/admin/node/{$node->id}/edit">
                  <md-icon class="material-icons">&#xE254;</md-icon>
                  编辑
                </md-button>
              </md-menu-item>
              <md-menu-item>
                <md-button ng-click="delete('{$node->name}',{$node->id})">
                  <md-icon class="material-icons">&#xE872;</md-icon>
                  删除
                </md-button>
              </md-menu-item>
            </md-menu-content>
          </md-menu>
        </td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</md-content>
{/block}
