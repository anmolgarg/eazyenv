# eazyenv
##### _Cruisin' down the street in my x86\_64_

Eazyenv allows you to _easily_ create a fresh linux and python data science _environment_ on any docker enabled machine. The following commands create a linux container with Anaconda 3, Spark, a Jupyter lab/notebook server, a Python 3.6 kernel with the full pydata stack and a Python 2.7 kernel with numpy.


## How to run
1. Clone eazyenv to use as a template.
2. For each project, copy eazyenv naming it according to your project. Cd into the copy and delete the eazyenv git references.
3. Create a hashed password; see security section below
4. Run the bash start-lab script with desired port and password to start a jupyter server.

```bash
scp -r eazyenv [project_name]
cd [project_name]
rm -rf .git
bash start-lab.sh [port] [hashed password]
```

Access jupyter server at http://[host_address]:[port]
<br><br>

## Security
All jupyter servers must be password protected with a hashed password e.g. `sha1:739c7b2c8795:705ea47498297a1aa6b3befd9ce35581c54b33db`.

To create a password, use the [jupyter notebook python API](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#preparing-a-hashed-password). If no password provided when running `start-lab.sh`, you will be locked out.
<br><br>

## Do you want more
- Start a nginx [h5ai](https://larsjung.de/h5ai/) web based file server by running `bash start-file-server.sh [port]`
- Start an [Apache Airflow](https://airflow.incubator.apache.org/) server to programmatically author, schedule and monitor workflows by running `bash scripts/start-airflow.sh [lab container] [port]`
<br><br>

## notes
- Can modify scripts/install_requirements for system or conda libraries and scripts/requirements for pypi libraries for given project before running bash start-lab
- Can add-to or build new python environments at will. see project/scripts/create_conda_env
- Can enter container, named [project_name]-LAB-[port], by running `docker exec -it container_name bash` and exit by running `exit`
