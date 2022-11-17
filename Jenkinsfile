pipeline {
	agent any
	stages {
		stage('Dependency Check') {
			steps {
				git 'https://github.com/asifexplore/jenkins_practice.git'
				dependencyCheck additionalArguments: '--format HTML --format XML', odcInstallation: 'Default'
			}
		}
	}	
	post {
		success {
			dependencyCheckPublisher pattern: 'dependency-check-report.xml'
		}
	}
}