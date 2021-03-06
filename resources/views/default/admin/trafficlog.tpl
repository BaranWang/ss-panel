{extends file='admin/layout.tpl'}
{block name=main}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            流量使用记录
            <small>Traffic Log</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>
                    <p>部分节点不支持流量记录.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box form-inline">
                    <div class="form-group">
                        <label for="labelUser">用户</label>
                        <select id="search-user">
                            <option value="0">所有人</option>
                        {foreach $users as $user}
                            <option value="{$user->id}" {if $user->id==$seleUser}selected="selected"{/if}>
                                {$user->user_name}
                            </option>
                        {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="labelNode">节点</label>
                        <select id="search-node">
                            <option value="0">所有节点</option>
                        {foreach $nodes as $node}
                            <option value="{$node->id}" {if $node->id==$seleNode}selected="selected"{/if}>
                                {$node->name}
                            </option>
                        {/foreach}
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary" id="log-search">搜索</button>
                </div>
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$logs}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>用户</th>
                                <th>使用节点</th>
                                <th>倍率</th>
                                <th>实际使用流量</th>
                                <th>结算流量</th>
                                <th>记录时间</th>
                            </tr>
                            {foreach $logs as $log}
                                <tr>
                                    <td>#{$log->id}</td>
                                    <td>{$log->user()->user_name}</td>
                                    <td>{$log->node()->name}</td>
                                    <td>{$log->rate}</td>
                                    <td>{$log->totalUsed()}</td>
                                    <td>{$log->traffic}</td>
                                    <td>{$log->logTime()}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<script>
    $(document).ready(function () {
        $("#log-search").click(function () {
            window.setTimeout("location.href='/admin/trafficlog/"+$("#search-node").val()+"/"+$("#search-user").val()+"'", 500);
        })
    })
</script>

{/block}
