---
title: MySQL之DUAL表
date: 2016-06-21 20:46:51
tags: [MySQL]
categories: [技术]
---
# 什么是DUAL表  
You are allowed to specify DUAL as a dummy table name in situations where no table no tables are referenced.  
```
SELECT 1 + 1 FROM DUAL;
```
DUAL is purely for the convenience of people who require that all SELECT statements should have FROM and
 possibly other clauses. MySQL may ignore the clauses. MySQL does not require FROM DUAL if no tables are referenced.
# 应用  
利用MySQL的DUAL表，可达到不插入重复记录的目的。  
```
SELECT express [FROM DUAL];  
```
MySQL总是作为返回该表达式值的普通SELECT语句执行，返回一行记录的结果集，FROM DUAL对MySQL来说是摆设。
```
SELECT express [FROM DUAL] WHERE 0=2;
```
先计算WHERE条件，再计算express，返回空集。  
```
INSERT INTO `demo` (id,name,value) SELECT 1,2,4 from DUAL WHERE NOT EXISTS (SELECT * FROM `demo` WHERE id=1 AND name=2) LIMIT 1;
```
```
INSERT INTO TableName(column1, column2, column3, ...columnN)
SELECT value1, value2, value3, ...valueN FROM  DUAL
WHERE NOT EXISTS(
    SELECT * 
    FROM TableName
    WHERE value = ?
);
```
DUAL是为了构建查询语句而存在的表。
# 实例  
```
INSERT INTO Class(name, age) VALUES ('baidu', 5);
INSERT INTO Class(name, age) VALUES ('tecent',5);
```
对于普通的INSERT插入，如果想要保证不插入重复记录，方法之一就是对某个字段创建唯一约束实现，如果没有创建唯一约束，
则可使用INSERT INTO IF EXISTS实现。
```
INSERT INTO tableName(field1, field2, fieldn) SELECT 'field1', 'field2', 'fieldn'
FROM DUAL 
WHERE NOT EXISTS(SELECT filed FROM tableName WHERE fiedl = ?)
```
```
INSERT INTO Class(name, age) SELECT 'baidu', '100' FROM DUAL WHERE NOT EXISTS(SELECT Class FROM name WHERE name = 'baidu') limit1;
INSERT INTO Class(name, age) SELECT 'tecent', '200' FROM DUAL WHERE NOT EXISTS(SELECT Class FROM name WHERE name = 'tecent') limit1;
```
上面的limit1用来避免duplicate entry。  
# 使用INSERT IGNORE  
当使用INSERT IGNORE插入必须有一个唯一索引或者主键，前面介绍的方法则无此条件。  
