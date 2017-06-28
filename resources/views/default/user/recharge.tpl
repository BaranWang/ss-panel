{extends file='user/layout.tpl'}
{block name=ng}'ngSanitize'{/block}
{block name=main}
<script>
MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
  $scope.recharge = {
    user_id: {$user->id}
  }
  $scope.rechargeFunction = function(ev) {
    $http.post('/api/pay/' + $scope.paymentMethod, $scope.recharge).then(function(res) {
      $scope.orderInfo = res.data
      $mdDialog.show({
        contentElement: '#payQrcode',
        parent: angular.element(document.body),
        targetEvent: ev,
        clickOutsideToClose: false,
        fullscreen: true
      })
      $interval(function() {
        $http.get('/api/pay/' + $scope.paymentMethod + '?order_id=' + res.data.out_trade_no).then(function(callback) {
          var status = callback.data.trade_status
          if (status) {
            $scope.trade_status = status == 'TRADE_SUCCESS' || status == 'TRADE_FINISHED' ? true : false
          } else if (callback.data.code == '10000') {
            $scope.trade_status = true;
          } else {
            $scope.trade_status = false;
          }
        })
      }, 2000)
    })
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
      <p>如果无法通过快捷支付的方式充值，可直接转账至下发</p>
      <md-radio-group ng-model="payQrcode">
        <md-radio-button value="wxp://f2f0aZ-_6vh-VMhIsJ2xtGFboGi6RD57Oc0y" ng-selected="true">
          <img class="payment-method" src="/assets/p-ss.men/img/pay_wepay.svg" alt="微信支付">
        </md-radio-button>
        <md-radio-button value="https://qr.alipay.com/stx05409hdhfupvsyjxwld7">
          <img class="payment-method" src="/assets/p-ss.men/img/pay_alipay.svg" alt="支付宝">
        </md-radio-button>
      </md-radio-group>
      <img class="pay-qrcode" ng-if="payQrcode" ng-src="/res/qrcode?size=480&text={literal}{{payQrcode}}{/literal}">
    </md-tab>
  </md-tabs>
  <div style="visibility:hidden">
    <div class="md-dialog-container pay-qrcode-wrap" id="payQrcode">
      <md-dialog layout-padding layout="column" layout-align="center center" flex="80">
        <h1 class="md-display-2" ng-bind="recharge.money|currency:'¥':2"></h1>
        <img class="pay-qrcode" ng-src="/res/qrcode?size=480&text={literal}{{orderInfo.qr_code}}{/literal}">
        <div class="order-info" layout="column" layout-padding>
          <p layout="row" flex>
            <span flex>商品名称</span>
            <span>{$config["appName"]} 充值</span>
          </p>
          <p layout="row" flex>
            <span flex>交易单号</span>
            <span ng-bind="orderInfo.out_trade_no"></span>
          </p>
        </div>
      </md-dialog>
    </div>
  </div>
</div>
{/block}
