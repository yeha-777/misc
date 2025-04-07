#!/bin/bash
# bash ~/SNU-inference/setup_conda.sh

# 파일시스템이 자동으로 마운트되지 않았다면 아래 명령어를 수정하여 사용
# echo "Mounting SNU-inference directory..."
# mount [파일시스템 경로] ~/SNU-inference

# Miniconda 경로 설정
echo "Setting up Miniconda environment variables..."
echo '. ~/SNU-inference/miniconda3/etc/profile.d/conda.sh' >> ~/.bashrc
echo 'export PATH="~/SNU-inference/miniconda3/bin:$PATH"' >> ~/.bashrc
echo 'export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1' >> ~/.bashrc

# 환경 변수 적용
echo "Applying environment variables..."
export PATH=~/SNU-inference/miniconda3/bin:$PATH
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
source ~/.bashrc
sleep 5

# 환경 변수 적용 확인
if ! command -v conda &> /dev/null; then
    echo "ERROR: Conda command not found after applying environment variables."
    exit 1
fi

# Conda 설치 및 초기화 확인
echo "Checking Conda installation..."
if ! command -v conda &> /dev/null; then
    echo "Conda command not found. Initializing Conda..."
    ~/SNU-inference/miniconda3/bin/conda init bash
    sleep 5
    source ~/.bashrc
    sleep 3

    # 초기화 후 Conda 확인
    if ! command -v conda &> /dev/null; then
        echo "ERROR: Conda initialization failed."
        exit 1
    fi
else
    echo "Conda is already set up."
fi

# Python 경로 확인 및 수정
CONDA_BIN=~/SNU-inference/miniconda3/bin/conda
if grep -q "/home/ubuntu/miniconda3/bin/python" "$CONDA_BIN"; then
    echo "Fixing Python path in Conda..."
    sed -i '1s|/home/ubuntu/miniconda3/bin/python|/home/ubuntu/SNU-inference/miniconda3/bin/python|' "$CONDA_BIN"

    # 수정 확인
    if ! grep -q "/home/ubuntu/SNU-inference/miniconda3/bin/python" "$CONDA_BIN"; then
        echo "ERROR: Failed to fix Python path in Conda."
        exit 1
    fi
fi

# Conda 및 Python 버전 확인
echo "Verifying Conda and Python setup..."
if ! conda --version &> /dev/null; then
    echo "ERROR: Conda is not functioning properly."
    exit 1
fi

if ! python --version &> /dev/null; then
    echo "ERROR: Python is not functioning properly."
    exit 1
fi


echo "Setup complete! Make sure to save important files in ~/SNU-inference before terminating the instance."
