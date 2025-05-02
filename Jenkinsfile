FROM alpine:latest AS builder
RUN apk update && apk add maven
COPY . /app
WORKDIR /app
RUN mvn clean compile test package
FROM tomcat:latest AS runtime
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]





New
4:11
pipeline {
    agent any
    environment {
        // Define your environment variables here
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Jenkins credentials ID for DockerHub
        DOCKER_IMAGE = 'nikks171/hiringapp-tomcat' // Replace with your DockerHub image name
        VERSION = "${env.BUILD_ID}" // Using build number as version
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/suprajawin/hiring-app.git' // Replace with your repo URL
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.VERSION}")
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        docker.image("${env.DOCKER_IMAGE}:${env.VERSION}").push()
                        // Optionally push as latest
                        docker.image("${env.DOCKER_IMAGE}:${env.VERSION}").push('latest')
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}





