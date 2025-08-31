/*
Question: What skills are required for the top-paying data analyst jobs?
-Use the top 10 highest paying Data Analyst jpbs from first query
-Add the specific sills required for these roles
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to developp that aligh with top salaries.
*/

WITH top_paying_jobs AS( --CTE
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
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id -- Skills linked to the jobs
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id-- Skills with name after getting the links from top_paying_jobs
ORDER BY
    salary_year_avg

/*
You can copy the fileand ask chatgpt for more insights also
Can use open JSON to look at all the details
*/