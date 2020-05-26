pipeline {
    agent { node { label 'DOCKER' } }
    //agent { docker 'localhost:55000/agents/jenkinsdocker:latest' }
    environment { 
        registry = 'localhost:55000'
		GENERATOR_BUILD_NUMBER = "$BUILD_NUMBER"
    }
    stages {
        stage('Verify Branch') {
            steps {
                sh 'echo "Docker Images"'
                sh 'echo "Build: $registry/gen:ci-$BUILD_NUMBER"'
                sh 'echo "Integration: $registry/gen:-$BUILD_NUMBER"'
            }
        }
    	stage('SCM'){
            steps {
    		    checkout([$class: 'GitSCM', branches: [[name: '*/follow-course']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kaubster/aspnetcore-generator-api']]]);
    	    }
    	}
        stage('Build and Unit Tests') {
            steps {
                // image="localhost:55000/gen:ci-%build.number%"
                // docker build -t $image --no-cache .
                sh 'docker build -t $registry/gen:ci-$BUILD_NUMBER --no-cache .'
            }
        }
    	stage('push'){
            steps {
                sh 'docker push $registry/gen:ci-$BUILD_NUMBER'
            }
    	}
        stage('List Docker Images') {
            steps {
                sh 'docker images -a'
            }
        }
    	stage('Integration Tests'){
            steps {
                sh '''
                cd integration/
                docker-compose up \\
                --force-recreate \\
                --abort-on-container-exit \\
                --build
                docker-compose down'''
            }
    	}
        stage('Cleaning up') {
            steps {
                sh 'docker rmi $registry/gen:ci-$BUILD_NUMBER'
                sh 'docker rmi $registry/gen:integration-$BUILD_NUMBER'
            }
        }
    }
}