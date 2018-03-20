# to create env, kernel:
conda create -n some_env python=3.6 geopandas psycopg2 ipykernel -y
source activate some_env && python -m ipykernel install --name some_env
# pip install some_not_conda_lib
source deactivate

# # to delete env, kernel:
# conda remove --name some_env --all -y
# rm -rf /usr/local/share/jupyter/kernels/some_env
