1.SELECT * FROM students WHERE student_id IN (select student_id FROM Enrollments WHERE course_id=(select course_id FROM courses WHERE course_name='Math'))
2.SELECT course_id,course_name FROM Courses WHERE course_id IN (SELECT course_id FROM Enrollments WHERE student_id=(SELECT student_id FROM students WHERE student_name='BOB'))
3.SELECT student_name FROM students WHERE student_id IN ( SELECT student_id FROM Enrollments GROUP BY student_id HAVING COUNT(course_id) > 1)
4. SELECT student_name FROM students WHERE student_grade_id=1
5.SELECt course_id,(SELECT course_name FROM Courses WHERE Courses.course_id=Enrollments.course_id)AS course_name, COUNT(student_id) FROM Enrollments GROUP BY course_id)
6. SELECT course_id,(SELECT course_name FROM Courses WHERE Courses.course_id=Enrollments.course_id)AS course_name, COUNT(student_id) FROM Enrollments GROUP BY course_id ORDER BY COUNT DESC LIMIT 1
7. SELECT student_id, student_name FROM students WHERE student_id IN (SELECT student_id FROM enrollments GROUP BY student_id HAVING COUNT(DISTINCT course_id) = (SELECT COUNT(DISTINCT course_id) FROM enrollments))
8.SELECT student_id, student_name FROM students WHERE student_id NOT IN (SELECT DISTINCT student_id FROM enrollments)
9.SELECT AVG(student_age) AS average_students_age FROM students_id IN (SELECT student_id FROM Enrollments WHERE course_id= (SELECT course_id FROM Courses WHERE couese_name="Science");
10.SELECT student_name,student_grade_id FROM students WHERE student_id IN (SELECT student_id FROM enrollments WHERE course_id IN (SELECT course_id FROM courses WHERE course_name = 'History'))