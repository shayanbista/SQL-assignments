SELECT 
    student_name, 
    RANK() OVER (ORDER BY COUNT(course_id)DESC) AS rank
FROM 
    "University".Students
JOIN 
    "University".Enrollments ON Students.student_id = Enrollments.student_id
	GROUP BY Students.student_id;
