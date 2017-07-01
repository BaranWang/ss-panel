{extends file='admin/layout.tpl'}
{block name=main}
<script>
  MyApp.controller('ViewController', function($scope, $http, $mdDialog) {
    $scope.user = {$userinfo};
    $scope.user.user_name = '{$userinfo->user_name}';
    $scope.user.is_admin = {$userinfo->is_admin};
    $scope.user.transfer_enable = {$user->enableTrafficInGB()};
    $scope.userFunction = function() {
      $http.put('/admin/user/{$user->id}', $scope.user).then(function(res) {
        $mdDialog.show(
          $mdDialog.alert()
          .clickOutsideToClose(true)
          .textContent(res.data.msg)
          .ok('知道了')
        )
      })
    }
  })
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">编辑用户 #{$user->id} <span class="md-subhead">Edit User #{$user->id}</span></h2>
</div>
<form ng-submit="userFunction()">
  <div layout-xs="column" layout="row">
    <div flex-xs flex-gt-xs="50" layout="column">
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">帐号信息</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>昵称</label>
            <input type="text" name="user_name" ng-model="user.user_name">
          </md-input-container>
          <md-input-container>
            <label>E-mail</label>
            <input type="email" name="email" ng-model="user.email">
          </md-input-container>
          <md-input-container>
            <label>密码</label>
            <input type="text" name="pass" ng-model="user.pass" placeholder="不修改时留空">
          </md-input-container>
          <md-switch md-invert name="is_admin" ng-model="user.is_admin" ng-true-value="1" ng-false-value="0" style="margin-top:0">是否为管理员</md-switch>
        </md-card-content>
      </md-card>
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">流量</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>总流量 (GB)</label>
            <input type="number" name="transfer_enable" ng-model="user.transfer_enable">
          </md-input-container>
          <md-input-container>
            <label>已用流量</label>
            <input type="text" value="{$user->usedTraffic()}" disabled>
          </md-input-container>
        </md-card-content>
      </md-card>
    </div>
    <div flex-xs flex-gt-xs="50" layout="column">
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">Shadowsocks 连接信息</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>连接端口</label>
            <input type="number" name="port" ng-model="user.port">
          </md-input-container>
          <md-input-container>
            <label>连接密码</label>
            <input type="text" name="passwd" ng-model="user.passwd">
          </md-input-container>
          <md-input-container>
            <label>自定义加密</label>
            <md-select name="method" ng-model="user.method">
              {foreach $method as $cipher}
              <md-option value="{$cipher}">{$cipher}</md-option>
              {/foreach}
            </md-select>
          </md-input-container>
        </md-card-content>
      </md-card>
      <md-card>
        <md-card-title>
          <md-card-title-text class="md-headline">邀请</md-card-title-text>
        </md-card-title>
        <md-card-content layout="column">
          <md-input-container>
            <label>可用邀请数量</label>
            <input type="number" name="invite_num" ng-model="user.invite_num">
          </md-input-container>
          <md-input-container>
            <label>邀请人 ID</label>
            <input type="text" value="{$user->ref_by}" disabled>
          </md-input-container>
        </md-card-content>
      </md-card>
    </div>
  </div>
  <div layout="row" layout-align="start center">
    <md-button type="submit" class="md-raised md-primary" flex-xs flex-sm>保存修改</md-button>
  </div>
</form>

{*
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户编辑 #{$user->id}
            <small>Edit User</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">

        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="form-horizontal">
                            <div class="row">
                                <fieldset class="col-sm-6">
                                    <legend>帐号信息</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">昵称</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="user_name" value="{$user->user_name}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">邮箱</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="email" type="email" value="{$user->email}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">密码</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="pass" value="" placeholder="不修改时留空">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">是否管理员</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="is_admin">
                                                <option value="0" {if $user->is_admin==0}selected="selected"{/if}>
                                                    否
                                                </option>
                                                <option value="1" {if $user->is_admin==1}selected="selected"{/if}>
                                                    是
                                                </option>
                                            </select>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">用户状态</label>

                                        <div class="col-sm-9"><select class="form-control" id="enable">
                                                <option value="1" {if $user->enable==1}selected="selected"{/if}>
                                                    正常
                                                </option>
                                                <option value="0" {if $user->enable==0}selected="selected"{/if}>
                                                    禁用
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                </fieldset>
                                <fieldset class="col-sm-6">
                                    <legend>ShadowSocks连接信息</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">连接端口</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="port" type="number" value="{$user->port}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">连接密码</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="passwd" value="{$user->passwd}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">自定义加密</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="method">
                                            {foreach $method as $cipher}
                                               <option value="{$cipher}" {if $user->method==$cipher}selected="selected"{/if} >{$cipher}</option>
                                            {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="row">
                                <fieldset class="col-sm-6">
                                    <legend>流量</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">总流量</label>

                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <input class="form-control" id="transfer_enable" type="number"
                                                       value="{$user->enableTrafficInGB()}">

                                                <div class="input-group-addon">GiB</div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">已用流量</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="traffic_usage" type="text"
                                                   value="{$user->usedTraffic()}" readonly>
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset class="col-sm-6">
                                    <legend>邀请</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">可用邀请数量</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="invite_num" type="number"
                                                   value="{$user->invite_num}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">邀请人ID</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="ref_by" type="number"
                                                   value="{$user->ref_by}" readonly>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" id="submit" name="action" value="add" class="btn btn-primary">修改</button>
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "PUT",
                url: "/admin/user/{$user->id}",
                dataType: "json",
                data: {
                    user_name: $("#user_name").val(),
                    email: $("#email").val(),
                    pass: $("#pass").val(),
                    port: $("#port").val(),
                    passwd: $("#passwd").val(),
                    transfer_enable: $("#transfer_enable").val(),
                    invite_num: $("#invite_num").val(),
                    method: $("#method").val(),
                    enable: $("#enable").val(),
                    is_admin: $("#is_admin").val(),
                    ref_by: $("#ref_by").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/user'", 2000);
                    } else {
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误：" + jqXHR.status);
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#submit").click(function () {
            submit();
        });
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
    })
</script> *}


{/block}
