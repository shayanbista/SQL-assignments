-- Query to create a database 
	create database db_assignment2
-- Query to use the database
	\c  db_assignment2

-- 1. Query to select students enrolled in Math course
SELECT * 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM Enrollments 
    WHERE course_id = (
        SELECT course_id 
        FROM courses 
        WHERE course_name = 'Math'
    )
);

-- 2. Query to select course details for student named BOB
SELECT course_id, course_name 
FROM Courses 
WHERE course_id IN (
    SELECT course_id 
    FROM Enrollments 
    WHERE student_id = (
        SELECT student_id 
        FROM students 
        WHERE student_name = 'BOB'
    )
);

-- 3. Query to select students enrolled in more than one course
SELECT student_name 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM Enrollments 
    GROUP BY student_id 
    HAVING COUNT(course_id) > 1
);

-- 4. Query to select student names with grade ID 1
SELECT student_name 
FROM students 
WHERE student_grade_id = 1;

-- 5. Query to select course details with student count
SELECT course_id, (
    SELECT course_name 
    FROM Courses 
    WHERE Courses.course_id = Enrollments.course_id
) AS course_name, 
COUNT(student_id) 
FROM Enrollments 
GROUP BY course_id;

-- 6. Query to select the most enrolled course with details
SELECT course_id, (
    SELECT course_name 
    FROM Courses 
    WHERE Courses.course_id = Enrollments.course_id
) AS course_name, 
COUNT(student_id) 
FROM Enrollments 
GROUP BY course_id 
ORDER BY COUNT DESC 
LIMIT 1;

-- 7. Query to select students enrolled in all available courses
SELECT student_id, student_name 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM enrollments 
    GROUP BY student_id 
    HAVING COUNT(DISTINCT course_id) = (
        SELECT COUNT(DISTINCT course_id) 
        FROM enrollments
    )
);

-- 8. Query to select students not enrolled in any course
SELECT student_id, student_name 
FROM students 
WHERE student_id NOT IN (
    SELECT DISTINCT student_id 
    FROM enrollments
);

-- 9. Query to select average age of students enrolled in Science course
SELECT AVG(student_age) AS average_students_age 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM Enrollments 
    WHERE course_id = (
        SELECT course_id 
        FROM Courses 
        WHERE course_name = 'Science'
    )
);

-- 10. Query to select student names and grade IDs for students enrolled in History course
SELECT student_name, student_grade_id 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM enrollments 
    WHERE course_id IN (
        SELECT course_id 
        FROM courses 
        WHERE course_name = 'History'
    )
);
