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

insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
 select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\M54\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num
 )
select  t.patient_num, 0 as panel_count  from t ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F30\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

    update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F31\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F32\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F38\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =1 where QUERY_GLOBAL_TEMP.panel_count =  0 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F39\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2012-01-01T00:00:00' AND f.start_date <=  '2013-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    ) ;

update QUERY_GLOBAL_TEMP set panel_count =2 where QUERY_GLOBAL_TEMP.panel_count =  1 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.provider_id IN (select provider_id from  i2b2demodata.provider_dimension   where provider_path LIKE '\\PROVIDER\\10\\%')
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F32\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F31\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F30\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F33\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F34\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F38\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

update QUERY_GLOBAL_TEMP set panel_count = -1  where QUERY_GLOBAL_TEMP.panel_count =  2 and exists ( select 1 from ( select  f.patient_num
from i2b2demodata.observation_fact f
where
f.concept_cd IN (select concept_cd from  i2b2demodata.concept_dimension   where concept_path LIKE '\\ICD\\F39\\%')
 AND  (f.MODIFIER_CD IN  (select MODIFIER_CD from i2b2demodata.MODIFIER_DIMENSION where MODIFIER_PATH LIKE '\\Diagnosesicherheit\\%'))
  AND  (  valtype_cd = 'T' AND tval_char   IN ('G') )
  AND  ( f.start_date >=  '2011-01-01T00:00:00' AND f.start_date <=  '2012-01-01T00:00:00' )
group by  f.patient_num ) t where QUERY_GLOBAL_TEMP.patient_num = t.patient_num    )  ;

 insert into DX (  patient_num   ) select * from ( select distinct  patient_num  from QUERY_GLOBAL_TEMP where panel_count = 2 ) q;

select count(distinct patient_num) as patient_num_count
from DX;
