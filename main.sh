#!/bin/bash

while true; do
  echo ""
  echo "===== Student Academic Tracking System ====="
  echo "1. Add Student"
  echo "2. Assign Course"
  echo "3. Mark Course as Complete"
  echo "4. Mark Course as Retake"
  echo "5. View Grade Sheet"
  echo "6. Total Students"
  echo "7. Total Retake Students"
  echo "8. Total Course Assigned"
  echo "9. Total Course Completed"
  echo "10. View Full Summary"
  echo "11. View Student Profile"
  echo "12. Calculate CGPA"
  echo "13. Exit"
  echo "============================================"
  read -p "Enter your choice: " choice

  case $choice in
    1) ./add_student.sh ;;
    2) ./assign_course.sh ;;
    3) ./mark_complete.sh ;;
    4) ./mark_retake.sh ;;
    5) ./view_grades.sh ;;
    6)
      total=$(cut -d',' -f1 students.txt | sort | uniq | wc -l)
      echo "Total students: $total"
      ;;
    7)
      total=$(grep ",retake" students.txt | cut -d',' -f1 | sort | uniq | wc -l)
      echo "Total students with retakes: $total"
      ;;
    8)
      total=$(grep "assigned" students.txt | wc -l)
      echo "Total courses assigned: $total"
      ;;
    9)
      total=$(grep "complete" students.txt | wc -l)
      echo "Total courses completed: $total"
      ;;
    10) ./summary.sh ;;
    11) ./profile.sh ;;
    12) ./cgpa.sh ;;
    13) echo "Exiting..."; exit ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
done
