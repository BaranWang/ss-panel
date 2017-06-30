{extends file='admin/layout.tpl'}
{block name=main}
<div class="page-title" layout-padding>
  <h2 class="md-headline">用户列表 <span class="md-subhead">User List</span></h2>
</div>
<md-content layout-padding layout-margin>
  <table class="md-table md-whiteframe-1dp" width="100%">
    <tr>
      <th>ID</th>
      <th class="cell--non-numeric">邮箱</th>
      <th>已用流量/总流量</th>
      <th>最后在线时间</th>

      <th>注册时间</th>
      <th>邀请者</th>
      <th>操作</th>
    </tr>
    {foreach $users as $user}
    <tr {if !$user->enable}style="background:#eee;color:#999"{/if}>
      <td>#{$user->id}</td>
      <td class="cell--non-numeric">
        <span>
          {$user->email}
          <md-tooltip md-direction="bottom">{$user->user_name}</md-tooltip>
        </span>
      </td>

      <td>{$user->usedTraffic()}/{$user->enableTraffic()}</td>
      <td>{$user->lastSsTime()}</td>
      <td>{$user->reg_date}</td>
      <td>{$user->ref_by}</td>
      <td>
        <md-menu md-position-mode="target-right target">
          <md-button class="md-icon-button" ng-click="$mdMenu.open($event)">
            <md-icon class="material-icons">&#xE5D4;</md-icon>
          </md-button>
          <md-menu-content width="4">
            <md-menu-item>
              <md-button href="/admin/user/{$user->id}/edit">
                <md-icon class="material-icons">&#xE254;</md-icon>
                编辑
              </md-button>
            </md-menu-item>
            {* <md-menu-item>
              <md-button ng-click="delete('{$node->name}',{$node->id})">
                <md-icon class="material-icons">&#xE872;</md-icon>
                删除
              </md-button>
            </md-menu-item> *}
          </md-menu-content>
        </md-menu>
      </td>
    </tr>
    {/foreach}
  </table>
</md-content>
{/block}
