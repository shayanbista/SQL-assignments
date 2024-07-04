-- Create Courses table
CREATE TABLE "University".Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description VARCHAR(255)
);

-- Create Students table
CREATE TABLE "University".Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_major VARCHAR(100)
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert data into Students table
INSERT INTO "University".Students (student_id, student_name, student_major) VALUES
(1, 'Alice', 'Computer Science'),
(2, 'Bob', 'Biology'),
(3, 'Charlie', 'History'),
(4, 'Diana', 'Mathematics');

-- Insert data into Courses table
INSERT INTO "University".Courses (course_id, course_name, course_description) VALUES
(101, 'Introduction to CS', 'Basics of Computer Science'),
(102, 'Biology Basics', 'Fundamentals of Biology'),
(103, 'World History', 'Historical events and cultures'),
(104, 'Calculus I', 'Introduction to Calculus'),
(105, 'Data Structures', 'Advanced topics in CS');

-- Insert data into Enrollments table
INSERT INTO "University".Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2023-01-15'),
(2, 2, 102, '2023-01-20'),
(3, 3, 103, '2023-02-01'),
(4, 1, 105, '2023-02-05'),
(5, 4, 104, '2023-02-10'),
(6, 2, 101, '2023-02-12'),
(7, 3, 105, '2023-02-15'),
(8, 4, 101, '2023-02-20'),
(9, 1, 104, '2023-03-01'),
(10, 2, 104, '2023-03-05');


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

--
SELECT 
    student_name, 
    enrollment_date,
    ROW_NUMBER() OVER (ORDER BY enrollment_date) AS row_num
FROM 
    "University".Students
JOIN 
    "University".Enrollments ON Students.student_id = Enrollments.student_id;

--
SELECT 
    student_name, 
    RANK() OVER (ORDER BY COUNT(course_id)DESC) AS rank
FROM 
    "University".Students
JOIN 
    "University".Enrollments ON Students.student_id = Enrollments.student_id
	GROUP BY Students.student_id;

--
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count,
    DENSE_RANK() OVER (ORDER BY COUNT(e.enrollment_id) DESC) AS dense_rank
FROM
    "University".Courses c
LEFT JOIN "University".Enrollments e ON c.course_id = e.course_id
GROUP BY
    c.course_id, c.course_name
ORDER BY
    dense_rank;








