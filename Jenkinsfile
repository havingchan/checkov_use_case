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
                // Publish the Checkov JUnit report
                junit 'checkov_report.xml'
            }
        }

        // Stage 4: Run Terraform Init (Only if Checkov passes)
        stage('Terraform Init') {
            when {
                expression {
                    // Proceed only if the Checkov scan passes (i.e., the build result is SUCCESS)
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Initialize the Terraform environment
                    sh 'terraform init'
                }
            }
        }

        // Stage 5: Run Terraform Apply (Only if Init and Plan succeed)
        stage('Terraform Apply') {
            when {
                expression {
                    // Apply only if the Checkov scan and terraform init succeeded
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
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

