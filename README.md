# Jenkins CI/CD EC2 DockerHub Automation WebApp

This repository contains a web application that utilizes Jenkins for CI/CD pipeline automation. It automatically pulls code from GitHub, builds Docker images on Docker Hub, and deploys them to Amazon Elastic Compute Cloud (EC2).

## Steps to Setup CI/CD Pipeline:

1. **Set up GitHub Repository:**
   - Create a GitHub repository for the project and commit code to it.

2. **Launch AWS EC2 instance and Install Docker:**
   - Connect to the EC2 instance using SSH.
   - Update the package index:
     ```
     sudo apt-get update
     ```
   - Install Docker:
     ```
     sudo apt-get install docker-ce docker-ce-cli containerd.io
     ```
   - Verify Docker installation:
     ```
     docker --version
     ```
   - Check for existing Docker images:
     ```
     docker images
     ```
   - Check for existing Docker containers:
     ```
     docker ps -a
     ```

3. **Install Jenkins on EC2:**
   - Add Jenkins repository into the Ubuntu server:
     ```
     wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
     sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
     ```
   - Update the package index:
     ```
     sudo apt-get update
     ```
   - Install Java:
     ```
     sudo apt-get install -y openjdk-11-jdk
     ```
   - Install Jenkins:
     ```
     sudo apt-get install -y jenkins
     ```
   - Check Jenkins status:
     ```
     sudo systemctl status jenkins
     ```
   - Access Jenkins at: http://<ec2-instance-public-ip>:8080
   - Retrieve Jenkins initial admin password:
     ```
     sudo cat /var/lib/jenkins/secrets/initialAdminPassword
     ```
   - Configure Jenkins according to your requirements.

4. **Install Necessary Plugins in Jenkins:**
   - Install plugins like Git, Docker, Pipeline, AWS EC2, etc.

5. **Add GitHub Access Token in Jenkins:**
   - Generate a GitHub Access Token with necessary permissions.
   - Add the token as a secret text credential in Jenkins.

6. **Add Docker Hub Access Token in Jenkins:**
   - Generate Access Token from Docker Hub with read, write, delete permissions.
   - Add the token as a username with password credential in Jenkins.

7. **Setup GitHub Repository and Webhook:**
   - Create a new GitHub repository.
   - Create a webhook in the repository settings pointing to Jenkins.
   - Configure Jenkins pipeline job with GitHub webhook trigger.

8. **Push Local PC Project to GitHub Repository:**
   - Create a "Jenkinsfile" in the project directory with the pipeline script.
   - Create a "Dockerfile" in the project directory.
   - Push the project to the GitHub repository.
   - Trigger the Jenkins pipeline job manually or let it be triggered by the webhook.
   - Jenkins will build the project, push the image to Docker Hub, and deploy it to AWS EC2.

Future updates to the GitHub repository will trigger the Jenkins pipeline to automatically update the Docker image on Docker Hub and deploy the project to AWS EC2 on the mentioned port in `Jenkinsfile`.