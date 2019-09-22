#!/bin/bash

service ssh start
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/app/projects --allow-root