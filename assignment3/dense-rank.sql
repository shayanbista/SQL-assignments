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
