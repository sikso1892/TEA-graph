# CUDA 11.1을 사용하는 PyTorch가 필요하므로 CUDA 11.1 기반의 Python 이미지를 선택
FROM nvidia/cuda:11.1.1-base-ubuntu20.04

# 기본적인 도구 및 Python 설치
RUN apt-get update && apt-get install -y \
    python3.8 python3-pip python3.8-dev 

# 파이썬 별칭 설정
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

# pip 업그레이드
RUN python -m pip install --upgrade pip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openslide-tools 

# 작업 디렉터리 설정
WORKDIR /work


# TEA-Graph 의존성 패키지
RUN pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install torch_geometric
RUN pip install pandas scikit-learn tqdm openslide-python networkx scikit-image 

ENV PYTHONPATH=/work/Superpatch_network_construction

# JupyterHub
RUN apt-get -y install npm nodejs
RUN npm install -g configurable-http-proxy
RUN pip install jupyterhub jupyterlab
RUN pip install pamela

# etc..
RUN pip install matplotlib tifffile imagecodecs ipywidgets

# 기본 커맨드 설정
CMD ["jupyterhub"]

