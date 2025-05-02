FROM alpine:latest AS builder
RUN apk update && apk add maven
COPY . /app
WORKDIR /app
RUN mvn clean compile test package
FROM tomcat:latest AS runtime
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]
