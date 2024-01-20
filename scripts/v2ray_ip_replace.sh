#!/bin/bash


# read url from args
url=$1

# If no URL is provided, exit with usage
if [[ -z "$url" ]]; then
    echo "Usage: $0 <url>"
    exit 1
fi

# Fetch the content from the URL
content=$(curl -s "$url")

# Process each line of the content
echo "$content" | while read -r line; do
    # Extract the first URL from each line using regex
    first_url=$(echo "$line" | grep -oP '(?<=@)[^:]+' | head -n 1)
    
    # If a URL is found, resolve it to an IP address
    if [[ ! -z "$first_url" ]]; then
        ip=$(dig +short "$first_url" | head -n 1)
        
        # Replace the URL with the IP address in the line
        new_line=$(echo "$line" | sed "s|$first_url|$ip|")
        echo "$new_line"
    else
        echo "$line"
    fi
done
