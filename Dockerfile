# Start with latest debian (9.5?)
FROM debian

# Update and install wget and bzip2
RUN apt-get update && \
apt-get install -y wget bzip2

# Install Anaconda.  Get the package, run the .sh script, and delete it
RUN wget https://repo.continuum.io/archive/Anaconda3-5.3.0-Linux-x86_64.sh && \
bash Anaconda3-5.3.0-Linux-x86_64.sh -b && \
rm Anaconda3-5.3.0-Linux-x86_64.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

# Update Anaconda packages and install additional packages - cx_Oracle
RUN conda update conda && \
conda update --all -y 

# Configure access to Jupyter
RUN mkdir /opt/notebooks && \
jupyter notebook --generate-config --allow-root && \
echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 1996
EXPOSE 2005

# Run Jupyter notebook as Docker main process 
CMD ["jupyter", "lab", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip=0.0.0.0", "--port=2005", "--no-browser"]
