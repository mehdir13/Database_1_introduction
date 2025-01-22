-- 1. Create the 'students' table
CREATE TABLE students (
    email TEXT PRIMARY KEY, -- Primary key to uniquely identify each student (email as the unique identifier)
    name TEXT      -- Name of the student
);

-- 2. Create the 'courses' table
CREATE TABLE courses (
    code TEXT PRIMARY KEY, -- Primary key for the course code
    name TEXT, -- Name of the course
    yh_points NUMERIC -- Points for the course
);

-- 3. Create the 'grades' table
CREATE TABLE grades (
    student TEXT,            -- Reference to the student's email
    course TEXT,             -- Reference to the course code
    grade TEXT,     -- Grade earned in the course
    PRIMARY KEY (student, course), -- Composite primary key: one grade per student per course
    FOREIGN KEY (student) REFERENCES students(email), -- Foreign key linking to students
    FOREIGN KEY (course) REFERENCES courses(code)    -- Foreign key linking to courses
);

-- 4. Insert sample data into 'students'
INSERT INTO students (email, name) VALUES
('alice@example.com', 'Alice Johnson'),
('bob@example.com', 'Bob Smith');

-- 5. Insert sample data into 'courses'
INSERT INTO courses (code, name, yh_points) VALUES
('DEV23M_PP', 'Pythonprogrammering', 7.5),
('FRK22G_WK', 'Webbkommunikation', 6.0);

-- 6. Insert sample data into 'grades'
INSERT INTO grades (student, course, grade) VALUES
('alice@example.com', 'DEV23M_PP', 'A'),
('bob@example.com', 'FRK22G_WK', 'B');

-- 7. Attempt to insert a grade for a non-existent student (should fail)
INSERT INTO grades (student, course, grade) VALUES
('charlie@example.com', 'DEV23M_PP', 'C'); -- This will fail because 'charlie@example.com' is not in 'students'

-- 8. Attempt to insert a grade for a non-existent course (should fail)
INSERT INTO grades (student, course, grade) VALUES
('alice@example.com', 'HIST101', 'A'); -- This will fail because 'HIST101' is not in 'courses'

/*
    students(_email_, name)
    courses(_code_, name, yh_points)
    grades(_student_, _course_, grade)
        student --> students.email
        course --> courses.code
    I grades finns det två primary keys då en student kan ha flera betyg.
    Men bara ett betyg i en kurs.
    1. CREATE TABLE
    2. sätt in värden med INSERT INTO
    3. DROP TABLE users
    4. PRIMARY KEY
    5. SELECT *
    6. FOREIGN KEY
*/