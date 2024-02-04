#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Update the package index.
sudo apt-get update

# Install Java 11.
echo "Installing Java 11..."
sudo apt-get install -y openjdk-11-jdk
java -version

# Add the Jenkins repository and key.
echo "Adding Jenkins repository..."
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null

sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update the package index again after adding Jenkins repository.

sudo apt-get update

# Install Jenkins.
echo "Installing Jenkins..."
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
echo "Jenkins installation complete. Jenkins is now running."

# Install Docker.
echo "Installing Docker..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
echo "Docker installation complete. Docker is now running."

# Install Docker Compose.
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo "Installation of Java 11, Jenkins, Docker, and Docker Compose completed successfully."
