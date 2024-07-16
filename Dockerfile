FROM node:16 AS build-stage

WORKDIR /app

COPY package*.json ./
RUN echo "Installing npm dependencies..." \
    && npm install

COPY . .

RUN echo "Building Vue.js application..." \
    && npm run build
    
FROM python:3.9-slim AS robot-framework

WORKDIR /app

RUN echo "Installing system dependencies..." \
    && apt-get update \
    && apt-get install -y wget unzip \
    && echo "Installing Google Chrome..." \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb \
    && echo "Installing ChromeDriver..." \
    && wget https://chromedriver.storage.googleapis.com/94.0.4606.61/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver \
    && rm -f chromedriver_linux64.zip google-chrome-stable_current_amd64.deb \
    && echo "Installing Python dependencies..." \
    && pip install --upgrade pip \
    && pip install robotframework \
    && pip install robotframework-seleniumlibrary


COPY --from=build-stage /app/dist /app

COPY testsuite.robot /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]