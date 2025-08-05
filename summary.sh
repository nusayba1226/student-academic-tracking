#!/bin/bash

total_students=$(wc -l < students.txt)
retake_count=$(grep -o "retake" students.txt | wc -l)
complete_count=$(grep -o "complete" students.txt | wc -l)
incomplete_count=$(grep -o "incomplete" students.txt | wc -l)
total_courses=$(grep -o "[a-zA-Z0-9]:[a-z]:[A-ZX]" students.txt | wc -l)

echo "📊 Summary Report"
echo "------------------------"
echo "👥 Total Students: $total_students"
echo "✅ Completed Courses: $complete_count"
echo "🔁 Retake Courses: $retake_count"
echo "⏳ Incomplete Courses: $incomplete_count"
echo "📚 Total Courses Assigned: $total_courses"
