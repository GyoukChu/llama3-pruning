#!/bin/bash

# This Bash script runs the Python script with arguments

# Run the Python script with command-line arguments
python layer_similarity.py --model_path "meta-llama/Meta-Llama-3-8B" \
                      --dataset "pg19" \
                      --dataset_column "text" \
                      --batch_size 8 \
                      --max_length 8192 \
                      --layers_to_skip 1 \
                      --dataset_size 10000 \
                      --dataset_subset "validation" 