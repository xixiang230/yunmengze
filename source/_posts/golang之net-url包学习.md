---
title: golang之net/url包学习
date: 2016-05-16 11:33:00
tags:
---
# URL编码解码  
escape采用ISO Latin字符集对指定的字符串进行编码。所有的空格符、标点符号、特殊字符以及其他非ASCII字符都将被转化成%xx格式的字符编码(xx等于该字符在字符集表里面的编码的16进制数字)。类escape函数是一个可转换编码的函数,比如javascript 的 ajax 中,向a.php传递参数?city=北京,可先将"北京"用escape重新编码,再进行传递,在服务器端接收后再解码才不会出现乱码。escape一般用于传递URL参数和类似urlencode base64_encode函数是类似的。  

     func QueryEscape(s string) string  
QueryEscape escapes the string so it can be safely placed inside a URL query.  

     func QueryUnescape(s string) (string, error)  
    
QueryUnescape does the inverse transformation of QueryEscape, converting %AB into the byte 0xAB and '+' into ' ' (space). It returns an error if any % is not followed by two hexadecimal digits.  
    
    str := "abc#cba"  
    out := url.QueryEscape(str)  
    fmt.Println(out)                 # abc%23cba
    re, _ := url.QueryUnescape(str)  # abc#cba
    fmt.Println(re)  
    
QueryUnescape  
%AB  ----> 0xAB  
'+'  ----> ' '  

    strA := "abc%23cba"  
    strB := "abc+cba"  
    reA, _ := url.QueryUnescape(strA)  
    fmt.Println(reA)  # abc#cba
    reB, _ := url.QueryUnescape(strB)  
    fmt.Println(reB)  # abc cbd  
  ---  

# 错误 
* type Error  
       
      type Error struct {  
        Op  string  
        URL string  
        Err error  
      }  
    
Error reports an error and the operation and URL that caused it. 
 
* func (e *Error) Error() string    
* func (e *Error) Temporary() bool  
* func (e *Error) Timeout() bool  
* type EscapeError string  
* func (EscapeError) Error() string  
* type InvalidHostError  
* type InvalidHostError string  
* func (e InvalidHostError) Error() string 
 
---
#  请求参数  
1. type Values  
    
       type Values map[string][]string  
Values maps a string key to a list of values. It is typically used for query parameters and form values. Unlike in the http.Header map, the keys in a Values map are case-sensitive.  

2. func (Values) Add  

       func (v Values) Add(key, value string)  
Add adds the value to key. It appends to any existing values associated with key.  

3. func (Values) Del  

       func (v Values) Del(key string)  
 Del deletes the values associated with key.  
 
4. func (Values) Encode  

       func (v Values) Encode() string  
Encode encodes the values into “URL encoded” form ("bar=baz&foo=quux") sorted by key.  

5. func (Values) Get  

       func (v Values) Get(key string) string  
Get gets the first value associated with the given key. If there are no values associated with the key, Get returns the empty string. To access multiple values, use the map directly.  

6. func (Values) Set  

       func (v Values) Set(key, value string)  
Set sets the key to value. It replaces any existing values.  

7. func ParseQuery  

       func ParseQuery(query string) (m Values, err error)  
ParseQuery parses the URL-encoded query string and returns a map listing the values specified for each key. ParseQuery always returns a non-nil map containing all the valid query parameters found; err describes the first decoding error encountered, if any.  