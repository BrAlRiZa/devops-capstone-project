FROM python:3.9-slim

#Creates working folder
WORKDIR /app
#Copy requirements to container environment
COPY requirements.txt .
#Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

#Copy app contents
COPY service/ ./service/

#Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

#Run the service
EXPOSE 8080

CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]