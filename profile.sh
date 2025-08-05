#!/bin/bash

read -p "Enter student ID: " id

student_line=$(grep "^$id|" students.txt)

if [ -z "$student_line" ]; then
    echo "❌ Student not found."
    exit 1
fi

IFS='|' read -ra fields <<< "$student_line"
name=${fields[1]}
semester=${fields[2]}

echo "====== Student Profile ======"
echo "🎓 ID       : $id"
echo "👤 Name     : $name"
echo "📆 Semester : $semester"
echo "📚 Courses:"

for ((i=3; i<${#fields[@]}; i++))
do
    IFS=':' read -ra course <<< "${fields[i]}"
    echo "- ${course[0]} | Grade: ${course[1]} | Status: ${course[2]}"
done
