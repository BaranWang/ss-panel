{extends file='user/layout.tpl'}
{block name=main}
<h2 class="md-headline">用户中心 <span class="md-subhead">User Center</span></h2>
<div layout-xs="column" layout="row">
  <div flex-xs flex-gt-xs="50" layout="column">
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">公告</md-card-title-text>
      </md-card-title>
      <md-card-content>{$msg}</md-card-content>
    </md-card>
  </div>
  <div flex-xs flex-gt-xs="50" layout="column">
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
    <md-card>
      <md-card-title>
        <md-card-title-text class="md-headline">公告</md-card-title-text>
      </md-card-title>
      <md-card-content>{$msg}</md-card-content>
    </md-card>
  </div>
</div>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">

    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">公告&FAQ</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-exchange"></i>

                        <h3 class="box-title">流量使用情况</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dl class="dl-horizontal">
                            <dt>总流量</dt>
                            <dd>{$user->enableTraffic()}</dd>
                            <dt>已用流量</dt>
                            <dd>{$user->usedTraffic()}</dd>
                            <dt>剩余流量</dt>
                            <dd>{$user->unusedTraffic()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>

                        <h3 class="box-title">签到获取流量</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p> 每{$config['checkinTime']}小时可以签到一次。</p>

                        <p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success  btn-flat">签到</button>
                            </p>
                        {else}
                            <p><a class="btn btn-success btn-flat disabled" href="#">不能签到</a></p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa  fa-paper-plane"></i>

                        <h3 class="box-title">连接信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <dl class="dl-horizontal">
                            <dt>端口</dt>
                            <dd>{$user->port}</dd>
                            <dt>密码</dt>
                            <dd>{$user->passwd}</dd>
                            <dt>自定义加密方式</dt>
                            <dd>{$user->method}</dd>
                            <dt>上次使用</dt>
                            <dd>{$user->lastSsTime()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        </div>
        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

{* <script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}*}
{/block}
