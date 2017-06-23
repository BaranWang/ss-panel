{extends file='user/layout.tpl'}
{block name=jslink}
<script src="//cdn.bootcss.com/clipboard.js/1.7.1/clipboard.min.js"></script>
<script src="//cdn.bootcss.com/ngclipboard/1.1.1/ngclipboard.min.js"></script>
{/block}
{block name=ng}'ngclipboard'{/block}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $window) {
    $scope.getCode = function() {
      $http.post('/user/invite', { num: 1 }).then(function() {
        $window.location.reload()
      })
    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">邀请好友 <span class="md-subhead">Invite</span></h2>
</div>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">获取邀请码</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <p>当前你还可以获取 {$user->invite_num} 个邀请码</p>
        {if $user->invite_num}
        <md-button class="md-raised md-primary" ng-click="getCode()" ng-disabled="webpwdForm.$invalid">获取我的邀请码</md-button>
        {/if}
        {foreach $codes as $code}
        <md-list-item class="secondary-button-padding">
          <p>{$code->code}（可用）</p>
          <md-button class="md-secondary md-icon-button" ngclipboard data-clipboard-text="{$config['baseUrl']}/auth/register?code={$code->code}">
            <md-icon class="material-icons">&#xE14D;</md-icon>
          </md-button>
        </md-list-item>
        {/foreach}
      </md-card-content>
    </md-card>
  </div>
</md-content>
{/block}
