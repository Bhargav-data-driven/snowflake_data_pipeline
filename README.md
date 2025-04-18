# Spotify ETL Pipeline with AWS & Snowflake
## Project Overview
This project is a complete ETL (Extract, Transform, Load) pipeline that leverages Spotify's Web API, AWS services, and Snowflake to automate the flow of music data from source to data warehouse.


## Architecture
<img src="https://github.com/Bhargav-data-driven/-Spotfiy-Data-Pipeline-End-To-End-Python-Data-Engineering-Project/blob/main/Spotify_Architecture.png" alt="Data Architecture" width="600" height="500">


## Key Features
**1. Data Extraction (E)**

- A Lambda function connects to the Spotify API and extracts raw music data including songs, albums, and artists.
- The raw JSON data is then stored in an Amazon S3 bucket under a designated folder (raw_data/to_processed/).

**2.Data Transformation (T)**

- Another Lambda function is triggered to:
- Read the raw JSON data from S3.
- Parse and transform the data into structured tabular format using Pandas.
- Store the cleaned and transformed data (songs, albums, artists) back into S3 under the transformed_data/ directory.

**3.Data Loading (L)**

- Inside Snowflake, external tables are created corresponding to the transformed data in S3.
- Integration between Snowflake and S3 is established using an external stage.
- Data is loaded into Snowflake using the COPY INTO command.
- A Snowflake pipeline is created to automate continuous loading from S3 into Snowflake as new data arrives.

## Tech Stack

- **Spotify Web API** – Data Source
- **AWS Lambda** – Serverless Functions for Extract & Transform
- **Amazon S3** – Data Lake (raw + transformed)
- **Pandas** – Data Transformation
- **Snowflake** – Cloud Data Warehouse
- **Snowflake Pipe & Stage** – Automation & Data Loading

## Conclusion

This project demonstrates a fully automated ETL pipeline using modern cloud technologies. By integrating the Spotify API, AWS services, and Snowflake, we've built a scalable solution for collecting, transforming, and loading music data into a data warehouse. This pipeline can be extended to support real-time analytics, machine learning use cases, or visualization dashboards.

It highlights the power of serverless architecture, cloud storage, and data warehousing—making it easy to handle complex workflows with minimal infrastructure management.


