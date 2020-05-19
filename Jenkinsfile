node('DOTNETCORE_2_0') {  
    stage('SCM') { 
       checkout([$class: 'GitSCM', branches: [[name: '*/follow-course']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'kaubster', url: 'https://github.com/kaubster/aspnetcore-generator-api.git']]])
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