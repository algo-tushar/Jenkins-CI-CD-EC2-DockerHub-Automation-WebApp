pipeline {
    agent any
    environment {
        PORT = "85"
        DOCKERHUB_CREDENTIAL_ID = "dockerhub"
        IMAGE_NAME = "wazihtushar/devops-project" // DockerHub Username/Repository
        CONTAINER_NAME = "devops-project"
        GIT_REPO = "https://github.com/algo-tushar/Jenkins-CI-CD-EC2-DockerHub-Automation-WebApp.git" // Git Repository URL
        GIT_BRANCH = "main" // Git Branch
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com", "${DOCKERHUB_CREDENTIAL_ID}") {
                        def app = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}", ".")
                        app.push()
                    }
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker pull ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
    }
}