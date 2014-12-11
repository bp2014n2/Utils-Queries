#!/bin/bash

progress() {
  pc=0;
  while true
    do
      echo -n -e "[$pc sec]\033[0K\r"
      sleep 1
      ((pc++))
    done
}


echo "Downloading dependencies... "
sudo apt-get -y install libpq-dev
sudo apt-get -y install postgresql-server-dev-9.3
sudo apt-get -y install git
sudo apt-get -y install protobuf-c-compiler
sudo apt-get -y install libprotobuf-c0-dev
git clone https://github.com/citusdata/cstore_fdw.git

echo "Installing cstore... "
cd cstore_fdw
make
sudo make install

echo "Setting up extension... "
sudo sed "s/#shared_preload_libraries = ''/shared_preload_libraries = 'cstore_fdw'/g" /etc/postgresql/9.3/main/postgresql.conf -i
sudo /etc/init.d/postgresql restart

sudo -u postgres psql -d i2b2 -c "CREATE EXTENSION cstore_fdw;"
sudo -u postgres psql -d i2b2 -c "CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;"

cd ../
sudo chmod -R 777 Datensatz

echo "Converting observation_fact... "
sudo -u postgres psql -d i2b2 -c "COPY (SELECT encounter_num, patient_num, concept_cd, provider_id, start_date, modifier_cd, instance_num, valtype_cd, tval_char, nval_num, valueflag_cd, quantity_num, units_cd, end_date, location_cd, observation_blob, confidence_num, update_date, download_date, import_date, sourcesystem_cd, upload_id FROM i2b2demodata.observation_fact ORDER BY start_date ASC) TO '/home/ubuntu/Datensatz/datamart/observation_fact_ordered.csv' DELIMITER '|' CSV;
DROP TABLE i2b2demodata.observation_fact;
CREATE FOREIGN TABLE i2b2demodata.observation_fact
(
    encounter_num integer NOT NULL,
    patient_num integer NOT NULL,
    concept_cd character varying(50) NOT NULL,
    provider_id character varying(50) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    modifier_cd character varying(100) NOT NULL DEFAULT '@'::character varying,
    instance_num integer NOT NULL DEFAULT 1,
    valtype_cd character varying(50),
    tval_char character varying(255),
    nval_num numeric(18,5),
    valueflag_cd character varying(50),
    quantity_num numeric(18,5),
    units_cd character varying(50),
    end_date timestamp without time zone,
    location_cd character varying(50),
    observation_blob text,
    confidence_num numeric(18,5),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
)
SERVER cstore_server
OPTIONS(compression 'pglz', block_row_count '40000', stripe_row_count '600000');
ALTER FOREIGN TABLE i2b2demodata.observation_fact OWNER TO i2b2demodata;
COPY i2b2demodata.observation_fact FROM '/home/ubuntu/Datensatz/datamart/observation_fact_ordered.csv' DELIMITER '|' CSV;"

echo "Converting patient_dimension... "
sudo -u postgres psql -d i2b2 -c "COPY (SELECT * FROM i2b2demodata.patient_dimension ORDER BY patient_num ASC) TO '/home/ubuntu/Datensatz/datamart/patient_dimension_ordered.csv' DELIMITER '|' CSV;
DROP TABLE i2b2demodata.patient_dimension;
CREATE FOREIGN TABLE i2b2demodata.patient_dimension
(
    patient_num integer NOT NULL,
  	vital_status_cd character varying(50),
	birth_date timestamp without time zone,
	death_date timestamp without time zone,
	sex_cd character varying(50),
	age_in_years_num integer,
	language_cd character varying(50),
	race_cd character varying(50),
	marital_status_cd character varying(50),
	religion_cd character varying(50),
	zip_cd character varying(10),
	statecityzip_path character varying(700),
	income_cd character varying(50),
	patient_blob text,
	update_date timestamp without time zone,
	download_date timestamp without time zone,
	import_date timestamp without time zone,
	sourcesystem_cd character varying(50),
	upload_id integer
)
SERVER cstore_server
OPTIONS(compression 'pglz', block_row_count '40000', stripe_row_count '600000');
ALTER FOREIGN TABLE i2b2demodata.patient_dimension OWNER TO i2b2demodata;
COPY i2b2demodata.patient_dimension FROM '/home/ubuntu/Datensatz/datamart/patient_dimension_ordered.csv' DELIMITER '|' CSV;"
