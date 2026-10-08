create table CATEGORIES(
category_id number(10) ,
category_name varchar2(100) not null 

); 
create table MEMBERS  (
member_id number(10)  ,
full_name varchar2(50) NOT NULL ,
email varchar(60) , 
phone varchar2(11) , 
city varchar2(50)  , 
joined_on DATE DEFAULT SYSDATE,
points number(10)  default 0
) ;
create table BOOKS(
book_id number(10) ,  
title varchar2(30)  not null, 
author VARCHAR2(50) , 
category_id  number(10)  ,
price number(8,2) , 
copies_available  number(10) , 
published_year   number(10) 
); 
create table LOANS (
loan_id number(10)  , 
member_id number(10),
book_id number(10) ,
loaned_at TIMESTAMP DEFAULT SYSTIMESTAMP ,
status VARCHAR2(20) DEFAULT 'ACTIVE'
);

INSERT INTO categories VALUES (1, 'Technology');
INSERT INTO categories VALUES (2, 'Fiction');
INSERT INTO categories VALUES (3, 'History');

INSERT INTO members VALUES (1, 'Ahmed Hassan', 'ahmed.hassan@mail.com', '01012345678', 'Cairo', ADD_MONTHS(SYSDATE, -14), 250);
INSERT INTO members VALUES (2, 'Mona Ali', 'mona.ali@mail.com', '01123456789', 'Cairo', ADD_MONTHS(SYSDATE, -9), 120);
INSERT INTO members VALUES (3, 'Youssef Samir', 'youssef@gmail.com', '01234567890', 'Giza', ADD_MONTHS(SYSDATE, -3), 0);
INSERT INTO members VALUES (4, 'Amira Tarek', 'amira@mail.com', '01098765432', 'Alexandria', ADD_MONTHS(SYSDATE, -20), 80);
INSERT INTO members VALUES (5, 'Karim Nabil', 'karim@gmail.com', NULL, 'Cairo', ADD_MONTHS(SYSDATE, -7), 150);
INSERT INTO members VALUES (6, 'Sara Mahmoud', 'sara@mail.com', '01155551234', 'Giza', ADD_MONTHS(SYSDATE, -2), 400);
INSERT INTO members VALUES (7, 'Omar Fathy', 'omar@yahoo.com', '01277778888', 'Cairo', ADD_MONTHS(SYSDATE, -12), 95);
INSERT INTO members VALUES (8, 'Laila Adel', 'laila@mail.com', '01066669999', 'Mansoura', ADD_MONTHS(SYSDATE, -1), 30);

INSERT INTO books VALUES (1, 'Algorithms Made Simple', 'Omar Salem', 1, 450.00, 5, 2020);
INSERT INTO books VALUES (2, 'Ancient Egypt', 'Hana Mostafa', 3, 320.00, 3, 2018);
INSERT INTO books VALUES (3, 'Pocket SQL Guide', 'Nadia Fouad', 1, 85.00, 12, 2022);
INSERT INTO books VALUES (4, 'Spring Boot in Action', 'Tarek Hegazy', 1, 500.00, 4, 2023);
INSERT INTO books VALUES (5, 'Complete Oracle Reference', 'Mina Gerges', 1, 1250.00, 2, 2021);
INSERT INTO books VALUES (6, 'The Desert Night', 'Laila Hamdy', 2, 150.00, 0, 2015);
INSERT INTO books VALUES (7, 'Egyptian History', 'Hana Mostafa', 3, 280.00, 6, 2019);
INSERT INTO books VALUES (8, 'City of Lights', NULL, 2, 199.99, 7, 2017);
INSERT INTO books VALUES (9, 'Clean Code Basics', 'Youssef Anwar', 1, 600.00, 8, 2020);
INSERT INTO books VALUES (10, 'The Last Pharaoh', 'Amr Zaki', 3, 100.00, 1, 2016);

