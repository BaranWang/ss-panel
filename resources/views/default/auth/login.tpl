{include file='header.tpl'}
<title>登录 - {$config["appName"]}</title>
<div layout="row" layout-align="center center">
  <md-card>
    <md-card-title>
      <md-card-title-text>
        <span class="md-headline">登录 {$config["appName"]}</span>
      </md-card-title-text>
    </md-card-title>
    <md-card-content layout="column">
      <form name="userForm" method="post">
        <md-input-container>
          <label>E-mail</label>
          <input ng-model="user.email">
        </md-input-container>
        <md-input-container>
          <label>密码</label>
          <input ng-model="user.passwd">
        </md-input-container>
        <md-input-container>
          <md-checkbox ng-model="user.remember_me">记住我</md-checkbox>
        </md-input-container>
        <md-button type="submit" class="md-raised md-primary">登录</md-button>
      </form>
    </md-card-content>
  </md-card>
</div>

<!-- <script>
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
        function login(){
            $.ajax({
                type:"POST",
                url:"/auth/login",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    passwd: $("#passwd").val(),
                    remember_me: $("#remember_me").val()
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/user'", 2000);
                    }else{
                        $("#msg-success").hide(10);
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
        $("#login").click(function(){
            login();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script> -->
{include file='footer.tpl'}
