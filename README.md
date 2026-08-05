# Project-Singapore-Port-Full-Maritime-Data-Ecosystem ⚓
This project is a full-stack maritime data solution system including ETL pipeline (Data Engineering), analyzing vessel congestion and delays (Data Analysis), prediction of vessel delays ML model (Data Science) and interactive business intelligence (BI Development), all created by one person using Singapore Port AIS dataset.

## Contents

1. ETL Pipeline ⚙️
2. Delay Prediction ML Model 🤖
3. Interactive Dashboard (Tableau) 📊
4. Vessel Congestion and Delays Analysis 🔎

## Project Overview

![Ait image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/project%20structure.png)

## About the Dataset

![ alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Dataset%20Source%20Banner.png)

Data Period - 1 October 2023 – 31 October 2023

Dataset used - [AIS Data from 11 ports around the globe – Singapore port](https://research-portal.st-andrews.ac.uk/en/datasets/ais-data-from-11-ports-around-the-globe/)


Using Automatic Identification System (AIS) data from October 2023, I tracked 600k+ vessel observations across 5,877 unique ships over 30 days of dataset from **University of St Andrews, Scotland**, created by Andreas Hadjipieris (Creator), Neofytos Dimitriou (Creator) Oggie Arandelovic (Creator) School of Computer Science.

Scope: 
 609,468 AIS records  —  5,877 unique vessels  —  14 vessels types

---

# 1. ETL Pipeline ⚙️

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/ETL%20pipeline.png)

### 1.1 Data Ingestion (Bronze Layer) 🥉
The workflow begins with ingesting raw data from the source into the data warehouse. Process:

- Created table with same number of columns as an original data source. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/01_Bronze%20Layer/01_Creating%20table%20in%20Bronze%20layer.sql)
- Load data into SQL Server using TRUNCATE and BULK INSERT operations
- Store data in the Bronze layer without transformation and created stored procedure using CREATE OR ALTER, BEGIN TRY to handle errors. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/01_Bronze%20Layer/02_Stored%20Procedure%20for%20loading%20raw%20data%20into%20Bronze%20layer.sql)

### 1.2 Data Processing & Standardization (Silver Layer) 🥈
After ingestion, data is transformed in the Silver layer to improve quality and consistency. Process:

- Created table with same number of columns as an original data source. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/02_Silver%20Layer/01_Creating%20table%20in%20Silver%20layer.sql)
- Checking data quality and outliers before loading into Silver Layer. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/02_Silver%20Layer/02_Checking%20data%20quality%20and%20outliers%20before%20loading%20into%20Silver%20layer.sql)
- Transforming inconsistent data and correct them.
- Load cleaned data in the Silver layer using Stored procedure, TRUNCATE and INSERT INTO. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/02_Silver%20Layer/03_Stored%20Procedure%20for%20loading%20cleaned%20data%20into%20Silver%20layer.sql)

### 1.3 Data Integration (Gold Layer) 🥇
This is the final stage, transform data and create view as a gold layer for business ready usage. Process:

- Logical Transformation: Specialized SQL Views translate technical AIS codes into human-readable vessel types and navigational statuses.
- Feature Engineering: Added calculated columns such as week_number and direction (N, NE, E, etc.) for immediate downstream usage. [sql script](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/03_Gold%20Layer/Creating%20View%20in%20Gold%20layer.sql)

### 1.4 Documentation (log for cleaning data in ETL process) 📄
Implemented a comprehensive Data Cleaning Log to ensure pipeline transparency, documenting the audit and correction of maritime-specific anomalies such as ETA inconsistencies and invalid vessel heading values. [Cleaning log](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/c3fb1504c1b9c4d85a6792ca1ff8cf611ea7174d/02_ETL%20Pipeline/Log%20for%20cleaning%20data%20in%20ETL.docx)

---

# 2. Delay Prediction ML Model 🤖

The model is Random Forest classifier developed to predict vessel arrival delays at Singapore Port. The model was trained on AIS (Automatic Identification System) vessel tracking data containing 609,468 records from October–December 2023.










