#!/bin/bash

read -p "Enter Student ID: " sid
read -p "Enter Student Name: " name
read -p "Enter Semester: " sem

if grep -q "^$sid|" students.txt; then
    echo "⚠ Student already exists!"
else
    echo "$sid|$name|$sem" >> students.txt
    echo "✅ Student added successfully."
fi
