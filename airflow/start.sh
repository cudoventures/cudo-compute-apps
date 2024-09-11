mkdir -p ./dags ./logs ./plugins ./config
#echo -e "AIRFLOW_UID=$(id -u)" > .env
grep -q '^AIRFLOW_UID=' .env && sed -i "s/^AIRFLOW_UID=.*/AIRFLOW_UID=$(id -u)/" .env || echo "AIRFLOW_UID=$(id -u)" >> .env
docker compose up airflow-init
docker compose up