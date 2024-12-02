# Use the Python 3.10 slim image for compatibility with TensorFlow
FROM python:3.10-slim

# Set environment variables for unbuffered logs and Python performance
ENV PYTHONUNBUFFERED=1 

# Set the working directory
WORKDIR /app

# Copy local code to the container image
COPY . .

# Install system dependencies required for TensorFlow, OpenCV, and PortAudio
RUN apt-get update && apt-get install -y --no-install-recommends \
    portaudio19-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    libatlas-base-dev \
    gfortran \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Specify the command to run the web service
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:" + os.environ.get("PORT", "51234"), "main:app"]
