#!/bin/bash

num=4

if [ $# -eq 1 ]
then
    num=$1
fi

echo $num

# Define a function to run in a separate thread
function curl_function() {
    curl -i https://pipelinesghubeus20.actions.githubusercontent.com/_apis/health --http1.1
}

# Spawn multiple threads
for i in {1..$num}; do
    curl_function &
done

# Wait for all threads to finish
wait