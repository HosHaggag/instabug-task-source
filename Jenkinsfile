pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Checkout your source code from version control system (e.g., Git)
                git 'https://github.com/0x70ssAM/instabug-internship-task'

                // Build the Docker image using the Dockerfile
                script {
                    def imageName = "hossamibraheem/instabug-internship-task"
                    def dockerTag = "latest"
                    docker.build("${imageName}:${dockerTag}", "-f Dockerfile .")
                }
            }
        }

        stage('Publish') {
            steps {
                // Log in to the Docker registry (e.g., Docker Hub)
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD}"
                }
                
                // Push the Docker image to the registry
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        // Push the Docker image to Docker Hub
                        def dockerImage = docker.image("${imageName}:${dockerTag}")
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Test') {
            steps {
                error("Tests failed")
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
        always {
            // Clean up the Docker images and containers
            cleanWs()

            // Log out from the Docker registry
            sh "docker logout"
        }
    }
}
