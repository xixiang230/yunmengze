---
title: hexo 标签无法显示
date: 2016-05-15 15:38:34
tags:
---
# hexo标签页无法显示  
打开提示： Cannot GET /tags/  
<!-- more -->
# 解决办法  
1. 步骤一: 新建一个页面，命名为tags  
```hexo new page "tags"```  
2. 步骤二: 编辑上述新建页面，将页面类型设置为tags，主题将自动为这个页面显示标签云  
<pre><code>
title: tags  
date: 2016-05-15 15:32:36  
type: "tags"  
</code></pre>  
3. 编辑主题配置文件，添加tags到menu中  
``` 
menu  
      home: /  
      archives: /archives  
      tags: /tags  
```  
