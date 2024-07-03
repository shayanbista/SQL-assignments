SELECT 
    student_name, 
    enrollment_date,
    ROW_NUMBER() OVER (ORDER BY enrollment_date) AS row_num
FROM 
    "University".Students
JOIN 
    "University".Enrollments ON Students.student_id = Enrollments.student_id;
