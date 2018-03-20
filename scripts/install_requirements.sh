# update conda things, conda install new things
conda update --all -y
conda install plotly psycopg2 -y

# update pip things, pip install requirements.txt
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U
pip install -r scripts/requirements.txt

# create a py2.7 env with numpy
conda create -n python2 python=2.7 numpy ipykernel -y
source activate python2 && python -m ipykernel install --name python2
source deactivate
