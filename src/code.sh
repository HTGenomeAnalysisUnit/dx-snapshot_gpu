#!/bin/bash

echo 
echo "=== Configured options ==="
echo "Docker image: ${snapshot}"
echo "Input files: ${input_files}"
echo "Home directory: ${HOME}"
echo "================================"

mkdir -p /inputs
mkdir -p $HOME/out/out_files

echo "=== Download input files ==="
dx-download-all-inputs

echo "=== Sym link your input files ==="
ln -s $HOME/in/input_files/*/* /inputs/

echo "=== List input files now in /inputs ==="
ls /inputs

echo "=== Prepare script to run ==="
echo "${cmd}" > /inputs/run_script.sh

echo "=== Set up docker image ==="
# Here we get the docker image filename from $HOME/in/snapshot
docker_image=$(ls $HOME/in/snapshot/*)
echo "Docker image file: ${docker_image}"

# Now load it and tag it as base_image:1.0
echo "=== Load the docker image ==="
loaded_image=$(docker load -i ${docker_image} 2>&1 | grep "Loaded image:" | awk '{print $3}')
echo "Loaded image name: $loaded_image"

echo "Finished processing input files."
echo "================================"


echo "=== Run the script in docker image ==="
docker run --gpus all \
  	-v $HOME:$HOME \
  	-v /inputs:/inputs \
 	-v $HOME/out/out_files:/outputs \
	--entrypoint /bin/bash \
	${loaded_image} \
	/inputs/run_script.sh

echo "=== List output files ==="
ls $HOME/out/out_files

echo "=== Upload output files ==="
dx-upload-all-outputs