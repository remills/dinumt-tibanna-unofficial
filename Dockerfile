# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    samtools \
    vcftools \
    parallel

WORKDIR /usr/local/bin

#install dinumt
RUN git clone https://github.com/mills-lab/dinumt.git 


RUN wget http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0-x86_64.tar.gz && \
	tar zxvf exonerate-2.2.0-x86_64.tar.gz && \
   	cp exonerate-2.2.0-x86_64/bin/exonerate .

# Copy your application code into the container
COPY run_dinumt.sh .
RUN chmod +x run_dinumt.sh

# give me all the permissions
RUN chmod -R 777 /var/lib/ 

# Set the entrypoint command
CMD ["run_dinumt.sh"]
