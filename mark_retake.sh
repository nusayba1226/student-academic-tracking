#!/bin/bash

read -p "Enter Student ID: " sid
read -p "Enter Course Name: " cname
read -p "Enter Course Code: " ccode
read -p "Enter Grade: " grade

course_key="$cname-$ccode"

if grep -q "^$sid|" students.txt; then
    sed -i "/^$sid|/ s/$course_key:[a-z]*:[A-ZX]/$course_key:retake:$grade/" students.txt
    echo "🔁 Course marked as retake."
else
    echo "❌ Student not found."
fi
