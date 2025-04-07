#!/bin/bash
# filepath: ~/SNU-inference/setup_conda.sh
# run this script
# ~/SNU-inference/setup_conda.sh


# 1. SNU-inference 폴더 마운트 (필요한 경우)
# 파일시스템이 자동으로 마운트되지 않았다면 아래 명령어를 수정하여 사용
# echo "Mounting SNU-inference directory..."
# mount [파일시스템 경로] ~/SNU-inference

# 2. Miniconda 경로 설정
echo "Setting up Miniconda environment variables..."
echo '. ~/SNU-inference/miniconda3/etc/profile.d/conda.sh' >> ~/.bashrc
echo 'export PATH="~/SNU-inference/miniconda3/bin:$PATH"' >> ~/.bashrc
echo 'export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1' >> ~/.bashrc

# 3. 설정 적용
echo "Applying environment variables..."
export PATH=~/SNU-inference/miniconda3/bin:$PATH
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1  # OpenSSL 관련 문제 해결
source ~/.bashrc

# 4. Conda 명령어 확인
echo "Checking Conda installation..."
if ! command -v conda &> /dev/null; then
    echo "Conda command not found. Initializing Conda..."
    ~/SNU-inference/miniconda3/bin/conda init bash
    source ~/.bashrc
else
    echo "Conda is already set up."
fi


# 4.1 Python 경로 확인 및 수정
CONDA_BIN=~/SNU-inference/miniconda3/bin/conda
if grep -q "/home/ubuntu/miniconda3/bin/python" "$CONDA_BIN"; then
    echo "Fixing Python path in Conda..."
    sed -i '1s|/home/ubuntu/miniconda3/bin/python|/home/ubuntu/SNU-inference/miniconda3/bin/python|' "$CONDA_BIN"
fi


# 5. Conda 명령어 및 Python 버전 확인
echo "Verifying Conda and Python setup..."
conda --version
python --version


# 6. 사용자 알림
echo "Setup complete! Make sure to save important files in ~/SNU-inference before terminating the instance."
