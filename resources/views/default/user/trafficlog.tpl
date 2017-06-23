{extends file='user/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $location, $window) {
    $scope.goto = function(url) {
      if (url != $location.absUrl().split($location.host())[1]) {
        $window.location.href = url
      }
    };
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">流量使用记录 <span class="md-subhead">Traffic Log</span></h2>
</div>
<div layout="row" layout-align="start center" layout-padding>
  <md-input-container>
    <md-select ng-model="nodeId">
      <md-option value="-1" {if $seleNode=='-1'}selected{/if}>所有节点</md-option>
      {foreach $nodes as $node}
      <md-option value="{$node->id}" {if $node->id==$seleNode}selected{/if}>{$node->name}</md-option>
      {/foreach}
    </md-select>
  </md-input-container>
  <md-input-container>
    <md-button class="md-raised md-primary" ng-href="/user/trafficlog{literal}{{ nodeId > 0 ? '/' + nodeId : '' }}{/literal}?page=1">搜索</md-button>
  </md-input-container>
</div>
<md-list>
  <md-list-item>
    <span flex="15">ID</span>
    <span flex="15">使用节点</span>
    <span flex="30">使用流量</span>
    <span flex="40">记录时间</span>
  </md-list-item>
  {foreach $logs as $log}
  <md-list-item>
    <span flex="15">#{$log->id}</span>
    <span flex="15">{$log->node()->name}</span>
    <span flex="30">{$log->traffic}</span>
    <span flex="40">{$log->logTime()|date_format:"%m-%d %T"}</span>
  </md-list-item>
  {/foreach}
</md-list>

{if $page.last_page > 1}
<div layout="row" layout-align="start center">
  <md-button class="md-icon-button md-raised" ng-href="{$page.prev_page_url}" ng-disabled="{$page.current_page}==1"><md-icon class="material-icons">&#xE408;</md-icon></md-button>
  <span>第</span>
  <md-input-container>
    <md-select ng-model="page" ng-change="goto(page)">
      <md-option value="{$smarty.server.REDIRECT_URL}?page={literal}{{i}}{/literal}" ng-repeat="i in {$page.array} track by $index" ng-bind="i" ng-selected="{$page.current_page}==i"></md-option>
    </md-select>
  </md-input-container>
  <span>页</span>
  <md-button class="md-icon-button md-raised" ng-href="{$page.next_page_url}" ng-disabled="{$page.current_page}=={$page.last_page}"><md-icon class="material-icons">&#xE409;</md-icon></md-button>
</div>
{/if}
{/block}
