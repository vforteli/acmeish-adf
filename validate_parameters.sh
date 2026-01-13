#!/bin/bash

file1="build/ExportedArmTemplate/ARMTemplateParametersForFactory.json"
file2="deploy/parameters/parameters-test.json"

files_to_check=(
  # "deploy/parameters/parameters-test.json"
  "deploy/parameters/parameters-prod.json"  
)

keys1=$(jq -r '.parameters | keys_unsorted[]' "$file1")

for file2 in "${files_to_check[@]}"; do
    keys2=$(jq -r '.parameters | keys_unsorted[]' "$file2")

    missing_in_file2=$(comm -23 <(echo "$keys1" | sort) <(echo "$keys2" | sort))
    missing_in_file1=$(comm -23 <(echo "$keys2" | sort) <(echo "$keys1" | sort))

    if [[ -n "$missing_in_file2" ]]; then
      echo -e "\033[31mUh oh, parameters missing in: '$file2':"
      echo "$missing_in_file2"    
      exit 1
    fi

    if [[ -n "$missing_in_file1" ]]; then
      echo -e "\033[31mUh oh, extra parameters in: '$file2':"
      echo "$missing_in_file1"      
      exit 1
    fi
    
    echo -e "$file2: \033[32mOk\033[0m"    

done