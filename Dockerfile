FROM python:3.12-bookworm

RUN pip install --no-cache-dir poetry poetry-plugin-export
