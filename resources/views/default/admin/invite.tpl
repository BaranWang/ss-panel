{extends file='admin/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.inviteFunction = function() {
      $http.post('', $scope.invite).then(function(res) {
        $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent(res.data.msg)
          .ok('知道了')
        ).then(function() {
          $scope.invite = {}
          $scope.inviteForm.$setPristine()
          $scope.inviteForm.$setUntouched()
        })
      })
    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">邀请 <span class="md-subhead">Invite</span></h2>
</div>
<md-content>
  <div flex-sm flex-gt-sm="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">添加邀请码</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <form name="inviteForm" ng-submit="inviteFunction()" layout="column">
          <md-input-container>
            <label>前缀</label>
            <input type="text" name="prefix" ng-model="invite.prefix">
          </md-input-container>
          <md-input-container>
            <label>所有人（0 为公共）</label>
            <input type="number" name="uid" ng-model="invite.uid" required>
          </md-input-container>
          <md-input-container>
            <label>数量</label>
            <input type="number" name="num" ng-model="invite.num" required>
          </md-input-container>
          <div layout="row" layout-align="start center">
            <md-button type="submit" class="md-raised md-primary" ng-disabled="inviteForm.$invalid" flex-xs flex-sm>立即生成</md-button>
          </div>
        </form>
      </md-card-content>
    </md-card>
    <p layout-padding>公共邀请码（所有人为 0 ）请 <a href="/code" class="md-primary">在这里查看</a></p>
  </div>
</md-content>
{/block}
