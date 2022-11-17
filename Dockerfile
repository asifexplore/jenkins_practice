FROM python:3.9
USER root
ADD . /yanxun
WORKDIR /yanxun
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# selanium testing
RUN sbase install geckodriver
RUN export PATH=$PATH:/usr/local/lib/python3.9/site-packages/seleniumbase/drivers

# Install OpenJDK-11
RUN apt-get update && \
    apt-get install -y default-jdk

# Install Firefox
RUN apt install firefox-esr -y
    
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
RUN export JAVA_HOME

EXPOSE 80

CMD ["uwsgi", "--socket", "0.0.0.0:80", "--protocol=http", "-w", "wsgi:app"]