FROM ubuntu:xenial
MAINTAINER Megan Neveau <mnn6412@truman.edu>

LABEL \
    description="Image for Concordance tool"

RUN apt -get update -y && apt -get install -y \
    wget \
    git \
    unzip \
    python \
    python-dev \
    python-pip \
    
##################
#Concordance Tool#
##################
WORKDIR /opt/
RUN git clone https://github.com/mnneveau/concordance
    
####################
#Fisher Python Test#
####################
RUN pip install FisherExact

###############
#bam-readcount#
###############
RUN apt-get update && \
    apt-get install -y \
    cmake \
    patch \
    git

ENV SAMTOOLS_ROOT=/opt/samtools
RUN mkdir /opt/bam-readcount

WORKDIR /opt/bam-readcount
RUN git clone https://github.com/genome/bam-readcount.git /tmp/bam-readcount-0.7.4 && \
    git -C /tmp/bam-readcount-0.7.4 checkout v0.7.4 && \
    cmake /tmp/bam-readcount-0.7.4 && \	    
    make && \
    rm -rf /tmp/bam-readcount-0.7.4 && \
    ln -s /opt/bam-readcount/bin/bam-readcount /usr/bin/bam-readcount

COPY bam_readcount_helper.py /usr/bin/bam_readcount_helper.py
RUN pip install cyvcf2

