{extends file='user/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $window) {
    $scope.refunds = function() {
      $window.open(
        'mailto:admin@mail.p-ss.men?cc=me@baran.wang&subject=' + encodeURIComponent('{$config["appName"]} 用户 {$user.user_name} 申请提现') + '&body=' + encodeURIComponent('ID:{$user.id}\r\n注册邮箱：{$user.email}\r\n昵称：{$user.user_name}\r\n账户余额：{$user->balance()} 元\r\n提现金额：在此输入提现金额（单位为元）'),
        '_blank'
      )
    };
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">用戶中心 <span class="md-subhead">User Center</span></h2>
</div>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title ng-click="fee=!fee">
        <md-card-title-text class="md-headline">资费相关</md-card-title-text>
        <md-icon class="material-icons" ng-bind-template="{literal}{{fee?'&#xE5CE;':'&#xE5CF;'}}{/literal}"></md-icon>
      </md-card-title>
      <md-card-content ng-show="fee">
        <p>
          {$config["appName"]} 所有消费均以充值人民币（ CNY ）预付费方式结算，如需提现请联系
          <a class="md-primary" ng-click="refunds()">admin@mail.p-ss.men</a>；
        </p>
        <p>账户余额与剩余流量绑定 1 元 / G，新用户注册即送 {$smarty.env.defaultTraffic}G 流量以供体验；</p>
        <p>账户每日收取基础日租 1 元，用以网站及服务器等相关的维护经费，每日 0 点从余额中扣除。</p>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-title ng-click="how2use=!how2use">
        <md-card-title-text class="md-headline">如何使用？</md-card-title-text>
        <md-icon class="material-icons" ng-bind-template="{literal}{{how2use?'&#xE5CE;':'&#xE5CF;'}}{/literal}"></md-icon>
      </md-card-title>
      <md-card-content ng-show="how2use">
        <h3 class="md-title"><md-icon class="material-icons md-primary" aria-label="1">&#xE400;</md-icon> 下载客户端</h3>
        <p>
          <md-icon class="material-icons">&#xE30B;</md-icon>
          Mac OS 用户下载
          <md-button class="md-primary" target="_blank" href="https://github.com/shadowsocks/ShadowsocksX-NG/releases/latest">ShadowsocksX-NG</md-button>
          <br>
          <md-icon class="material-icons">&#xE30C;</md-icon>
          Windows 用户下载
          <md-button class="md-primary" target="_blank" href="https://github.com/shadowsocksr/shadowsocksr-csharp/releases/latest">shadowsocksr-csharp</md-button>
          <br>
          <md-icon class="material-icons">&#xE325;</md-icon>
          iOS 用户推荐使用
          <md-button class="md-primary" target="_blank" href="https://itunes.apple.com/app/id1162704202">Potatso</md-button>
          <br>
          <md-icon class="material-icons">&#xE324;</md-icon>
          Android 用户下载
          <md-button class="md-primary" target="_blank" href="https://play.google.com/store/apps/details?id=com.github.shadowsocks">Shadowsocks</md-button>
        </p>
        <h3 class="md-title"><md-icon class="material-icons md-primary" aria-label="2">&#xE401;</md-icon> 导入节点配置</h3>
        <p>点击左侧菜单「节点列表」 → 「查看详情」，点击配置地址后方的按钮 <md-icon class="material-icons">&#xE157;</md-icon> 自动导入到客户端中。</p>
        <p>部分客户端可能不支持 ss:// 协议直接导入配置，可使用扫码屏幕二维码的方式自动导入或手动输入信息配置</p>
        <h3 class="md-title"><md-icon class="material-icons md-primary" aria-label="3">&#xE3FB;</md-icon> 开始自由的科学上网</h3>
        <p>将客户端服务器地址选择为刚导入的信息，并设置 PAC 代理模式，就可以愉快的开始科学上网了！</p>
      </md-card-content>
    </md-card>
    {if $msg}
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">公共</md-card-title-text>
      </md-card-title>
      <md-card-content>{$msg}</md-card-content>
    </md-card>
    {/if}
  </div>
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">账户余额</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <p class="md-display-1" ng-bind="'{$user->balance()}'|currency:'¥'" style="margin-bottom:16px"></p>
        <md-button class="md-raised md-primary" ng-href="/user/recharge">立即充值</md-button>
        <md-button class="md-primary" ng-href="/user/bill">账单明细</md-button>
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
