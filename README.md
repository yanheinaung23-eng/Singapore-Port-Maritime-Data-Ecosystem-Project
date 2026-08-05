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

The best model is Random Forest classifier developed to predict vessel arrival delays at Singapore Port. The model was trained on AIS (Automatic Identification System) vessel tracking data containing 609,468 records from October–December 2023.

The model achieved **95.49%** accuracy and an recall of **96.45%** on unseen test data. The model is capable of predicting whether a vessel will arrive later than its ETA with high reliability, making it suitable for real-time port operations decision support.

View the full python code here. [Full python notebook](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/fe580e423a56829b5de75b3c20c7fbc1691e1520/01_Vessel%20Delay%20Prediction%20Model/singapore_port_vessel_delay_prediction_model.ipynb)

### Decision Tree vs Random Forest

Two supervised learning algorithms were implemented.

---

### Models Classification Reports

![Alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/4cf090530961dc49f3a11e2df07227aae822ef49/01_Vessel%20Delay%20Prediction%20Model/images/model%20evaluations.png)

The **Random Forest model** outperformed the Decision Tree across every evaluation metric and was selected as the final prediction model.

---

### Feature Importance

![ALt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/4cf090530961dc49f3a11e2df07227aae822ef49/01_Vessel%20Delay%20Prediction%20Model/images/feature%20importance.png)

Both the Random Forest and Decision Tree models consistently identified a similar group of variables as the most influential predictors of vessel delays. This suggests that vessel movement characteristics, geographic location, destination, and vessel dimensions play a critical role in predicting delays at the Port of Singapore.

***Insights***

* **Speed** is the strongest predictor of vessel delays in both models.
* **Latitude and Longitude** show that a vessel's location before arrival is highly informative.
* **Destination** consistently ranks among the most important operational features.
* **Vessel size** (draught and dimensions) has a substantial impact on delay likelihood.

---

### Confusion Matrix

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/4cf090530961dc49f3a11e2df07227aae822ef49/01_Vessel%20Delay%20Prediction%20Model/images/confusion%20matrix.png)

#### 🚢 Random Forest Performance
Correctly Predicted Delays

**True Positives (TP): 82,658**

* The model successfully identified 82,658 delayed vessels, representing the majority of actual delays.

**True Negatives (TN): 33,746**

* The model accurately classified 33,746 vessels that arrived without delays.

**False Positives (FP): 2,444**

* These are vessels predicted to be delayed but actually arrived on time.
This represents only about 2.0% of the test dataset.

**False Negatives (FN): 3,046**

* These vessels experienced delays but were predicted to arrive on time. This accounts for approximately 2.5% of the test dataset.

***The Random Forest keeps these missed cases relatively low.***

---

### ROC Curve

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/4cf090530961dc49f3a11e2df07227aae822ef49/01_Vessel%20Delay%20Prediction%20Model/images/ROC%20curve.png)

Random Forest ROC curve stays much closer to the upper-left corner and achieves an AUC of **0.99**, indicating almost perfect class discrimination. While the Decision Tree also performs well (AUC = 0.92), it requires a higher false positive rate to achieve comparable true positive rates, making it less effective overall.

---

### Saving and Testing the Model

Finally test the model with new data to predict that vessel will delay or not.

```python
new_data = pd.DataFrame({
    "DayOfWeek": [2],
    "IsWeekend": [0],
    "Destination": [15],
    "DimensionA": [180],
    "DimensionB": [30],
    "DimensionC": [12],
    "DimensionD": [8],
    "MaximumStaticDraught": [9.5],
    "ShipType": [3],
    "Cog": [270],
    "Latitude": [1.264],
    "Longitude": [103.840],
    "NavigationalStatus": [0],
    "speed": [12.5],
    "SpecialManoeuvreIndicator": [0]
})

prediction = rf.predict(new_data)
probability = rf.predict_proba(new_data)

print("Prediction:", prediction[0])
print("Probability of No Delay:", probability[0][0])
print("Probability of Delay:", probability[0][1])
```

Result:

Prediction: **False**
Probability of No Delay: **0.61**
Probability of Delay: **0.39**

---

Then, save the model with joblib.

```python
import joblib

joblib.dump(rf, "singapore_port_vessel_delay_prediction_random_forest_model.pkl")
```

