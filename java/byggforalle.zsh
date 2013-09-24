# Convenient additions for development on Bygg for alle
export CATALINA_HOME="/opt/apache-tomcat-5.5.36"
alias sas='cd /home/okj/Knowit/bfa/ && $CATALINA_HOME/bin/shutdown.sh && ant deploy && $CATALINA_HOME/bin/startup.sh'

