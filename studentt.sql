-- CREATE DATABASE education_db;
-- USE education_db;

-- -- Course Table
-- CREATE TABLE Course (
--     course_id INT PRIMARY KEY AUTO_INCREMENT,
--     course_name VARCHAR(100) NOT NULL UNIQUE,
--     duration INT,
--     fee INT
-- );

-- -- Student Table
-- CREATE TABLE Student (
--     student_id INT PRIMARY KEY AUTO_INCREMENT,
--     student_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) UNIQUE,
--     age INT,
--     gender VARCHAR(10),
--     mark INT,
--     course_id INT,
--     FOREIGN KEY (course_id) REFERENCES Course(course_id)
-- );


-- INSERT INTO Course (course_name, duration, fee)
-- VALUES
-- ('Python Full Stack', 6, 35000),
-- ('Data Analytics', 5, 30000),
-- ('Web Development', 6, 40000),
-- ('Cyber Security', 8, 45000);

-- INSERT INTO Student
-- (student_name, email, age, gender, mark, course_id)
-- VALUES
-- ('Arun', 'arun@gmail.com', 21, 'Male', 92, 1),
-- ('Anu', 'anu@gmail.com', 20, 'Female', 85, 1),
-- ('Rahul', 'rahul@gmail.com', 23, 'Male', 78, 1),
-- ('Meera', 'meera@gmail.com', 19, 'Female', 95, 2),
-- ('Vishnu', 'vishnu@gmail.com', 24, 'Male', 88, 2),
-- ('Sneha', 'sneha@gmail.com', 22, 'Female', 72, 3),
-- ('Akhil', 'akhil@gmail.com', 25, 'Male', 81, 3),
-- ('Diya', 'diya@gmail.com', 18, 'Female', 67, 3);

1. Write a query to display all students who scored more than *80 marks, ordered by mark in descending order.
SELECT *
FROM Student
WHERE mark > 80
ORDER BY mark DESC;

-- Q2. Highest, lowest, and average marks
SELECT
    MAX(mark) AS highest_mark,
    MIN(mark) AS lowest_mark,
    AVG(mark) AS average_mark
FROM Student;

-- Q3. Top 5 students based on marks
SELECT student_name, mark
FROM Student
ORDER BY mark DESC
LIMIT 5;

-- Q4. Names and marks of students aged between 18 and 25, ordered by age
SELECT student_name, mark, age
FROM Student
WHERE age BETWEEN 18 AND 25
ORDER BY age ASC;

-- Q5. Number of students in each course
SELECT c.course_name, COUNT(s.student_id) AS total_students
FROM Course c
LEFT JOIN Student s
ON c.course_id = s.course_id
GROUP BY c.course_id, c.course_name;

-- Q6. Courses that have more than 2 students
SELECT c.course_name, COUNT(s.student_id) AS total_students
FROM Course c
INNER JOIN Student s
ON c.course_id = s.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(s.student_id) > 2;

-- Q7. Student name, mark, and course name using INNER JOIN
SELECT s.student_name, s.mark, c.course_name
FROM Student s
INNER JOIN Course c
ON s.course_id = c.course_id;

-- Q8. All courses and their students, including courses with no students
SELECT c.course_name, s.student_name
FROM Course c
LEFT JOIN Student s
ON c.course_id = s.course_id;

-- Q9. Students whose marks are greater than the overall average
SELECT student_name, mark
FROM Student
WHERE mark > (
    SELECT AVG(mark)
    FROM Student
);

-- Q10. Second-highest mark with student name and course name
SELECT s.student_name, s.mark, c.course_name
FROM Student s
INNER JOIN Course c
ON s.course_id = c.course_id
WHERE s.mark = (
    SELECT MAX(mark)
    FROM Student
    WHERE mark < (
        SELECT MAX(mark)
        FROM Student
    )
);