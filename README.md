# docker-python-anaconda
This is a repository of the Dockerfile used to create a dockerimage with the base
anaconda install on a debian base.  It starts a process to run a jupyter lab on port 
2017 with notebooks being save in /home/anaconda

A typical command to run this image will be

docker run -t -d --name=anaconda -p 2017:2017 -v $PWD:/home/anaconda anandvl/anaconda

Then, jupyterlab could be accessed on the host browser by going to 'http://localhost:2017/lab'

It uses the latest anaconda version (as of the commit date).  This includes bokeh, 
flask, tornado, scikit-learn, and tk.  Though it includes 'spyder', it is currently not
operational as it may require installation of additional packages and configurations. 

Additional ports (2016, 2015, 2014, 2013, 2012) are exposed in the image so that it 
could be used to run additional servers (such as bokeh, flask, tornado, etc.)

To do: 
- Configure to run Spyder
- include additional 'conda' packages if and when necessary 
    (django, pyspark, py4j, tensorflow, keras, pytorch)
