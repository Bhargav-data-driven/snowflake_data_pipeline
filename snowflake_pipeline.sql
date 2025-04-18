create database LOAD_DATA;
create schema LOAD_DATA;

CREATE OR REPLACE TABLE LOAD_DATA.LOAD_DATA.songs_data (
    song_id STRING,
    song_name STRING,
    duration_ms INT,
    url STRING,
    popularity INT,
    song_added TIMESTAMP_TZ,
    album_id STRING,
    artist_id STRING );

CREATE OR REPLACE TABLE LOAD_DATA.LOAD_DATA.artist_data (
    artist_id STRING,
    artist_name STRING,
    external_url STRING);

CREATE OR REPLACE TABLE LOAD_DATA.LOAD_DATA.album_data (
    album_id STRING,
    name STRING,
    release_date DATE,
    total_tracks INT,
    url STRING);



CREATE OR REPLACE file format LOAD_DATA.LOAD_DATA.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;


create or replace storage integration s3_load
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::682794874173:role/load_data'
  STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-etl-pipeline-bhargav123')
   COMMENT = 'Creating connection to S3'


DESC integration s3_load;


CREATE OR REPLACE stage LOAD_DATA.LOAD_DATA.songs_f
    URL = 's3://spotify-etl-pipeline-bhargav123/songs_data/'
    STORAGE_INTEGRATION = s3_load
    FILE_FORMAT = LOAD_DATA.LOAD_DATA.csv_fileformat


CREATE OR REPLACE stage LOAD_DATA.LOAD_DATA.artist_f
    URL = 's3://spotify-etl-pipeline-bhargav123/artist_data/'
    STORAGE_INTEGRATION = s3_load
    FILE_FORMAT = LOAD_DATA.LOAD_DATA.csv_fileformat


CREATE OR REPLACE stage LOAD_DATA.LOAD_DATA.album_f
    URL = 's3://spotify-etl-pipeline-bhargav123/album_data/'
    STORAGE_INTEGRATION = s3_load
    FILE_FORMAT = LOAD_DATA.LOAD_DATA.csv_fileformat



CREATE OR REPLACE pipe LOAD_DATA.LOAD_DATA.songs_pipe
auto_ingest = TRUE
AS
COPY INTO LOAD_DATA.LOAD_DATA.songs_data 
FROM @LOAD_DATA.LOAD_DATA.songs_f


CREATE OR REPLACE pipe LOAD_DATA.LOAD_DATA.artist_pipe
auto_ingest = TRUE
AS
COPY INTO LOAD_DATA.LOAD_DATA.artist_data 
FROM @LOAD_DATA.LOAD_DATA.artist_f


CREATE OR REPLACE pipe LOAD_DATA.LOAD_DATA.album_pipe
auto_ingest = TRUE
AS
COPY INTO LOAD_DATA.LOAD_DATA.album_data 
FROM @LOAD_DATA.LOAD_DATA.album_f
FILE_FORMAT = (FORMAT_NAME = 'LOAD_DATA.LOAD_DATA.csv_fileformat')
ON_ERROR = 'CONTINUE';




DESC pipe LOAD_DATA.LOAD_DATA.artist_pipe;
DESC pipe LOAD_DATA.LOAD_DATA.songs_pipe;
DESC pipe LOAD_DATA.LOAD_DATA.album_pipe;





select * from LOAD_DATA.LOAD_DATA.songs_data ;
select * from LOAD_DATA.LOAD_DATA.artist_data ;
select * from LOAD_DATA.LOAD_DATA.album_data ;





