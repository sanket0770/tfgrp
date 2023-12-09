pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Replace 'your-github-repo' and 'your-branch' with the actual values
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/sanket0770/tfgrp.git']]])
            }
        }

        stage('Run Terraform Script 1') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '25c9050a-a97c-46f2-9968-26db13b6e929', accessKeyVariable: 'AKIAX3LNWYOGIVRPHOXY', secretKeyVariable: '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']]) {
                        // Specify the path to the Terraform script within the cloned repository
                        bat 'terraform init -chdir=s3.tf'
                        bat 'terraform apply -auto-approve -chdir=s3.tf'
                    }
                }
            }
        }

        stage('Run Terraform Script 2') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '25c9050a-a97c-46f2-9968-26db13b6e929', accessKeyVariable: 'AKIAX3LNWYOGIVRPHOXY', secretKeyVariable: '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']]) {
                        // Specify the path to the Terraform script within the cloned repository
                        bat 'terraform init -chdir=rds.tf'
                        bat 'terraform apply -auto-approve -chdir=rds.tf'
                    }
                }
            }
        }

        // Add more stages for additional Terraform scripts as needed
    }
}
