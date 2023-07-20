#!/bin/bash

# Define a function to run in a separate thread
function curl_function() {
    curl -i https://pipelinesghubeus20.actions.githubusercontent.com/_apis/health --http1.1
}

# Spawn multiple threads
for i in {1..4}; do
    curl_function $i &
done

# Wait for all threads to finish
wait