export DEBIAN_FRONTEND="noninteractive"
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
source ~/miniconda3/bin/activate
conda init --all

export DEBIAN_FRONTEND="noninteractive"
#conda create -n open_manus python=3.12
#conda activate open_manus
git clone https://github.com/mannaandpoem/OpenManus.git
cd OpenManus
sed -i 's/"headless": False/"headless": True/g' app/tool/browser_use_tool.py
wget https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/open-manus/openmanus/config.toml -O config/config.toml
pip install -r requirements.txt
playwright install-deps
playwright install


