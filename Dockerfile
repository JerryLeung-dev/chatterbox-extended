# Use a slim Python base; RunPod provides GPU drivers & CUDA
FROM python:3.10-slim

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    curl \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    build-essential \
    python3-dev \
    && apt-get clean

# Set working directory
WORKDIR /workspace

# Clone Chatterbox-TTS-Extended
RUN git clone https://github.com/petermg/Chatterbox-TTS-Extended.git .

# Optional: check out specific commit/tag
# RUN git checkout <tag-or-commit>

# Install torch separately (latest stable for CUDA 12.1 via PyTorch)
RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install Python requirements
RUN pip install -r requirements.txt

# Run the app on container start
CMD ["python", "Chatter.py"]
