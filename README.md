# Weather Forecast Data ETL & Visualization with Dockerized Microservice

---

## Project Description

This project demonstrates a **full end-to-end weather data pipeline** built using modern data engineering tools and containerized infrastructure.

Weather forecast data for **New York** is retrieved from the **Open-Meteo API**, including the following attributes:

* Timestamp
* Temperature (°C)
* Precipitation Probability

The pipeline collects **hourly weather data for a 14-day window**, consisting of:

* **7 previous days**
* **7 upcoming days**

Since the data is collected **every hour**, the pipeline retrieves a total of **336 weather records**:

```
14 days × 24 hours = 336 records
```

The workflow is orchestrated using **Apache Airflow**, where a **Kafka Producer** extracts weather data from the API and publishes it to a Kafka topic. A **Kafka Consumer** then processes the streaming messages and inserts the records into a **PostgreSQL database**.

The stored data is served through a **FastAPI web application**, which queries the database and displays the results through a dashboard for visualization.

The entire platform is **fully containerized using Docker**, running across **8 coordinated containers**, including services for Airflow, Kafka, PostgreSQL, the consumer pipeline, and the frontend application. This setup ensures the system is **reproducible, scalable, and easy to deploy**.

From ingestion to visualization, the complete workflow initially takes approximately **4 minutes to execute**; subsequent runs complete in under **4 seconds**. The first run is slower because it needs to connect to Kafka, create the topic, and establish a connection to the PostgreSQL database.

---

## System Design Explanation

### 1. Data Ingestion Layer

Weather data is retrieved from the **Open-Meteo API**.

The Airflow DAG triggers a Python task which:

* Fetches weather forecast data
* Converts the response into structured JSON
* Sends the data to Kafka

Benefits:

* Decouples ingestion from processing
* Allows scheduled or manual triggers
* Enables workflow orchestration

### 2. Streaming Layer

The streaming system uses **Apache Kafka**.

Kafka acts as a **distributed event log** where weather data is published as messages.

Producer responsibilities:

* Serialize weather data
* Publish events to Kafka topic

Consumer responsibilities:

* Subscribe to Kafka topic
* Process incoming messages
* Transform records

Benefits:

* Fault tolerant
* Scalable streaming architecture
* Decoupled producers and consumers

### 3. Storage Layer

Weather records are persisted into **PostgreSQL**.

Schema:

| Column        | Description               |
| ------------- | ------------------------- |
| id            | Primary key               |
| timestamp     | Weather observation time  |
| temperature   | Temperature value         |
| precipitation | Precipitation probability |
| created_at    | Record insertion time     |

Benefits:

* Structured storage
* SQL analytics capability
* Reliable persistent storage

### 4. API Layer

A **FastAPI service** acts as the backend API.

Responsibilities:

* Connect to PostgreSQL
* Fetch weather records
* Render dashboard

Benefits:

* High performance async framework
* Easy integration with frontend templates

### 5. Visualization Layer

The frontend dashboard:

* Uses **Jinja2 templates**
* Displays weather records in a table
* Automatically updates when new data arrives

Benefits:

* Simple monitoring UI
* Direct database visibility

---

## Infrastructure

All services run in **Docker containers** using Docker Compose.

Services included:

| Service    | Description                  |
| ---------- | ---------------------------- |
| Zookeeper  | Kafka coordination           |
| Kafka      | Event streaming              |
| PostgreSQL | Data storage                 |
| Airflow    | Workflow orchestration       |
| Consumer   | Kafka → PostgreSQL ingestion |
| FastAPI    | Dashboard and backend        |

---

## Running the Platform

### 1. Start the services

```
docker-compose up --build
```

### 2. Open Airflow UI

```
http://localhost:8080
```

Login:

```
username: admin
password: admin
```

Trigger DAG:

```
weather_pipeline_dag
```

### 3. Open Dashboard

```
http://localhost:8000
```

The dashboard displays stored weather data.

---

## Engineering Concepts Demonstrated

This project showcases several **data engineering concepts**:

* Workflow orchestration
* Event streaming architecture
* Microservices data pipeline
* Containerized infrastructure
* Data ingestion pipelines
* Real-time processing
* Backend API development

---

## Technologies Used

| Technology     | Purpose                     |
| -------------- | --------------------------- |
| Apache Airflow | Workflow orchestration      |
| Apache Kafka   | Streaming data platform     |
| PostgreSQL     | Data storage                |
| FastAPI        | Backend API                 |
| Jinja2         | HTML templating             |
| Docker         | Containerization            |
| Docker Compose | Multi-service orchestration |

---

## Future Improvements

Potential production improvements:

* Kafka partitions and replication
* Data warehouse integration (Snowflake / BigQuery)
* Real-time analytics dashboard

---

## Author

**Adit Chheda**

---

## Why This Project Matters

This project simulates **a real industry data platform** used by companies handling streaming data.

It demonstrates:

* event-driven architectures
* distributed data pipelines
* scalable microservices systems
