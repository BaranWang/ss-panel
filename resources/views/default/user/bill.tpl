{extends file='user/layout.tpl'}
{block name=jslink}
<script src="//cdn.bootcss.com/ngInfiniteScroll/1.3.0/ng-infinite-scroll.min.js"></script>
{/block}
{block name=ng}'infinite-scroll'{/block}
{block name=main}
<script>
let _wrap_ = document.querySelector('md-content[md-scroll-y]');
MyApp.controller('ViewController', function($scope, $http, $window) {
  $scope.page = 1
  $scope.type = new URLSearchParams($window.location.search.substring(1)).get('type')
  $scope.data = []
  $scope.$watch('page', function(page) {
    $http.post('', {
      type: $scope.type,
      page: page
    }).then(function(res) {
      $scope.loading = false
      $scope.pageNum = res.data.page
      $scope.data.push(res.data.data)
    })
  })
  $scope.$watch('type', function(newType, oldType) {
    newType != oldType && ($window.location.href = '/user/bill?type=' + newType)
  })
  $scope.go2top = function () {
    _wrap_.scrollTop = 0
  }
});
MyApp.directive("whenScrolled", function() {
  return {
    restrict: 'A',
    link: function(scope, elem, attrs) {
      angular.element(_wrap_).bind("scroll", function() {
        if (_wrap_.scrollTop + _wrap_.offsetHeight + 10 >= _wrap_.scrollHeight && scope.page <= scope.pageNum) {
          scope.loading = true
          scope.$apply(attrs.whenScrolled);
        }
      });
    }
  }
});
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">账单明细 <span class="md-subhead">Billing Details</span></h2>
</div>
<md-content layout-padding flex md-scroll-y>
  <div layout="column">
    {* <div layout="row" layout-align="start center">
      <md-button class="md-icon-button" ng-click="page=page-1" ng-disabled="page==1">
        <md-icon class="material-icons">&#xE5C4;</md-icon>
      </md-button>
      <md-select ng-model="page" ng-init="page=1">
        <md-option ng-repeat="n in [].constructor(data.page) track by $index" ng-value="$index + 1" ng-bind-template="{literal}第 {{$index + 1}} 页{/literal}"></md-option>
      </md-select>
      <md-button class="md-icon-button" ng-click="page=page+1" ng-disabled="page==data.page">
        <md-icon class="material-icons">&#xE5C8;</md-icon>
      </md-button>
    </div> *}
    <table class="md-table md-whiteframe-1dp" width="100%"  when-scrolled="page=page+1">
      <thead>
        <tr>
          <th class="cell--non-numeric">时间</th>
          <th>
            <md-select class="md-no-underline" ng-model="type" placeholder="交易类型" style="margin:0">
              <md-option value="">全部</md-option>
              <md-option value="recharge">充值</md-option>
              <md-option value="deduct">扣费</md-option>
              <md-option value="return">返利</md-option>
            </md-select>
          </th>
          <th>相关描述</th>
          <th>账户入账／支出</th>
        </tr>
      </thead>
      <tbody ng-repeat="d in data">
        <tr ng-repeat="item in d">
          <td class="cell--non-numeric" ng-bind="item.time"></td>
          <td ng-switch="item.type">
            <span ng-switch-when="recharge">充值</span>
            <span ng-switch-when="deduct">扣费</span>
            <span ng-switch-when="return">返利</span>
            <span ng-switch-default ng-bind="item.type"></span>
          </td>
          <td ng-bind="item.log"></td>
          <td ng-bind="item.money|currency:'¥':3" md-colors="{ color: item.money > 0 ? 'primary' : 'warn' }"></td>
        </tr>
      </tbody>
    </table>
    <div ng-if="loading" layout="row" layout-align="center center" layout-padding layout-margin>
      <md-progress-circular ng-disabled="!loading" md-diameter="24px"></md-progress-circular>
    </div>
    <md-button ng-click="go2top()" class="md-fab md-fab-bottom-right" style="position:fixed">
      <md-icon class="material-icons">&#xE5D8;</md-icon>
    </md-button>
  </div>
</md-content>
{/block}
