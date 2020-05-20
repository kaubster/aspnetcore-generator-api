def dockerImage;

node('DOCKER'){
	stage('SCM'){
		checkout([$class: 'GitSCM', branches: [[name: '*/follow-course']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kaubster/aspnetcore-generator-api']]]);
	}
	stage('build'){
		//dockerImage = docker.build('localhost:55000/agents/jenkinsdocker:latest', './dotnetcore');
		// docker build -t agents/dotnetcore:v2.0 - < DotNetCore2_0-linux.Dockerfile
		// return docker.build('localhost:55000/agents/gen/agent-dnc:v$BUILD_NUMBER - < ./agents/dotnetcore/DotNetCore2_0-linux.Dockerfile')
		// sh label: '', script: 'docker build -t agents/dotnetcore:v2.0 - < ./agents/dotnetcore/DotNetCore2_0-linux.Dockerfile'
		dockerImage = docker.build('localhost:55000/agents/gen/agent-dnc:v$BUILD_NUMBER', './agents/dotnetcore/DotNetCore2_0-linux.Dockerfile');
	}
	stage('push'){
		docker.withRegistry('http://localhost:55000/v2/', ''){
			dockerImage.push();
		}
	}
}