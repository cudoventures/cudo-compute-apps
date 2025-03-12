export DEBIAN_FRONTEND="noninteractive"

wait_for_lock() {
    while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
        echo "Waiting for other package management process to finish..."
        sleep 5
    done
}

wait_for_lock
apt-get update

wait_for_lock
apt-get -y install python3 python3-dev git curl

curl -L https://tljh.jupyter.org/bootstrap.py \
 | sudo -E python3 - \
 --admin admin --user-requirements-txt-url https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/jupyterhub/requirements.txt