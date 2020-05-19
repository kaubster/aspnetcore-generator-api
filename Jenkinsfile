node('DOTNETCORE20'){
	stage('SCM'){
		checkout([$class: 'GitSCM', branches: [[name: '*/follow-course']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kaubster/aspnetcore-generator-api']]])
	}
	stage('Build'){
		try{
		sh 'dotnet build ./api/api'
		}finally{
		 
		}
	}
	stage('Test'){
		echo 'Execute unit tests'
	}
	stage('Package'){
		echo 'Zip it up'
	}
	stage('Deploy'){
		echo 'Push to deployment'
	}
	stage('Archive'){
		 
	}
}