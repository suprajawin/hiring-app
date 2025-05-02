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





