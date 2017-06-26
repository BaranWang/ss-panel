{extends file='layout.tpl'}
{block name=title}重置密码 - {/block}
{block name=jslink}
<script src="//www.google.com/recaptcha/api.js"></script>
{/block}
{block name=main}
<script>
  // @flow
  function getRecaptchaResponse() {
    angular.element(document.querySelector('[ng-controller="ViewController"]'))
    .scope()
    .resetFunction(grecaptcha.getResponse());
  }
  MyApp.controller('ViewController', function($scope, $http, $window, $mdDialog) {
    $scope.resetFunction = function(grecaptchaResponse) {
      $http.post('/api/reCAPTCHA', {
        'g-recaptcha-response': grecaptchaResponse
      }).then(function(res) {
        if (res.data.success) {
          $http.post('/password/reset',$scope.email).then(function(res) {
            $mdDialog.show(
              $mdDialog.alert()
              .clickOutsideToClose(true)
              .textContent(res.data.msg)
              .ok('知道了')
            ).then(function() {
              $window.location.href = res.data.ret ? '/auth/login' : '/auth/register?email=' + $scope.email.email
            })
          })
        }
      })
    }
  })
</script>
<div class="card-page" layout="row" layout-align="center center">
  <md-card layout-padding>
    <md-card-title>
      <md-card-title-text>
        <span class="md-headline">登录 {$config["appName"]}</span>
      </md-card-title-text>
    </md-card-title>
    <md-card-content>
      <form layout="column" name="resetForm" ng-submit="resetFunction('')">
        <md-input-container>
          <label>E-mail</label>
          <md-icon class="material-icons">&#xE0BE;</md-icon>
          <input type="email" name="email" ng-model="email.email" required>
        </md-input-container>
        <md-button type="submit" class="md-raised md-primary g-recaptcha"
        data-sitekey="6LcJyCYUAAAAAF9cJ2OoC_sLAHDRxuARgAaiR4Bx"
        data-callback="getRecaptchaResponse"
        ng-disabled="resetForm.$invalid">重置密码</md-button>
        <md-input-container ng-if="errorMsg">
          <span class="md-input-message-animation" ng-bind="errorMsg"></span>
        </md-input-container>
      </form>
    </md-card-content>
    <md-card-actions layout="row" layout-align="center center">
      <a class="md-primary" href="/auth/register">没有账号？立即注册</a>
    </md-card-actions>
  </md-card>
</div>



{*
<body class="login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>{$config['appName']}</b></a>
    </div><!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">重置密码</p>

        <form>
            <div class="form-group has-feedback">
                <input id="email" name="Email" type="text" class="form-control" placeholder="邮箱"/>
                <span  class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>

        </form>
        <div class="row">

            <div class="col-xs-4">
                <button id="reset" type="submit" class="btn btn-primary btn-block btn-flat">重置密码</button>
            </div><!-- /.col -->
        </div>
        <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
            <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-info"></i> 成功!</h4>
            <p id="msg-success-p"></p>
        </div>
        <div id="msg-error" class="alert alert-warning alert-dismissable" style="display: none;">
            <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-warning"></i> 出错了!</h4>
            <p id="msg-error-p"></p>
        </div>
        <a href="/auth/login">登陆</a><br>
        <a href="/auth/register" class="text-center">注册个帐号</a>

    </div><!-- /.login-box-body -->
</div><!-- /.login-box -->

<!-- jQuery 2.1.3 -->
<script src="/assets/public/js/jquery.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="/assets/public/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="/assets/public/js/icheck.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
    // $("#msg-error").hide(100);
    // $("#msg-success").hide(100);
</script>
<script>
    $(document).ready(function(){
        function reset(){
            $.ajax({
                type:"POST",
                url:"/password/reset",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                       // window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
            }
        });
        $("#reset").click(function(){
            reset();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script> *}
{/block}
