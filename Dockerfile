FROM python:3.11-slim

# set workdir
WORKDIR /app


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy app files
COPY . .

# set enviroment variavbles
ENV FLASK_APP=run.py
ENV FLASK_RUN_HOST=0.0.0.0

# open port 5000 (default for Flask)
EXPOSE 5000


CMD ["flask", "run"]