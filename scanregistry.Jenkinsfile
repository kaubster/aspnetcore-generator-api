pipeline {
    agent { node { label 'DOCKER_SCANNER' } }
    //agent { docker 'localhost:55000/agents/container-scan:latest' }
    environment { 
        registry = 'localhost:55000'
    }
    stages {
        stage('Verify Branch') {
            steps {
                sh 'echo "$registry/jenkins_gen:ci-$BUILD_NUMBER"'
            }
        }
		Stage(‘Run Trivy’) {
			steps {
				sh(script: '''
					trivy localhost:55000/agents/dotnetcore:v3.1
				'''
			}
		}
	}
}