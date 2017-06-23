{extends file='user/layout.tpl'}
{block name=main}
<script src="//a.alipayobjects.com/g/datavis/g2/2.3.5/g2.js"></script>
<script>
  MyApp.controller('ViewController', function($scope, $http) {
    $http.post('').then(function(res) {
      var chart = new G2.Chart({
        id: 'chart',
        forceFit: true,
        height: 480,
      });
      chart.source(res.data, {
        'log_time': {
          type: 'time',
          alias: '时间',
          mask: 'yy/m/dd H:mm:ss',
        },
        'node': {
          alias: '节点',
        },
        'traffic': {
          alias: '流量',
          formatter: function(bytes) {
            if (bytes > 0) {
              var s = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
              var e = Math.floor(Math.log(bytes)/Math.log(1024));
              return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
            } else {
              return '0 bytes'
            }
          }
        }
      });
      chart.axis('log_time', { title: null });
      chart.axis('traffic', { labels: null });
      chart.line().position('log_time*traffic').color('node').shape('smooth').size(2);
      chart.render();
    })
  });
</script>
<div class="page-title" layout-padding>
  <h2 class="md-headline">流量使用记录 <span class="md-subhead">Traffic Log</span></h2>
</div>
<div id="chart"></div>


{/block}
