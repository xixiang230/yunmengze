---
title: Golang web开发get、post参数解析
date: 2016-05-18 07:52:28
tags: [Go]
---

# http.request三大属性  
* Form属性  
存储post、put、get参数，在使用之前需要调用ParseForm方法  
* PostForm  
存储post、put参数，在使用之前需要调用ParseForm方法  
* MultipartForm  
存储了包含文件上传表单的post参数，在使用之前需要调用ParseMultipartForm方法 