PROJECT_NAME := employeemanagmentsystem
NODE_VERSION := 18.17.0
PYTHON_VERSION := 3.9
DOCKER_IMAGE := ${PROJECT_NAME}-image
BUILD_DIR := dist

setup-node:
	@echo "Setting up Node.js environment..."
	nvm install ${NODE_VERSION}
	nvm use ${NODE_VERSION}
	npm install -g npm@8.19.2
	npm install

setup-python:
	@echo "Setting up Python environment..."
	pyenv install ${PYTHON_VERSION}
	pyenv .pythonlibs${PYTHON_VERSION} ${PROJECT_NAME}
	pyenv activate ${PROJECT_NAME}
	pip install --upgrade pip
	pip install robotframework robotframework-seleniumlibrary

setup:
	@$(MAKE) setup-node

lint:
	@echo "Running linters..."
	npm run lint
	@echo "Linting complete."

test:
	@echo "Running tests..."
	npm test
	@echo "Tests complete."

build:
	@echo "Building the project..."
	npm run build
	@echo "Build complete."

docker-build:
	@echo "Building Docker image..."
	docker build -t ${DOCKER_IMAGE} .
	@echo "Docker image built."

docker-run:
	@echo "Running Docker container..."
	docker run -d -p 3000:3000 --name ${PROJECT_NAME} ${DOCKER_IMAGE}
	@echo "Docker container running."

docker-clean:
	@echo "Stopping and removing Docker container..."
	docker stop ${PROJECT_NAME}
	docker rm ${PROJECT_NAME}
	@echo "Docker container stopped and removed."

deploy:
	@echo "Deploying to server..."
	ssh -i ${SSH_KEY} ${SSH_USER}@${SSH_HOST} 'rm -rf /var/www/html/*'
	scp -i ${SSH_KEY} -r ${BUILD_DIR}/* ${SSH_USER}@${SSH_HOST}:/var/www/html/
	ssh -i ${SSH_KEY} ${SSH_USER}@${SSH_HOST} 'sudo systemctl restart nginx'
	@echo "Deployment complete."

automation:
	@echo "Running automation checks..."
	@if [ -d "${BUILD_DIR}" ]; then \
		echo "Build directory exists"; \
	else \
		echo "Build directory not found"; \
		exit 1; \
	fi
	@if [ -f "${BUILD_DIR}/index.html" ]; then \
		echo "Build output verified"; \
	else \
		echo "Build output missing"; \
		exit 1; \
	fi
	@echo "Automation checks complete."

security-test:
	@echo "Running security tests..."
	npm run security-test
	@echo "Security tests complete."

all: setup lint test build docker-build docker-run deploy automation security-test

.PHONY: setup setup-node setup-python lint test build docker-build docker-run docker-clean deploy automation security-test all