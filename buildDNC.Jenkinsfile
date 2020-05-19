def dockerImage;

node('docker'){
	stage('SCM'){
		checkout([$class: 'GitSCM', branches: [[name: '*/follow-course']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kaubster/aspnetcore-generator-api']]]);
	}
	stage('build'){
		dockerImage = docker.build('localhost:55000/agents/jenkinsdocker:latest', './dotnetcore');
	}
	stage('push'){
		docker.withRegistry('http://localhost:55000/v2/', ''){
			dockerImage.push();
		}
	}
}