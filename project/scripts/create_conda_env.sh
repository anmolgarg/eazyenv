# to create env, kernel:
conda create -n some_env python=3.6 geopandas psycopg2 ipykernel -y
source activate some_env && python -m ipykernel install --name some_env
# conda install some_conda_lib
# pip install some_pypi_lib
source deactivate

# # to delete env, kernel:
# conda remove --name some_env --all -y
# rm -rf /usr/local/share/jupyter/kernels/some_env
