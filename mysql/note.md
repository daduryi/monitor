## MySQL服务器逻辑架构图

## A Transaction SQL.png

## show variables like 'autocommit';  MysSQL默认采用自动提交模式

## InnoDB也支持通过特定的语句进行显示的锁定
select .. lock in share mode
select .. for update

## 多版本控制MVCC

## 可以使用show table status like 'user' \G;显示表的相关信息
  在mysql5.0以后可以查询information_chema中对应的表
  字段说明P54

## 转换表的引擎:
  alter table mytable engine = InnoDB;  可以试用于任何存储引擎,但执行时间很长,原表会加锁
  详见P68
   
  创建使用新引擎的表,逐条或批量从旧表insert到新表
   
  percona Toolkit pt-onlline-schema-change工具

## monitor/mysql/monitor_mysql_status.sh
  可以通过pt-diskstats工具捕获/proc/diskstats的数据为后续分析磁盘I/O使用
  P84

## monitor/mysql/analyze_show_global_status_to_qps.sh
  P88
  
## 绘图
  gnuplot或者R绘图
  P89
  
## 基准测试工具
  集成式测试工具 ab/http_load/JMeter
  单组件测试工具 mysqlslap/sql-bench/sysbench
  percona的TPCC-MySQL测试工具
  P90
  
## pt-query-digest

## 剖析单条语句show profile
set profile = 1;
select * from user;
show profiles;
show profiles for query 1;

## 使用show status 返回一些计数器
 show status;           会话
 show global status;    全局

## Performance Schema 剖析库?

## EXPLAIN