pipeline {
    agent any

    environment {
        REGISTRY = "employeemanagement.com"
        APP_NAME = "employee_managment"
        IMAGE_NAME = "${REGISTRY}/${APP_NAME}:${env.BUILD_ID}"
    }

    options {
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        retry(3)
    }

    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '')
    }

    stages {
        stage('Preparation') {
            steps {
                echo "Cleaning workspace"
                cleanWs()
                echo "Checking out code"
                checkout scm
                script {
                    if (!fileExists('Dockerfile')) {
                        error "Dockerfile not found!"
                    }
                }
            }
        }

        stage('Static Code Analysis') {
            parallel {
                stage('ESLint') {
                    steps {
                        echo "Running ESLint"
                        sh 'npm install eslint'
                        sh 'eslint src/**/*.js'
                    }
                }
                stage('PyLint') {
                    steps {
                        echo "Running PyLint"
                        sh 'pip install pylint'
                        sh 'pylint **/*.py || true'
                    }
                }
            }
        }

        stage('Security Checks') {
            parallel {
                stage('Dependency Check') {
                    steps {
                        echo "Running Dependency Check"
                        sh 'npm install snyk'
                        sh 'snyk test'
                    }
                }
                stage('Bandit') {
                    steps {
                        echo "Running Bandit for Python Security Analysis"
                        sh 'pip install bandit'
                        sh 'bandit -r . || true'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo "Building Docker image"
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        echo "Running unit tests"
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
                stage('Python Tests') {
                    steps {
                        echo "Running Python tests"
                        sh 'pip install -r requirements.txt'
                        sh 'pytest'
                    }
                }
            }
        }

        stage('Push to Registry') {
            steps {
                echo "Logging in to Docker registry"
                withCredentials([string(credentialsId: 'docker-registry-credentials', variable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u myusername --password-stdin ${REGISTRY}'
                }
                echo "Pushing Docker image"
                sh "docker push ${IMAGE_NAME}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying to Kubernetes"
                script {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }

        stage('Post-Deployment Monitoring') {
            steps {
                echo "Setting up Prometheus monitoring"
                script {
                    sh 'kubectl apply -f monitoring/prometheus-config.yaml'
                    sh 'kubectl apply -f monitoring/prometheus-deployment.yaml'
                    sh 'kubectl apply -f monitoring/grafana-deployment.yaml'
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up Docker images"
            sh 'docker rmi ${IMAGE_NAME} || true'
        }
        success {
            echo "Build succeeded"
        }
        failure {
            echo "Build failed"
        }
        unstable {
            echo "Build unstable"
        }
        cleanup {
            echo "Cleaning workspace"
            cleanWs()
        }
    }
}