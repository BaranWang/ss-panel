{extends file='user/layout.tpl'}
{block name=title}流量统计 - {/block}
{block name=main}
<script src="//a.alipayobjects.com/g/datavis/g2/2.3.5/g2.js"></script>

<script>
  var nodeList = { {foreach $nodes as $node}{$node->id}:'{$node->name}',{/foreach} };
  MyApp.controller('ViewController', function($scope, $http) {
    $scope.data = [];
    var chart = new G2.Chart({
      id: 'chart',
      forceFit: true,
      height: 480
    });
    chart.source($scope.data, {
      't': {
        type: 'time',
        alias: '时间',
        mask: 'mm/dd HH:MM:ss',
      },
      'n': {
        alias: '节点',
        formatter: function(node) {
          return nodeList[node]
        }
      },
      'f': {
        alias: '流量',
        min: 0,
        formatter: function(bytes) {
          if (bytes > 0) {
            var s = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
            var e = Math.floor(Math.log(bytes)/Math.log(1024));
            return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
          } else {
            return '0 bytes'
          }
        }
      }
    });
    chart.axis('t', { title: null });
    chart.axis('f', { title: null });
    // chart.legend({ position: 'bottom' });
    chart.line().position('t*f').color('n').size(2);
    chart.render();

    $scope.day = 1;
    $scope.changeDay = function(day) {
      $scope.day = day;
    }
    $scope.$watch('day',function(day) {
      $http.post('?day=' + day).then(function(res) {
        $scope.data = res.data
        chart.changeData(res.data)
        chart.forceFit()
      })
    })
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">流量统计 <span class="md-subhead">Traffic Log</span></h2>
</div>
<md-content layout="column">
  <md-nav-bar md-selected-nav-item="'day1'">
    <md-nav-item md-nav-click="changeDay(1)" name="day1">过去 24 小时</md-nav-item>
    <md-nav-item md-nav-click="changeDay(7)">过去 7 天</md-nav-item>
    <md-nav-item md-nav-click="changeDay(30)">过去 30 天</md-nav-item>
    <md-nav-item md-nav-click="changeDay(0)">全部</md-nav-item>
  </md-nav-bar>
  {* <div layout="row">
    <md-button ng-click="day=1" ng-class="{ 'md-primary md-raised':day==1 }">过去 24 小时</md-button>
    <md-button ng-click="day=7" ng-class="{ 'md-primary md-raised':day==7 }">过去 7 天</md-button>
    <md-button ng-click="day=30" ng-class="{ 'md-primary md-raised':day==30 }">过去 30 天</md-button>
    <md-button ng-click="day=0" ng-class="{ 'md-primary md-raised':day==0 }">全部</md-button>
  </div> *}
  <div id="chart" flex="100"></div>
</md-content>


{/block}
