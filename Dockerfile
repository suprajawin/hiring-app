FROM jetty:alpine
COPY target/*.war /var/lib/jetty/webapps/ROOT.war
# Expose port 8080 (Jetty's default port)
EXPOSE 8080
