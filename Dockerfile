# Use the Python 3 official image
# https://hub.docker.com/_/python
FROM python:3

# Run in unbuffered mode
ENV PYTHONUNBUFFERED=1 

# Create and change to the app directory.
WORKDIR /app

# Copy local code to the container image.
COPY . ./

# Install project dependencies
RUN apt-get update && apt-get install -y \ portaudio19-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    libhdf5-103 \
    libatlas-base-dev \
    gfortran
RUN pip install --upgrade pip
RUN apt-get install -y libgl1-mesa-glx
RUN pip install --no-cache-dir -r requirements.txt

# Run the web service on container startup.
CMD ["gunicorn", "main:app"]
