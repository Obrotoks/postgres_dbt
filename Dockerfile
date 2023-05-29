FROM postgres${PS_VERSION}

# enviroment variables

# make directory to Docker
RUN mkdir -p /home/src
RUN mkdir -p /home/raw

# Copy source data 
COPY ./src /home/src
COPY ./script/* /docker-entrypoint-initdb.d

RUN chmod a+r /docker-entrypoint-initdb.d/*


EXPOSE 6666

