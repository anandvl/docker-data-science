#
# A dockerfile to run Jupyterlab with anaconda Python distribution and access it by appropriately connecting to it.
# Additional ports are also exposed so that it could be used to run other apps that may require their own ports
# (for ex: Bokeh, flask, django, tornado, Pyspark, etc.)
#
# BUILD DOCKER:	docker build -t anandvl/anaconda .
# RUN DOCKER: docker run -t -d --name=anaconda -p 2017:2017 -v $PWD:/home/anaconda anandvl/anaconda
#	To access Jupyterlabs in the host browser - http://localhost:2017/lab 
# RUN DOCKER (for spyder): docker run --name=spyder -t -d --net=host -e DISPLAY -v "$HOME/.Xauthority:/root/.Xauthority:rw" -v $PWD:/home/anaconda anandvl/anaconda /bin/bash -c spyder
#

# Start with latest debian (9.6)
FROM debian:latest
#FROM phusion/baseimage
MAINTAINER Anand Lakshmikumaran <anandvlak@gmail.com>

# Following is required for spyder
ENV QT_XKB_CONFIG_ROOT /usr/share/X11/xkb

# Update and install wget, bzip2, and multiple other packages to run spyder
RUN apt-get update && \
apt-get install -y wget bzip2 && \
apt-get install -y xterm libxcursor1 libxss1 libasound2 && \
echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list && \
apt-get update && apt-get -t stretch-backports install -y libegl1

# Install Anaconda.  Get the package, run the .sh script, and delete it
RUN wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh && \
bash Anaconda3-5.3.1-Linux-x86_64.sh -b && \
rm Anaconda3-5.3.1-Linux-x86_64.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

# Update Anaconda packages and install additional packages like cx_Oracle
RUN conda update conda && \
conda update --all -y 
# conda install cx_Oracle

# Configure access to Jupyter
RUN mkdir /home/anaconda && \
jupyter notebook --generate-config --allow-root && \
echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# Expose following ports (Jupyter: 2017, Bokeh: 2016, flask: 2015, tornado: 2014, django: 2013, PySpark: 2012)
EXPOSE 2017
EXPOSE 2016
EXPOSE 2015
EXPOSE 2014
EXPOSE 2013
EXPOSE 2012

# Run Jupyter notebook as Docker main process 
CMD ["jupyter", "lab", "--allow-root", "--notebook-dir=/home/anaconda", "--ip=0.0.0.0", "--port=2017", "--no-browser"]