### Limitation of the model

The model was developed using a specific historical AIS dataset from the University of St Andrews covering October 2023. Because historical weather APIs often require separate premium subscriptions for precise coordinate-based matching back-dated to 2023, the model focuses on high-impact operational features like week_number, eta_hour, and maximum_draught.

---

# 3. Interactive Dashboard (Tableau) 📊

Interactive Tableau View - [Singapore Port AIS Traffic & Congestion Analysis Project](https://public.tableau.com/app/profile/yan.aung3461/viz/SingaporePortVesselDelayandCongestionAnalysis/Dashboard1)

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/03_Interactive%20Dashboard/Dashboard.png)

The Singapore Port AIS Traffic & Congestion Analysis Dashboard is a Tableau-based executive suite for real-time monitoring of port performance. It tracks five core weekly KPIs: Total Vessels, Delay Vessel Count (past ETA), Congestion Level (a weighted index of moored and slow vessels), Moored Vessel Count, and Slow Vessel Identification (moving at ≤5 knots).

The dashboard features an interactive geospatial map that color-codes AIS Activities by status—Anchor, Moored, Underway, or Special—to identify saturation zones and active transit fairways. It also provides granular operational views, including Cargo vs. Tanker navigational comparisons and vessel type distributions via treemaps, with integrated filters for specific weeks and days.

The "calculations" view of the dashboard provides transparency into the logic behind the primary maritime KPIs. It features a detailed breakdown of the formulas used within Tableau to ensure data accuracy and operational relevance.

---

# 4. Vessel Congestion and Delays Analysis 🔎

Full report in docx format - [Full report](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Singapore_Vessel_Congestion_Delay_Report%20(1).docx)

### Vessel Delays Analysis

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20Delay%20KPIs.png)

### insights

***System-Wide Delay***
: The 60%-70% delay ratio holds every single day throughout October regardless of traffic volume or day of week, confirming a chronic port capacity constraint rather than an episodic or weather-driven event.

***Cargo Vessels short-term Delay***
: Cargo vessels dominate the "1 day late" category (763 vessels). This suggests that while Cargo ships are frequently delayed, the delays are often short-term and potentially manageable through better scheduling.

***Cargo Vessels short-term Delay***
: Cargo vessels dominate the "1 day late" category (763 vessels). This suggests that while Cargo ships are frequently delayed, the delays are often short-term and potentially manageable through better scheduling.

	
***The "15–30 Day" Cargo Surge***
: Notable spike for Cargo vessels in the 15–30 days delay category after 1 day late. It seems like if they miss their window significantly, they appear to get "stuck" for a minimum of two weeks. This could be due to missing a specific feeder connection or losing their slot in a highly congested queue.

***Long-Tail Delays***
: Tankers are much more likely than Cargo ships to be delayed for >30 days (273 vs 131) and 4–7 days (401 vs 212).
Tankers may be facing specific bottlenecks such as berth availability for liquid bulk or longer bunkering/safety inspections that don't affect standard cargo ships.

### <ins> 4.1 Delay by vessel type — sorted by average maximum delay </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Delay%20by%20vessel%20type.png)

### insights

Delay severity varies substantially across vessel types. Tanker variants consistently experience the longest average maximum delays, with General Tankers averaging <ins>16.9 days</ins> and Tanker (Reserved) class vessels averaging <ins>40.1 days</ins>. Cargo vessel types, while more numerous, show shorter average delays but remain significantly above acceptable thresholds.

### <ins> 4.2 The Draught Paradox </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20Draught%20Paradox.png)

### insights

Analysis by vessel draught band reveals a counterintuitive pattern. Shallow-draft vessels (0–5m) suffer the longest average delays at <ins>42.1 days</ins>, with 27% waiting more than 30 days. This is likely attributable to lower port priority scheduling and a higher proportion of small, independent operators without berth pre-booking. Deep-draft vessels (20–25m) also experience elevated delays of <ins>12.8 days</ins> due to limited deep-water berth availability. Mid-range vessels (10–15m draught) are best served, averaging only 6.8 days.

### Vessel Congestion Analysis 

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20Congestion%20KPIs.png)

### insights

***Red Flag Turnaround time***
: According to UN Trade and Development (UNCTAD), an average turnaround time of nearly 6 days is a red flag—especially for time-sensitive container or cargo ships. 

