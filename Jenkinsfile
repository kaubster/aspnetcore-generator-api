pipeline {
    agent { node { label 'DOCKER' } }
    //agent { docker 'localhost:55000/agents/jenkinsdocker:latest' }
    environment { 
        registry = 'localhost:55000'
    }
    stages {
        stage('Verify Branch') {
            steps {
                sh 'echo "$registry/jenkins_gen:ci-$BUILD_NUMBER"'
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
                sh 'docker build -t $registry/jenkins_gen:ci-$BUILD_NUMBER --no-cache .'
            }
        }
    	stage('push'){
            steps {
                sh 'docker push $registry/jenkins_gen:ci-$BUILD_NUMBER'
            }
    	}
        stage('List Docker Images') {
            steps {
                sh 'docker images -a'
            }
        }
        stage('Cleaning up') {
            steps {
                sh 'docker rmi $registry/jenkins_gen:ci-$BUILD_NUMBER'
            }
        }
    	stage('Integration Tests'){
            steps {
                // docker-compose up \
                // --force-recreate \
                // --abort-on-container-exit \
                // --build
                // docker-compose down
                sh '''
                cd integration/
                docker-compose up \\
                --force-recreate \\
                --abort-on-container-exit \\
                --build
                docker-compose down'''
            }
    	}
    }
}