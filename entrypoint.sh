#!/bin/bash
set -e

install_dependencies() {
    echo "Installing system dependencies..."
    apt-get update
    apt-get install -y wget unzip
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install -y ./google-chrome-stable_current_amd64.deb
    wget https://chromedriver.storage.googleapis.com/94.0.4606.61/chromedriver_linux64.zip
    unzip chromedriver_linux64.zip
    mv chromedriver /usr/local/bin/
    chmod +x /usr/local/bin/chromedriver
    rm -f chromedriver_linux64.zip google-chrome-stable_current_amd64.deb
}

start_services() {
    echo "Starting Selenium WebDriver (ChromeDriver)..."
    nohup chromedriver --port=4444 --url-base=/wd/hub > chromedriver.log 2>&1 &
    CHROMEDRIVER_PID=$!

    echo "Starting Vue.js application..."
    npm install
    npm run start &
    sleep 15  
}


run_tests() {
    echo "Running Robot Framework tests..."
    robot testsuite.robot
}


cleanup() {
    echo "Stopping services..."
    kill $(jobs -p) || true
    kill $CHROMEDRIVER_PID || true
}

trap cleanup EXIT

install_dependencies
start_services
run_tests