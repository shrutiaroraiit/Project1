# Use official Python image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    vim \
    npm \
    tesseract-ocr \
    libsqlite3-dev \
    libglib2.0-0 \
    libtesseract-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy only necessary files first (if requirements.txt exists)
COPY requirements.txt . 

# Install Python dependencies (if requirements.txt exists)
RUN if [ -f "requirements.txt" ]; then pip install --no-cache-dir -r requirements.txt; fi

# Copy the entire project folder to the container
COPY . /app

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
