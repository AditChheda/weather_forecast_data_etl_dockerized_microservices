weather-data-platform
├── airflow
│   ├── Dockerfile
│   ├── dags
│   │   ├── __pycache__
│   │   └── weather_pipeline_dag.py
│   ├── logs
│   ├── producer
│   │   └── producer.py
│   └── requirements.txt
├── consumer
│   ├── Dockerfile
│   ├── __init__.py
│   ├── consumer.py
│   └── requirements.txt
├── database
│   └── init.sql
├── docker-compose.yml
├── frontend
│   ├── Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   └── templates
│       └── index.html
├── tree.md
├── weather_venv
└── .dockerignore