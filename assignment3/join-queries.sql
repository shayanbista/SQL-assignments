--Inner join
SELECT *
FROM "University".Students s
JOIN "University".Enrollments e ON s.student_id = e.student_id
JOIN "University".Courses c ON e.course_id=c.course_id;

--Left join 
SELECT s.student_id, s.student_name, e.course_id, c.course_name
FROM "University".Students s
LEFT JOIN "University".Enrollments e ON s.student_id = e.student_id
LEFT JOIN "University".Courses c ON e.course_id = c.course_id;

--Right join 
SELECT s.student_id, s.student_name, e.course_id, c.course_name
FROM "University".Students s
RIGHT JOIN "University".Enrollments e ON s.student_id = e.student_id
RIGHT JOIN "University".Courses c ON e.course_id = c.course_id;

--self join
SELECT 
    s1.student_name AS student1, 
    s2.student_name AS student2, 
    c.course_name 
FROM 
    "University".Enrollments e1
INNER JOIN 
    "University".Enrollments e2 
    ON e1.course_id = e2.course_id AND e1.student_id <> e2.student_id
INNER JOIN 
    "University".Students s1 
    ON e1.student_id = s1.student_id
INNER JOIN 
    "University".Students s2 
    ON e2.student_id = s2.student_id
INNER JOIN 
    "University".Courses c 
    ON e1.course_id = c.course_id;

--complex join
SELECT DISTINCT s.student_name
FROM "University".Students s
INNER JOIN  "University".Enrollments e1 ON s.student_id = e1.student_id
INNER JOIN "University".Courses c1 ON e1.course_id = c1.course_id
LEFT JOIN "University".Enrollments e2 ON s.student_id = e2.student_id
LEFT JOIN "University".Courses c2 ON e2.course_id = c2.course_id AND c2.course_name = 'Data Structures'
WHERE c1.course_name = 'Introduction to CS'
  AND c2.course_id IS NULL;