***Actual Working Time (Derived): 2.48 days (5.55 - 3.07)***
: Vessels are spending 55% of their total time in port just waiting at anchor for a berth to open up. This means the actual operational work (loading, unloading, or refueling) takes less than 2.5 days, but the queue adds an extra 3 days of dead time. The primary bottleneck is not the speed of the cranes or the dockworkers; it is a severe lack of available berth space.

***Fairway Speed reflects High Traffic***
An average speed of 6.4 knots for moving vessels is standard for safe maneuvering inside congested port limits. However, navigating 901 moving vessels around a daily obstacle course of 627 parked vessels requires strict traffic management.

### <ins> 4.3 Vessel Turnaround time </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20Turnaround%20Time.png)

### insights

***Overall Port Efficiency is High***
: The port successfully processes the vast majority of its traffic with high efficiency. 63% of all vessels (3,799 out of 6,016) turn around in less than 3 days.

***The "23-32 Day" Anomaly is Driven by Tankers***
: There is a concerning spike at the tail end of the distribution: 12% of all vessels are staying in the port for almost an entire month (23-32 days). Covered deep analysis on Tanker Anomaly in the next section.

### <ins> 4.4 Vessel Turnaround time: >3 days </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20Turnaround%20Time%20more%20than%203%20days.png)

### <ins> 4.5 Plotting of tankers vessels (TAT >= 29 days)  </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Bunkers%20and%20FSUs%20Plotting.png)

### insights

Analysis of the vessel turnaround time (TAT) distribution reveals an upper-tail cluster of 299 tankers recording durations of 29 to 30 days. Geospatial mapping confirms that these are not delayed transit vessels, but rather Bunker Tankers and Floating Storage Units (FSUs). These assets are permanently stationed within designated offshore anchorage zones to facilitate oil storage and refueling operations, distinct from standard berth-cycling traffic.

### <ins> 4.6 Density Headmap of all the AIS activities of Singapore Port </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Geo%20heatmap%20segmentated.png)

### <ins> 4.7 Congestion Zones </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Congestion%20Zones.png)

### <ins> 4.8 Top 10 Congestion Hotspots </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Geo%20heatmap%20top%2010%20congestion%20hotspot.png)

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Top%2010%20congested%20zones%20table.png)

### insights

The data shows that congestion is primarily driven by anchorage demand rather than vessel movement, indicating a queueing system outside port boundaries. This suggests that berth allocation and port turnaround efficiency are key bottlenecks.

### <ins> 4.9 Distress Vessels </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Distress%20Vessels.png)

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Distress%20Vessels%20Count.png)

### insights

Constrained vessels dominate among the distress vessels with 77.95% of all distress vessels.

***Strategic Choke Points***
: The grouping of blue dots is most intense between longitudes 103°48'E and 104°05'E (near St. John’s Island and the Phillips Channel). This is the narrowest part of the Singapore Strait, where navigable depth is most critical for these massive ships.

### <ins> 4.10 NUC Vessels and Aground Vessel </ins>

