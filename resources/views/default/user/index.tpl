{extends file='user/layout.tpl'}
{block name=main}
{* <script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.pay = function() {
      $mdDialog.show(
        $mdDialog.prompt()
        .title('充值')
        .placeholder('请输入充值金额')
        .ok('立即支付')
      ).then(function(money) {
        $http.post('/api/pay/alipay', { user_id: {$user->id}, money: money }).then(function(res) {
          console.log(res);
          // img = $sanitize('<img scr="/api/qrcode?text=' + res.data.qr_code + '">')
          // $mdDialog.show(
          //   $mdDialog.alert()
          //   .htmlContent(img)
          // )
        })
      })

    }
  })
</script> *}
<div class="page-title" layout-padding>
  <h2 class="md-headline">用户中心 <span class="md-subhead">User Center</span></h2>
</div>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">公告</md-card-title-text>
      </md-card-title>
      <md-card-content>{$msg}</md-card-content>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">账户余额</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <p class="md-display-1" ng-bind="'{($user->transfer_enable - $user->d - $user->u) / 1024 / 1024|string_format:"%.2f"}'|currency:'¥'" style="margin-bottom:16px"></p>
        <md-button class="md-raised md-primary" ng-href="/user/recharge">立即充值</md-button>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-title>
        <md-card-title-text layout="row" layout-align="space-between end">
          <span class="md-headline">流量</span>
          <span class="md-body-1">剩余 {$user->unusedTraffic()} （共 {$user->enableTraffic()}）</span>
        </md-card-title-text>
      </md-card-title>
      <md-card-content>
        <md-progress-linear class="traffic-progress" md-mode="determinate" value="{$user->trafficUsagePercent()}"></md-progress-linear>
        <p class="md-caption">
          <span md-colors="{ color:'primary' }">&#9608;</span> 已用
          <span md-colors="{ color:'primary-100' }">&#9608;</span> 剩余
        </p>
        <p>上次使用：{$user->lastSsTime()}</p>
        {* <svg fill="none" viewbox="0 0 40 40">
          <g transform="rotate(270 20,20)">
            <circle stroke="#eee" cx="20" cy="20" r="16" stroke-width="8"></circle>
            <circle md-colors="{ stroke:'primary' }" cx="20" cy="20" r="16" stroke-width="8" stroke-dasharray="0 100">
              <animate attributeName="stroke-dasharray" from="0 100" to="{$user->trafficUsagePercent()} 100" dur=".5s" repeatCount="1" fill="freeze"/>
            </circle>
          </g>
        </svg> *}
      </md-card-content>
    </md-card>
  </div>
</md-content>
{/block}
