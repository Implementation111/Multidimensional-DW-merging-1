## This file shows the test by using the datasets of TPC-C.

### 1. Example in Figure8:
### 1.1. Schema:
![Image15](https://user-images.githubusercontent.com/43824695/100205745-cae0bc80-2f05-11eb-920b-e8213f93038b.png)

create table customer as
SELECT * FROM 
(select c_custkey as custkey, c_mktsegment as segment, n_name as nation from "TPCH".customer, "TPCH".nation
where c_nationkey = n_nationkey) 
WHERE rownum <= 11250;

create table orderdate as
SELECT * FROM 
(select to_char(o_orderdate, 'dd/mm/yyyy') as orderdate, to_char(o_orderdate, 'mm/yyyy') as month, to_char(o_orderdate, 'yyyy') as year from "TPCH".orders
ORDER BY DBMS_RANDOM.RANDOM()) 
WHERE rownum <= 1804;

create table supplier as
SELECT * FROM 
(select s_suppkey as suppkey, n_name as nation from "TPCH".supplier, "TPCH".nation
where s_nationkey = n_nationkey
ORDER BY DBMS_RANDOM.RANDOM()) 
WHERE rownum <= 750;

create table lineorder as
select o_custkey as custkey, l_suppkey as suppkey, o_orderdate as orderdate, sum(l_quantity) as quantity, avg(l_discount) as discount from "TPCH".lineitem, "TPCH".orders, customer, supplier
where l_orderkey = o_orderkey
and l_suppkey = suppkey
and o_custkey = custkey
group by o_custkey, o_orderdate, l_suppkey;
