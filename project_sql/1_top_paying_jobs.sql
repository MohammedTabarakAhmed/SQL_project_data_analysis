/*
Question: What are the top-paying data analyst jobs?
-Identify the top 10 highest-paying Data Analyst roles that are avaliable remotly(Anywhere)
-Focuses on job postings with specified salaries (remove nulls).
-Why? Highlight the top-paying opportunities for Data Analysts, offering insights!
*/

SELECT 
    job_id,
    job_title_short, --job title in short
    job_title, -- full job name
    job_location,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN  company_dim ON job_postings_fact.company_id = company_dim.company_id --getting the name from company_dim and matching with Primary value with foriegn.
WHERE -- conditions
    job_title_short = 'Data Analyst' AND -- ' ' for string value and " " are for column names atleast in PostegreSQL.
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL --cause many places it was showing NULL.
ORDER BY
    salary_year_avg DESC
LIMIT 10;