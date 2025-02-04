FROM python:3.9.20

WORKDIR /app

COPY requirements.txt /app

RUN pip3 install uv

RUN uv pip install -r requirements.txt --system

# Add user to container
ARG UID
ARG GID
RUN groupadd -o -g $GID myuser && useradd -u $UID -g $GID -m myuser
RUN chown -R myuser:myuser /app
USER myuser

ENV HF_HUB_CACHE="/app/cache"

ENV HF_HOME="/app/cache"

CMD ["python", "test.py"]

# docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t ${USER}_4Kdocker

# docker run -it --rm -v $(pwd):/app --name ${USER}_4Kcontainer ${USER}_4Kdocker

# docker run --rm --gpus '"device=0"' -v $(pwd):/app --name ${USER}_4Kcontainer ${USER}_4Kdocker