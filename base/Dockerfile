FROM openjdk:8-jre
LABEL Maintainer="Andrei Korzhuev <korzhuev@andrusha.me>"
LABEL Description="Vanilla Spark image, provided AS IS from the official Apache Spark builds, nothing is added or modified with minimal configuration."
LABEL Version="2.1.1"

ENV SPARK_VERSION="spark-2.1.1"
ENV SPARK_PACKAGE="$SPARK_VERSION-bin-hadoop2.7"

# Download
RUN wget -q "https://d3kbcqa49mib13.cloudfront.net/$SPARK_PACKAGE.tgz"

# Verify checksum
RUN gpg --print-md sha512 ${SPARK_PACKAGE}.tgz > ${SPARK_PACKAGE}.tgz.sha.local
RUN wget -q "https://www.apache.org/dist/spark/$SPARK_VERSION/$SPARK_PACKAGE.tgz.sha" \
    && cmp --silent $SPARK_PACKAGE.tgz.sha $SPARK_PACKAGE.tgz.sha.local

# Extract
RUN tar -xzf ${SPARK_PACKAGE}.tgz \
    && mv ${SPARK_PACKAGE} spark

# Clean up
RUN rm ${SPARK_PACKAGE}.tgz ${SPARK_PACKAGE}.tgz.sha ${SPARK_PACKAGE}.tgz.sha.local

WORKDIR spark