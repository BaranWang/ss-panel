{extends file='user/layout.tpl'}
{block name=main}
<script>
  MyApp.config(function($compileProvider) {
    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|blob|ss|chrome-extension):/);
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">节点详情 <span class="md-subhead">Node Info</span></h2>
</div>
<md-subheader class="md-warn tips">
  <md-icon class="material-icons md-warn">&#xE002;</md-icon>
  配置文件以及二维码请勿泄露
</md-subheader>
<md-content layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">配置 JSON</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <pre class="md-body-1">{$json_show}</pre>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">配置地址</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <div layout="row">
          <md-input-container md-no-float flex>
            <input type="text" value="{$ssqr}">
          </md-input-container>
          <md-button class="md-fab md-mini" href="{$ssqr}">
            <md-icon class="material-icons">&#xE157;</md-icon>
          </md-button>
        </div>
      </md-card-content>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">配置二维码</md-card-title-text>
      </md-card-title>
      <md-card-content>
        <div layout="column" layout-align="start center">
          <img class="md-card-image" src="/res/qrcode?text={$ssqr|escape:'url'}&type=svg" flex>
          <p>扫描二维码直接导入配置</p>
        </div>
      </md-card-content>
    </md-card>
  </div>
</md-content>
{/block}
