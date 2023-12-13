FROM python:3.9-slim


WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application content
COPY service/ ./service/

# Create non-root user called theia, give recursivelly ownership of /app to theia
RUN useradd --uid 1000 theia && chown -R theia /app

# Set the name of user for following commands
USER theia

EXPOSE  8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
