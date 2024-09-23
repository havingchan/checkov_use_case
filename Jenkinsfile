pipeline {
    agent any

    environment {
        // You can set any environment variables here if needed, such as AWS credentials, ..
    }

    stages {
        // Stage 1: Checkout the Terraform code from the repository
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/havingchan/check_use_case.git'
            }
        }

        // Stage 2: Run Checkov to scan the Terraform code for security issues
        stage('Run Checkov Scan') {
            steps {
                script {
                    // Run Checkov on the directory with Terraform code
                    sh 'checkov -d . -o junitxml > checkov_report.xml'
                }
            }
        }

        // Stage 3: Publish the Checkov results in Jenkins
        stage('Publish Checkov Report') {
            steps {
                script {
                    // Archive the report so Jenkins can display it
                    junit 'checkov_report.xml'
                }
            }
        }

        // Stage 4: Run Terraform Init (Optional)
        stage('Terraform Init') {
            steps {
                script {
                    // Initialize the Terraform environment
                    sh 'terraform init'
                }
            }
        }

        // Stage 5: Run Terraform Plan
        stage('Terraform Plan') {
            steps {
                script {
                    // Generate a Terraform plan
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        // Optional: Apply Terraform changes after Checkov scan passes
        stage('Terraform Apply') {
            when {
                expression {
                    // You can use Checkov scan results to determine whether to proceed with the apply.
                    // Example: Proceed only if Checkov report is clean.
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Apply the Terraform plan
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            // Always clean up resources, e.g., remove Terraform plans
            cleanWs()
        }
    }
}
