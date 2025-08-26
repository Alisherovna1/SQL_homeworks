
-- LESSON 6 : PRACTICE PUZZLES



-- Puzzle 1: Finding Distinct Values


-- Usul 1: DISTINCT ishlatish
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

-- Usul 2: GROUP BY ishlatish
SELECT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
         CASE WHEN col1 < col2 THEN col2 ELSE col1 END;



-- Puzzle 2: Removing Rows with All Zeroes


-- Faqat barcha ustunlari nol bo‘lmagan qatorlarni ko‘rsatish
SELECT *
FROM TestMultipleZero
WHERE NOT (ISNULL(A,0)=0 AND ISNULL(B,0)=0 AND ISNULL(C,0)=0 AND ISNULL(D,0)=0);



-- Puzzle 3: Find those with odd ids


SELECT * 
FROM section1
WHERE id % 2 = 1;



-- Puzzle 4: Person with the smallest id


SELECT TOP 1 *
FROM section1
ORDER BY id ASC;



-- Puzzle 5: Person with the highest id


SELECT TOP 1 *
FROM section1
ORDER BY id DESC;



-- Puzzle 6: People whose name starts with 'B'


SELECT * 
FROM section1
WHERE name LIKE 'B%';



-- Puzzle 7: Codes containing literal underscore (_)


-- ESCAPE '\' ishlatib
SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
