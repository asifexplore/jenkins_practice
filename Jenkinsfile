pipeline {
	agent any
	stages {
		stage('Dependency Check') {
			steps {
				git 'https://github.com/asifexplore/jenkins_practice.git'
				dependencyCheck additionalArguments: '--format HTML --format XML', odcInstallation: 'Default'
			}
		}
		stage('Integration UI Test')
		{
			agent {
				docker {
					image 'yanxun-image:latest'
				}
			}
			steps {
				sh 'nohup python3 app.py & pytest -s -rA --junitxml=logs/report.xml'
				sh 'pkill -f app.py'
			}
			post {
				always {
					junit testResults: 'logs/report.xml'
				}
			}
		}
	}	
	post {
		success {
			dependencyCheckPublisher pattern: 'dependency-check-report.xml'
		}
	}
}