#!/bin/bash

read -p "Enter Student ID: " sid
read -p "Enter Course Name: " cname
read -p "Enter Course Code: " ccode

if grep -q "^$sid|" students.txt; then
    sed -i "/^$sid|/ s/$/|$cname-$ccode:incomplete:X/" students.txt
    echo "✅ Course assigned."
else
    echo "❌ Student not found."
fi
