FROM ubuntu:16.04
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install apache2 -y
RUN apt-get install subversion libapache2-mod-svn subversion-tools libsvn-dev -y
RUN a2enmod dav
RUN a2enmod dav_svn
COPY ./dav_svn.conf /etc/apache2/mods-enabled/dav_svn.conf
RUN mkdir /opt/svn
RUN mkdir /opt/svn/svndata
RUN svnadmin create /opt/svn/svndata
RUN chown -R www-data:www-data /opt/svn/svndata
RUN chmod -R 775 /opt/svn/svndata
RUN htpasswd -bcm /etc/apache2/dav_svn.passwd svnadmin svn@123
COPY ./cat-violin.jpeg ./cat-violin.jpeg 
RUN svn import ./cat-violin.jpeg file:///opt/svn/svndata/cat-violin.jpeg -m "Initial import"
COPY ./entrypoint.sh /var/run/entrypoint.sh


RUN ["chmod", "+x", "/var/run/entrypoint.sh"]
RUN ["chmod", "-R", "777", "/var/run/entrypoint.sh"]

ENTRYPOINT ["bash", "/var/run/entrypoint.sh"]
