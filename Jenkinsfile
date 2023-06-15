pipeline {
    agent any

      environment {
        //once you sign up for Docker hub, use that user_id here
        registry = "haggagdev/instabug-task"
        //- update your credentials ID after creating credentials for connecting to Docker Hub
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_id')
        dockerImage = ''
    }

    stages {
        stage('Checkout Repo') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/HosHaggag/instabug-task-source']])
            }
        }
        
        stage('Building Docker image') {
            steps{
                script {

                     dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push $registry'
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
