pipeline{
       environment {
    registry = "192.168.1.2:5000"
    registryCredential = 'dockerregistry'
    dockerImage = ''
  }
    agent any
    stages{
        stage('Git - Checkout') {
            steps{
                git branch: 'ansible', credentialsId: '', url: 'https://github.com/Saravananmoorthy/LoginWebApp.git'
            }
       }
       stage('Build App') {
            steps{
                sh "mvn clean install"
            }
        }
         stage('Build Docker image') {
      steps{
        script {
          sh "sudo docker build  $WORKSPACE/. -t loginapp:${BUILD_NUMBER}"
        }
      }
    }
    stage('Push Docker Image to Registry') {
      steps{
        script {
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerregistry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
          sh "sudo docker login --password=${PASSWORD} --username=${USERNAME} 192.168.1.2:5000"
          sh "sudo docker tag loginapp:${BUILD_NUMBER} 192.168.1.2:5000/loginapp:${BUILD_NUMBER}"
          sh "sudo docker push 192.168.1.2:5000/loginapp:${BUILD_NUMBER}"

          }
        }
      }
    }
           stage('Deploy Container using Ansible'){
                  steps{
                   ansiblePlaybook (
                   colorized: true,
                   credentialsId: 'ssh-sarav',
                   installation: 'ansible',
                   inventory: '${WORKSPACE}/inventory',
                   playbook: '${WORKSPACE}/dockerdeploy.yml',
                   disableHostKeyChecking: true,
                   extraVars   : [
                          BUILD_NUMBER: "${BUILD_NUMBER}"
                                ]
                  )       
                  }
           }
   }
}
