pipeline {
    agent any

    stages{

        stage("Git Login"){
            steps{
                git branch: 'main', url: 'https://github.com/kshitijhatwar/Docker_Jenkins_project01.git'
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                sh "docker image tag $JOB_NAME:v1.$BUILD_ID kshitijhatwar/$JOB_NAME:v1.$BUILD_ID"
                sh "docker image tag $JOB_NAME:v1.$BUILD_ID kshitijhatwar/$JOB_NAME:latest"
            }
        }
        stage("Push Docker Image"){
            steps{
                withCredentials([string(credentialsId: 'docker-jenkins', variable: 'doc_jen')]) {
                sh "docker image push kshitijhatwar/$JOB_NAME:v1.$BUILD_ID"
                sh "docker image push kshitijhatwar/$JOB_NAME:latest"
                sh "docker rmi $JOB_NAME:v1.$BUILD_ID kshitijhatwar/$JOB_NAME:v1.$BUILD_ID kshitijhatwar/$JOB_NAME:latest"
                }
            }
        }
        stage("Docker Container Deployment to Web Server"){
            steps{
                script{
                    def docker_run = 'docker run -p 9008:80 --name docker-demo kshitijhatwar/dockerbuildjob:latest'
                    def docker_rmv_container = 'docker rm -f docker-demo'
                    def docker_rmi = 'docker rmi -f kshitijhatwar/dockerbuildjob'
                    def docker_status = ' docker ps -a '


                    sshagent(['sshkey']){
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.169.139 ${docker_rmv_container}"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.169.139 ${docker_rmi}"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.169.139 ${docker_run}"
                    }
                }
            }
        }
    }
}