INSERT INTO loans (loan_id, member_id, book_id) VALUES (1, 1, 1);
INSERT INTO loans (loan_id, member_id, book_id) VALUES (2, 2, 3);
INSERT INTO loans (loan_id, member_id, book_id) VALUES (3, 3, 2);
INSERT INTO loans (loan_id, member_id, book_id) VALUES (4, 1, 4);
INSERT INTO loans (loan_id, member_id, book_id) VALUES (5, 6, 5);
INSERT INTO loans (loan_id, member_id, book_id) VALUES (6, 7, 9);

COMMIT; 


ALTER TABLE BOOKS
ADD isbn VARCHAR2(20);

ALTER TABLE LOANS
ADD returned_at TIMESTAMP;


UPDATE LOANS
SET status = 'RETURNED',
    returned_at = SYSTIMESTAMP
WHERE loan_id = 1;

UPDATE BOOKS
SET price = price * 1.10
WHERE category_id = 2;

COMMIT;

DELETE FROM BOOKS;

SELECT * FROM BOOKS;

ROLLBACK;
-- TRUNCATE is a DDL statement and performs an implicit COMMIT,
-- so its changes cannot be undone using ROLLBACK.

SELECT *
FROM MEMBERS
WHERE member_id NOT IN (
    SELECT member_id
    FROM LOANS
);


SELECT *
FROM MEMBERS;



SELECT title AS "Book Title",
       author AS "Author",
       price AS "Price"
FROM BOOKS;



SELECT DISTINCT city
FROM MEMBERS;

SELECT title,
       ROUND(price * 1.14, 2) AS price_with_vat
FROM BOOKS;


SELECT *
FROM MEMBERS
WHERE city = 'Cairo';

SELECT *
FROM MEMBERS
WHERE city = 'cairo';

-- Oracle string comparisons are case-sensitive by default,
-- so 'Cairo' and 'cairo' are treated as different values.



SELECT *
FROM BOOKS
WHERE price > 300
  AND copies_available > 0;
  
  
  -- 
SELECT *
FROM MEMBERS
WHERE city = 'Cairo'
   OR city = 'Giza'
   OR city = 'Alexandria';


-- 
SELECT *
FROM MEMBERS
WHERE city IN ('Cairo', 'Giza', 'Alexandria');

-- The IN version is cleaner and easier to read when checking
-- the same column against multiple possible values.



SELECT *
FROM BOOKS
WHERE title LIKE 'A%'
   OR title LIKE '%y';



SELECT *
FROM MEMBERS
WHERE phone IS NULL;

-- NULL represents a missing/unknown value, so it cannot be
-- compared using =. Use IS NULL to test for NULL values.



SELECT *
FROM BOOKS
ORDER BY price DESC, title ASC;



SELECT full_name AS "Member Name",
       phone AS "Phone Number",
       city AS "City",
       points AS "Points"
FROM MEMBERS
WHERE city IN ('Cairo', 'Giza')
  AND phone IS NOT NULL
ORDER BY points DESC;



SELECT full_name || ' – ' || city AS "Greeting",
       UPPER(full_name) AS "Upper Name",
       LENGTH(full_name) AS "Name Length",
       SUBSTR(email, 1, INSTR(email, '@') - 1) AS "Email Username"
FROM MEMBERS;



SELECT *
FROM MEMBERS
WHERE joined_on < ADD_MONTHS(SYSDATE, -6)
  AND points < 200;
  


-- Query 1
-- Expected: 5 rows
SELECT * FROM members
WHERE city = 'Cairo' OR city = 'Giza' AND points >= 100;


-- Query 2
-- Expected: 4 rows
SELECT * FROM members
WHERE (city = 'Cairo' OR city = 'Giza') AND points >= 100;


-- Query 3
-- Expected: 0 rows because BETWEEN 500 AND 100

SELECT * FROM books
WHERE price BETWEEN 500 AND 100;


-- Query 4
-- Expected error: ORA-00904: "PRICE_VAT": invalid identifier

SELECT title, price * 1.14 AS price_vat
FROM books
WHERE price_vat = 500;
  