![alt image](https://github.com/yanheinaung23-eng/Singapore-Port-Maritime-Data-Ecosystem-Project/blob/041d1f000120500dee957a4bdcf813d32868684d/04_Vessel%20Congestion%20%26%20Delay%20Analysis/Images/Vessel%20aground%20and%20NUC%20vessels.png)

### insights

There is one Aground Vessel that run aground South of Jurong Island from 12 Oct 2023 to 14 Oct 2023

***Location Risk***: This area is near the Western Islands, a zone with complex tidal currents and varying depths. For a vessel with nearly 9 meters of draught, even slight deviations from the charted fairway can lead to groundings.

***Impact***: Groundings in the Singapore Strait are treated with extreme urgency by the Maritime and Port Authority (MPA) due to the risk of oil spills and the potential to block critical shipping lanes like the Phillip Channel.
<br>
<br>

There 36 NUC vessels all across zones like VLCC anchorage zone, Western Outer Anchorage, Fairway transit and North Anchorage Belt.

***Volume Insights***: The high number of NUC signals often reflects Singapore's role as a premiere ship repair and bunkering hub. Many ships arrive "under command" but may switch their AIS status to NUC while undergoing specialized offshore maintenance that prevents them from moving immediately.


### <ins> 4.11 Recomendations </ins>

***Implement Dynamic "Just-In-Time" Arrivals for Cargo Vessels***
: Cargo vessels currently dominate the short-term delay category, with 763 ships arriving exactly one day late. Furthermore, if these vessels miss this initial window, they frequently fall into a severe 15–30 days delay surge. Establishing stricter predictive scheduling and communication could prevent manageable short-term delays from spiraling into multi-week operational losses.

***Restructure Berthing Priority for Shallow-Draught Vessels***
: The data reveals a counterintuitive draught paradox where shallow-draft vessels (0–5m) suffer the most extreme average delays at 42.1 days. Developing a dedicated secondary queue or allocating specific low-priority berths for these smaller operators could rapidly clear this massive 30+ day backlog.

***Deploy Draft-Aware Traffic Control at the Phillips Channel Choke Point***
: Constrained vessels account for a massive 77.95% of all distress signals. Because these distress signals are intensely clustered between longitudes 103°48'E and 104°05'E, enhanced draft-clearance protocols and targeted pilotage assistance should be mandated specifically for this narrow transit corridor to prevent grounding events.

***Designate Dedicated Off-Fairway Repair Zones***
: The dataset identified 36 NUC (Not Under Command) vessels scattered across critical areas, including the VLCC anchorage and the North Anchorage Belt. Since the Northern Anchorage Belt is already classified as saturated, forcing vessels undergoing maintenance into designated off-fairway repair zones would free up vital waiting areas for active vessels.

### <ins> 4.12 External reference sources  </ins>

-	[Maritime & Port Authority of Singapore](https://www.mpa.gov.sg/port-marine-ops/arrivals-and-departures/vessels-arriving-in-singapore)
-	[Australian Maritime Safety Authority](https://www.amsa.gov.au/)
-	[ALG | Port congestion explained](https://www.alg-global.com/blog/maritime/port-congestion-why-delays-happen-and-how-mitigate-them#:~:text=Root%20causes%20of%20port%20congestion,Increased%20vessel%20sizes)
-	[UN trade & development | Vessel turnaround time](https://sft-framework.unctad.org/key-performance-indicator/maritime-vessel-turnaround-time#:~:text=Ship%20turnaround%20time%20is%20the%20total%20time,equipment%20and%20other%20resources%20used%20at%20berth)
  
____________________________________________________
<br>
<br>

# 5. Project Disclaimer ⚠️

This Data Ecosystem project is based on October 2023 AIS data and represents conditions during that specific period. Port operations, capacity, and performance metrics may have changed since data collection and should not be considered precise forecasts. Readers should consult Singapore Port management and official reports for current operational data.

______________________________________________________
<br>
<br>

# 6. About the Author

Hi everyone!👋👋 My name is Yan, and I am a former seafarer with professional experience on merchant ships and superyachts. I am currently pursuing a career in data analytics, fueled by a deep passion for leveraging data to solve real-world problems.

By combining my maritime domain knowledge with technical analytics, I aim to support maritimers and port authorities through data-driven systems. As a major step toward this goal, I have built a comprehensive data ecosystem for the Singapore Port, featuring an automated ETL pipeline, a vessel delay prediction model, and congestion and delay interactive dashboard and reports. Hope to enjoy my project and feel free to connect with me!🚢🌊
______________________________________________________
<br>
<br>

# 7. Thank you for being here until the end 🙏🙌

Thank you for taking the time to explore this project. This project has been an incredible learning journey for me - deep dive into the intersection of data science and maritime logistics.

I am always open to professional collaborations, feedback, or discussions regarding data science and maritime logistics. If you have advice on the roadmap or would like to discuss potential projects, please feel free to reach out and connect!

My Linkedin 👉 [www.linkedin.com/in/yanheinaung](www.linkedin.com/in/yanheinaung)

My Email    👉 [yanhein.aung23@gmail.com](mailto:yanhein.aung23@gmail.com)

A special thanks to the researchers at the University of St Andrews for providing the foundational dataset that made this analysis possible. This project represents a significant step in my data career, and I am excited to continue refining these tools to drive smarter, more efficient port operations.

Hope you have a great day! Cheer!

_____________________________________________________
### THE END
<br>
<br>

🛡️ License This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.





