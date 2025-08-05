#!/bin/bash

read -p "Enter student ID: " id

line=$(grep "^$id|" students.txt)

if [ -z "$line" ]; then
    echo "❌ Student not found."
    exit 1
fi

IFS='|' read -ra fields <<< "$line"

total_points=0
course_count=0

# Function to convert letter grades to grade points
get_point() {
    case $1 in
        A+) echo 4.0 ;;
        A)  echo 3.75 ;;
        A-) echo 3.5 ;;
        B+) echo 3.25 ;;
        B)  echo 3.0 ;;
        B-) echo 2.75 ;;
        C+) echo 2.5 ;;
        C)  echo 2.25 ;;
        D)  echo 2.0 ;;
        F)  echo 0.0 ;;
        *)  echo -1 ;;
    esac
}

declare -A seen

# Collect the latest record for each course
for ((i=3; i<${#fields[@]}; i++)); do
    IFS=':' read -ra course <<< "${fields[i]}"
    cname="${course[0]}"
    grade="${course[1]}"
    status="${course[2]}"

    [[ -z "$cname" ]] && continue
    seen["$cname"]="$grade:$status"
done

# Calculate CGPA
for cname in "${!seen[@]}"; do
    g=$(echo "${seen[$cname]}" | cut -d ':' -f1)
    s=$(echo "${seen[$cname]}" | cut -d ':' -f2)

    if [[ "$s" == Completed* ]]; then
        point=$(get_point "$g")
        if (( $(echo "$point >= 0" | bc -l) )); then
            total_points=$(echo "$total_points + $point" | bc)
            ((course_count++))
        fi
    fi
done

if [ "$course_count" -eq 0 ]; then
    echo "⚠ No completed courses for CGPA."
else
    cgpa=$(echo "scale=2; $total_points / $course_count" | bc)
    echo "✅ CGPA for Student $id: $cgpa"
fi


