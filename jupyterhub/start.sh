export DEBIAN_FRONTEND="noninteractive"
apt-get update
apt-get -y install python3 python3-dev git curl
curl -L https://tljh.jupyter.org/bootstrap.py \
 | sudo -E python3 - \
 --admin admin --user-requirements-txt-url https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/jupyterhub/requirements.txt