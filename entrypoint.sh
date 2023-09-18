#!/bin/bash
if [ -fe /var/run/apache2/apache2.pid ]
then 
    rm -f /var/run/apache2/apache2.pid
fi 

apachectl -D FOREGROUND