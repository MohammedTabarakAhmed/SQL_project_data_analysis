/*
CREATE TABLES FROM OTHER TABLES
1.Create three tables
-January 2023
-February 2023
-March 2023

Hints===
    -Use (CREATE TABLE table_name AS) to create tables
    -Look at a way to filter out only specific months(EXTRACT))
*/

--January
CREATE TABLE January_2023 AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 01;

--February
CREATE TABLE February_2023 AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 02;

--March
CREATE TABLE March_2023 AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 03;

select job_posted_date
from January_2023