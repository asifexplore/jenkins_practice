pipeline {
	agent any
	environment {
        // CI set to true to allow it to run in "non-watch" (i.e. non-interactive) mode
        CI = 'true'
    }
	stages {
		stage('Dependency Check') {
			steps {
				git 'https://github.com/asifexplore/jenkins_practice.git'
				dependencyCheck additionalArguments: '--format HTML --format XML', odcInstallation: 'Default'
			}
		}
		stage('Build') { 
            steps {
                script {
                    try {
                        // clean all unused images
                        sh 'yes | docker image prune -a'
                    }
                    catch (Exception e) {
                        echo "no unused images deleted"
                    }
                    try {
                        // clean all unused containers
                        sh 'yes | docker container prune'
                    }
                    catch (Exception e) {
                        echo "no unused containers deleted"
                    }
                }
                // ensure latest image is being build
                sh 'docker build -t yanxun-image:latest .'
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
				sh 'chmod +x ./app.py'
				sh 'chmod +x ./test_ui.py'
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