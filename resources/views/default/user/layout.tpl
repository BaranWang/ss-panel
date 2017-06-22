{extends file='layout.tpl'}
{$sidenav['<md-icon class="material-icons">&#xE6C4;</md-icon>用户中心']="/user"}
{$sidenav['<md-icon class="material-icons">&#xE335;</md-icon>节点列表']="/user/node"}
{$sidenav['<md-icon class="material-icons">&#xE853;</md-icon>我的信息']="/user/profile"}
{$sidenav['<md-icon class="material-icons">&#xE889;</md-icon>流量记录']="/user/trafficlog"}
{$sidenav['<md-icon class="material-icons">&#xE8B8;</md-icon>修改资料']="/user/edit"}
{$sidenav['<md-icon class="material-icons">&#xE638;</md-icon>邀请好友']="/user/invite"}
{block name=main}{/block}
