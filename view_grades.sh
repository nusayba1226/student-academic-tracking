#!/bin/bash

read -p "Enter Student ID: " sid

# Find the student line in students.txt
line=$(grep "^$sid|" students.txt)

if [ -z "$line" ]; then
    echo "❌ Student not found."
    exit
fi

# Extract student info
name=$(echo "$line" | cut -d '|' -f2)
sem=$(echo "$line" | cut -d '|' -f3)

echo ""
echo "📄 Grade Sheet for Student ID: $sid"
echo "----------------------------------"
echo "👤 Name     : $name"
echo "📘 Semester : $sem"
echo ""
echo "📚 Courses:"

# Split line into fields
IFS='|' read -ra fields <<< "$line"
declare -A seen

# Collect the latest record for each course
for ((i=3; i<${#fields[@]}; i++)); do
    IFS=':' read -ra course <<< "${fields[i]}"
    cname="${course[0]}"
    grade="${course[1]}"
    status="${course[2]}"

    [[ -z "$cname" ]] && continue
    seen["$cname"]="${grade:-Unknown}:${status:-Unknown}"
done

# Display cleaned grade sheet
for cname in "${!seen[@]}"; do
    g=$(echo "${seen[$cname]}" | cut -d ':' -f1)
    s=$(echo "${seen[$cname]}" | cut -d ':' -f2)
    echo "- $cname : $s (${g:-Unknown})"
done


