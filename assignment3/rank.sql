-- Rank students based on the number of courses they are enrolled in, handling ties by assigning the same rank.
SELECT 
    student_name, 
    RANK() OVER (ORDER BY COUNT(course_id)DESC) AS rank
FROM 
    "University".Students
JOIN 
    "University".Enrollments ON Students.student_id = Enrollments.student_id
	GROUP BY Students.student_id;
