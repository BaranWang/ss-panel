{extends file='admin/layout.tpl'}
{block name=main}
<div class="page-title" layout-padding>
  <h2 class="md-headline">管理中心 <span class="md-subhead">Admin Control</span></h2>
</div>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="33" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">总用户</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <span class="md-display-3">{$sts->getTotalUser()}</span>
      </md-card-content>
      <md-card-actions layout="row" layout-align="start center">
        <md-button href="/admin/user">
          <md-icon class="material-icons">&#xE5C8;</md-icon>
          用户管理
        </md-button>
      </md-card-actions>
    </md-card>
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">产生流量</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <span class="md-display-3">{$sts->getTrafficUsage()}</span>
      </md-card-content>
      <md-card-actions layout="row" layout-align="start center">
        <md-button href="/admin/trafficlog">
          <md-icon class="material-icons">&#xE5C8;</md-icon>
          流量记录
        </md-button>
      </md-card-actions>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="33" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">前一小时在线用户</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <span class="md-display-3">{$sts->getOnlineUser(3600)}</span>
      </md-card-content>
      <md-card-actions layout="row" layout-align="start center">
        <md-button href="/admin/invite">
          <md-icon class="material-icons">&#xE5C8;</md-icon>
          邀请管理
        </md-button>
      </md-card-actions>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="33" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">节点数</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <span class="md-display-3">{$sts->getTotalNode()}</span>
      </md-card-content>
      <md-card-actions layout="row" layout-align="start center">
        <md-button href="/admin/node">
          <md-icon class="material-icons">&#xE5C8;</md-icon>
          节点管理
        </md-button>
      </md-card-actions>
    </md-card>
  </div>
</md-content>
{/block}
