pipeline {
    agent { node { label 'DOCKER_SCANNER' } }
    //agent { docker 'localhost:55000/agents/container-scan:latest' }
    environment { 
        registry = 'localhost:55000'
    }
    stages {
        stage('Verify Branch') {
            steps {
                sh 'echo "$registry $BUILD_NUMBER"'
            }
        }
		stage('Run Trivy') {
			steps {
				sh '''
					trivy localhost:55000/gen:ci-94
				'''
            }
		}
	}
}