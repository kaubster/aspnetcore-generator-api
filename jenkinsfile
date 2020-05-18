node('DOTNETCORE_2_0') {  
    stage('Checkout') { 
        checkout scm
    }
    stage('Build & UnitTest') { 
        sh label: '', script: 'docker images -a'
        sh label: '', script: 'docker build -t "localhost:55000/gen:ci-${BUILD_NUMBER} --no-cache .'
        sh label: '', script: 'docker push "localhost:55000/gen:ci-${BUILD_NUMBER}'
        sh label: '', script: 'docker rmi "localhost:55000/gen:ci-${BUILD_NUMBER}'
    }
    stage('Integration Test') { 
        sh label: '', script: '''docker-compose up \\
        --force-recreate \\
        --abort-on-container-exit \\
        --build'''
        sh label: '', script: 'docker-compose down'
    } 
}