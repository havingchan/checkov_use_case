pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/havingchan/checkov_use_case.git'
            }
        }

        stage('Run Checkov Scan') {
            steps {
                script {
                    sh 'checkov -f main.tf --output junitxml > checkov_report.xml'
                }
            }
        }

        stage('Publish Checkov Report') {
            steps {
                junit 'checkov_report.xml'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

