{extends file='user/layout.tpl'}
{block name=ng}'ngSanitize'{/block}
{block name=main}
<script>
MyApp.controller('ViewController', function($scope, $http, $mdDialog, $interval) {
  $scope.rechargeFunction = function(ev) {
    $mdDialog.show({
      contentElement: '#payQrcode',
      parent: angular.element(document.body),
      targetEvent: ev,
      clickOutsideToClose: false,
      fullscreen: true
    })
    $scope.trade_status = 'loading'
    $http.post('/api/pay/' + $scope.paymentMethod, $scope.recharge).then(function(res) {
      $scope.trade_status = 'nosuccess'
      $scope.orderInfo = res.data
      var stop = $interval(function() {
        $http.get('/api/pay/' + $scope.paymentMethod + '?order_id=' + res.data.out_trade_no).then(function(callback) {
          console.log(callback.data.status);
          if (callback.data.status) {
            $scope.trade_status = 'success'
            $interval.cancel(stop);
          } else {
            $scope.trade_status = 'nosuccess'
          }
        })
      }, 3000)
    })
  }
  $scope.close = function() {
    $mdDialog.cancel();
  }
})
</script>
<div id="rechargeView">
  <div class="page-title" layout-padding>
    <h2 class="md-headline">账户充值 <span class="md-subhead">Node List</span></h2>
  </div>
  <md-tabs md-dynamic-height md-border-bottom>
    <md-tab label="快捷支付">
      <md-content class="md-padding">
        <form name="rechargeForm" ng-submit="rechargeFunction($event)" layout="column">
          <div class="recharge_row" layout="row" layout-align="start center">
            <span flex>充值金额</span>
            <md-input-container md-no-float>
              <input type="number" name="money" ng-model="recharge.money" pattern="{literal}^(([1-9]\d*)(\.\d{1,2})?)$|(0\.0?([1-9]\d?)){/literal}" required>
            </md-input-container>
            <span>元</span>
          </div>
          <div class="recharge_row" layout="row" layout-align="start center">
            <span flex>支付方式</span>
            <md-radio-group ng-model="paymentMethod" ng-init="paymentMethod='alipay'">
              <md-radio-button value="alipay">
                <img class="payment-method" src="/assets/p-ss.men/img/pay_alipay.svg" alt="支付宝">
              </md-radio-button>
            </md-radio-group>
          </div>
          <div class="recharge_row" layout="row">
            <span flex></span>
            <md-button type="submit" class="md-raised md-primary" ng-disabled="rechargeForm.$invalid">立即支付</md-button>
          </div>
        </form>
      </md-content>

    </md-tab>
    <md-tab label="转账支付">
      <p>如果无法通过快捷支付的方式充值，可直接扫描下方二维码转账</p>
      <md-radio-group ng-model="payQrcode" layout="row">
        <md-radio-button value="wxp://f2f0aZ-_6vh-VMhIsJ2xtGFboGi6RD57Oc0y" ng-selected="true">
          <img class="payment-method" src="/assets/p-ss.men/img/pay_wepay.svg" alt="微信支付">
        </md-radio-button>
        <md-radio-button value="https://qr.alipay.com/stx05409hdhfupvsyjxwld7">
          <img class="payment-method" src="/assets/p-ss.men/img/pay_alipay.svg" alt="支付宝">
        </md-radio-button>
      </md-radio-group>
      <p flex></p>
      <img class="pay-qrcode" ng-if="payQrcode" ng-src="/res/qrcode?size=480&text={literal}{{payQrcode}}{/literal}">
    </md-tab>
  </md-tabs>
  <div style="visibility:hidden">
    <div class="md-dialog-container pay-qrcode-wrap" id="payQrcode">
      <md-dialog layout-padding flex="80">
        <div ng-switch="trade_status">
          <div ng-switch-when="loading" layout="column" layout-align="center center">
            <md-progress-circular md-mode="indeterminate"></md-progress-circular>
          </div>
          <div ng-switch-when="nosuccess" layout="column" layout-align="center center">
            <h1 class="md-display-2" ng-bind="recharge.money|currency:'¥':2"></h1>
            <img class="pay-qrcode" ng-src="/res/qrcode?size=480&text={literal}{{orderInfo.qr_code}}{/literal}">
            <md-button class="md-raised md-primary" ng-href="{literal}{{orderInfo.qr_code}}{/literal}" flex>手机直接点此付款</md-button>
            <div class="order-info" layout="column" layout-padding>
              <p layout="row" flex>
                <span flex>商品名称</span>
                <span>{$config["appName"]} 充值 - {$user->email}</span>
              </p>
              <p layout="row" flex>
                <span flex>交易单号</span>
                <span ng-bind="orderInfo.out_trade_no"></span>
              </p>
            </div>
          </div>
          <div ng-switch-when="success" layout="column" layout-align="center center">
            <md-icon class="material-icons md-primary" style="width:72px;height:72px;font-size:72px">&#xE86C;</md-icon>
            <h1 class="md-display-2">充值成功</h1>
            <md-button class="md-raised md-primary" ng-click="close()">我知道了</md-button>
          </div>
        </div>
      </md-dialog>
    </div>
  </div>
</div>
{/block}
