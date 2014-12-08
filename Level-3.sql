drop table QUERY_GLOBAL_TEMP;
drop table DX;
--drop table MASTER_QUERY_GLOBAL_TEMP;

CREATE TEMP TABLE QUERY_GLOBAL_TEMP (
    ENCOUNTER_NUM int,
    PATIENT_NUM int,
    INSTANCE_NUM int,
    CONCEPT_CD varchar(50),
    START_DATE TIMESTAMP,
    PROVIDER_ID varchar(50),
    PANEL_COUNT int,
    fact_count int,
    fact_panels int
);

CREATE TEMP TABLE DX (
    ENCOUNTER_NUM int,
    PATIENT_NUM int,
    INSTANCE_NUM int,
    CONCEPT_CD varchar(50),
    START_DATE TIMESTAMP,
    PROVIDER_ID varchar(50),
    temporal_start_date TIMESTAMP,
    temporal_end_date TIMESTAMP
);

--CREATE TEMP TABLE MASTER_QUERY_GLOBAL_TEMP (
--  ENCOUNTER_NUM int,
--  PATIENT_NUM int,
--  INSTANCE_NUM int,
--  CONCEPT_CD varchar(50),
--  START_DATE TIMESTAMP,
--  PROVIDER_ID varchar(50),
--  MASTER_ID varchar(50),
--  LEVEL_NO int,
--  temporal_start_date TIMESTAMP,
--  temporal_end_date TIMESTAMP
--);

-------- Geburtsdaten ---------

insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '12784.75 day') AND (CURRENT_DATE - INTERVAL '6575.5 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '16437.25 day') AND (CURRENT_DATE - INTERVAL '12784.75 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '20089.75 day') AND (CURRENT_DATE - INTERVAL '16437.25 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '23742.25 day') AND (CURRENT_DATE - INTERVAL '20089.75 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '24107.5 day') AND (CURRENT_DATE - INTERVAL '23742.25 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '24472.75 day') AND (CURRENT_DATE - INTERVAL '24107.5 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '24838 day') AND (CURRENT_DATE - INTERVAL '24472.75 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '25203.25 day') AND (CURRENT_DATE - INTERVAL '24838 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '25568.5 day') AND (CURRENT_DATE - INTERVAL '25203.25 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;



insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  p.patient_num
from i2b2demodata.patient_dimension p
where
p.patient_num IN (select patient_num from  i2b2demodata.patient_dimension   where birth_date BETWEEN (CURRENT_DATE - INTERVAL '25933.75 day') AND (CURRENT_DATE - INTERVAL '25568.5 day'))
group by  p.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;

------------Rückenprobleme in 2013-------------

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M50\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M50\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M51\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M51\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M54\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M54\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;


-------------Schwangerschaft----------

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O00\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O00\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O01\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O01\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O02\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O02\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O03\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O03\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O04\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O04\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O05\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O05\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O06\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O06\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O07\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O07\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

-----------------
-----------------
-----------------
-----------------
-----------------
-----------------
-----------------
-----------------
-----------------



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O09\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O09\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );


update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O10\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O10\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );


update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O11\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O11\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O12\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O12\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );






update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O13\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O13\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O14\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O14\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O15\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O15\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O16\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O16\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O20\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O20\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O21\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O21\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O22\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O22\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O23\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O23\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O24\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O24\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O25\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O25\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O26\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O26\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O28\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O28\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O29\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O29\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O30\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O30\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O31\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O31\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O32\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O32\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O35\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O35\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O36\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O36\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O40\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O40\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O41\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O41\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O42\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O42\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O43\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O43\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O44\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O44\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O45\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O45\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O46\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O46\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );





update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O47\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O47\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );


update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O48\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;




update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\O48\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    );

------ Krebs -------

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C16\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C16\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C18\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C18\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C19\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C19\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C20\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C20\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C25\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C25\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C40\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C40\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C41\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C41\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C50\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C50\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C53\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C53\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C61\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C61\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C73\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C73\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C79\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C79\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C80\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\C80\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

------------------------------ Nervenkrankheit------------------------



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\G54\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\G54\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\G55\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\G55\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M05\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M05\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M06\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M06\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M07\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M07\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M45\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M45\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M46\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M46\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M47\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M47\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M48\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M48\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M49\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M49\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M80\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M80\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M90\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M90\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

---------Knochen/Gelenkbruch-----------



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S22\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S22\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S23\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S23\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\S33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T02\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T02\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T08\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T09\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T09\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;



update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T91\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnoseart\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('1','2') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =-1 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\T91\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2013-01-01T00:00:00' AND f.start_date <=  '2014-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;


 insert into DX (  patient_num   ) select * from ( select distinct  patient_num  from QUERY_GLOBAL_TEMP where panel_count = 1) q;

  select count(distinct patient_num) as patient_num_count
from DX;
