DROP TABLE IF EXISTS QUERY_GLOBAL_TEMP;
DROP TABLE IF EXISTS DX;
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

insert into QUERY_GLOBAL_TEMP (patient_num, panel_count)
with t as (
    select f.patient_num
    from i2b2demodata.observation_fact f
    where f.provider_id IN (
        select provider_id
        from i2b2demodata.provider_dimension
        where provider_path LIKE '\\PROVIDER\\01\\%'
    )
    group by  f.patient_num
)
select t.patient_num, 0 as panel_count
from t;
insert into DX (patient_num)
select *
from (
    select distinct patient_num
    from QUERY_GLOBAL_TEMP
    where panel_count = 0
) q;

select count(distinct patient_num) as patient_num_count
from DX;
