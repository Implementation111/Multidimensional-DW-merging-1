DW1 for test2:

create table customer as
SELECT * FROM 
(select c_custkey as custkey, c_mktsegment as segment from "TPCH".customer
ORDER BY DBMS_RANDOM.RANDOM()) 
WHERE rownum <= 11250;

create table supplier as
SELECT * FROM 
(select s_suppkey as suppkey, n_name as nation, r_name as region from "TPCH".supplier, "TPCH".nation, "TPCH".region
where s_nationkey = n_nationkey
and n_regionkey = r_regionkey
ORDER BY DBMS_RANDOM.RANDOM()) 
WHERE rownum <= 750;

create table part as
SELECT * FROM 
(select p_partkey as partkey, p_brand as brand, p_mfgr as manufacture from "TPCH".part
ORDER BY DBMS_RANDOM.RANDOM()) 
WHERE rownum <= 15000;

create table lineorder as
select o_custkey as custkey, l_partkey as partkey, l_suppkey as suppkey, sum(l_quantity) as quantity, avg(l_extendedprice) as extendedprice, avg(l_tax) as tax from "TPCH".lineitem, "TPCH".orders, customer, supplier, part
where l_orderkey = o_orderkey
and l_partkey = partkey
and l_suppkey = suppkey
and o_custkey = custkey
group by o_custkey, l_partkey, l_suppkey;

DW2 for test2:
 
create table customer as
SELECT * FROM 
(select c_custkey as custkey, c_mktsegment as segment, n_name as nation from "TPCH".customer, "TPCH".nation
where c_nationkey = n_nationkey
ORDER BY DBMS_RANDOM.RANDOM()) 
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
select count(*) as linenumber from lineorder;
