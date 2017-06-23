{extends file='user/layout.tpl'}
{block name=main}
<div class="page-title" layout-padding>
  <h2 class="md-headline">节点列表 <span class="md-subhead">Node List</span></h2>
</div>
<md-subheader class="md-warn tips">
  <md-icon class="material-icons md-warn">&#xE002;</md-icon>
  请勿在任何地方公开节点地址
</md-subheader>
<md-content layout-xs="column" layout="row" layout-wrap>
  {foreach $nodes as $node}
  <div flex-xs flex-gt-xs="50" flex-gt-md="33" flex-gt-lg="25">
    <md-card>
      <md-card-title>
        <md-card-title-text>
          <span class="md-headline">{$node->name}</span>
        </md-card-title-text>
      </md-card-title>
      <md-card-content>
        <p>节点地址：{$node->server}:{$user->port}</p>
        <p>加密方式：{if $node->custom_method == 1} {$user->method} {else} {$node->method} {/if}</p>
      </md-card-content>
      <md-card-actions layout="row" layout-align="end center">
        <md-button ng-href="./node/{$node->id}">
          <span>查看详情</span>
          <md-icon class="material-icons">&#xE5C8;</md-icon>
        </md-button>
      </md-card-actions>
    </md-card>
  </div>
  {/foreach}
</md-content>

{/block}
