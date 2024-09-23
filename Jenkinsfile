pipeline {
    agent any

    stages {
        // Stage 1: Checkout the Terraform code from the GitHub repository
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/havingchan/checkov_use_case.git'
            }
        }

        // Stage 2: Run Checkov to scan the Terraform code for security issues
        stage('Run Checkov Scan') {
            steps {
                script {
                    // Run Checkov on the directory with the Terraform main.tf file
                    sh 'checkov -f main.tf --output junitxml > checkov_report.xml'
                }
            }
        }

        // Stage 3: Publish the Checkov results in Jenkins
        stage('Publish Checkov Report') {
            steps {
                // Publish the Checkov JUnit report in Jenkins
                junit 'checkov_report.xml'
            }
        }

        // Stage 4: Run Terraform Init
        stage('Terraform Init') {
            steps {
                script {
                    // Initialize the Terraform environment
                    sh 'terraform init'
                }
            }
        }

        // Stage 5: Run Terraform Apply
        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform configuration
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace after the job completes
            cleanWs()
        }
    }
}

