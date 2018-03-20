PORT=$1

# must use location under ~/ because of permissions
export AIRFLOW_HOME=~/airflow
export AIRFLOW__CORE__LOAD_EXAMPLES=False

# install and start db
pip install airflow
airflow initdb

# sed base url, smtp host, and mail from configurations
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
filepath=~/airflow/airflow.cfg
sed -i "s|base_url = http://localhost:8080|base_url = http://${HOST_IP}:${PORT}|" $filepath
# sed -i "s/smtp_host = localhost/smtp_host = $SMTPHOST/" $filepath
# sed -i "s/smtp_mail_from = airflow@airflow.com/smtp_mail_from = $AFUSER <$AFUSER_EMAIL>/" $filepath

# start webserver
airflow webserver -p $PORT && airflow scheduler