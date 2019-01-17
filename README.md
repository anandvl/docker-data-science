# docker-python-anaconda
Dockerfile for base anaconda (with Jupyterlab)

This is a repository of the Dockerfile used to create a dockerimage with the base
anaconda install on a debian base.  It starts a process to run jupyterlab on port 
2017 with the root folder in /home/anaconda

A typical command to run this image will be

> docker run -t -d --name=anaconda -p 2017:2017 -v $PWD:/home/anaconda anandvl/anaconda

Then, jupyterlab could be accessed on the host browser by going to 'http://localhost:2017/lab'
(use 'root' as password)

It uses the latest anaconda version (as of the commit date) - currently 3.5.3.1. 
This includes bokeh, flask, tornado, scikit-learn, tk, and spyder.  An X-server
needs to running on the host machine for the spyder GUI to show up.  A typical
command on Debian stretch will be

> docker run --name=spyder -t -d --net=host -e DISPLAY -v "$HOME/.Xauthority:/root/.Xauthority:rw" -v $PWD:/home/anaconda anandvl/anaconda /bin/bash -c spyder

Additional ports (2016, 2015, 2014, 2013, 2012) are exposed in the image so that it 
could be used to run additional servers simultaneously (such as bokeh, flask, tornado, etc.)

This dockerfile could be modified when necessary to include additional 'conda' 
packages such as django, pyspark, py4j, tensorflow, keras, and pytorch.  For a
complete list of available packages in anaconda go to 
https://docs.anaconda.com/anaconda/packages/py3.7_linux-64/.
Those checked in the 'In Installer' column are already available while those
that are not could be installed using conda (conda install ...)
