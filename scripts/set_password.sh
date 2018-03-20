__password=$1
if [ "$__password" == "" ]; then
	__password='sha1:a6c7c7add238:36ff51304bb079ef3024799944e5720d656cfb0a'
fi

match='c.NotebookApp.open_browser = False'
insert='c.NotebookApp.password = u'"'$__password'"
filepath='/etc/jupyter/jupyter_notebook_config.py'

sed -i "s/$match/$match\n$insert/" $filepath