# 📊Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top‑paying jobs, in‑demand skills, and where high demand meets high salary in data analyst. 💼📈
SQL queries? Check them out here:
[project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top‑paid and in‑demand skills—streamlining others’ work to find optimal jobs. 🚀
Data hails from my [SQL course(https://lukebarousse.com/sql)]. It’s a good SQL course, check it out! 🎓




# The question I wanted to answer through my SQL queries were:

- What are the top‑paying data analytics jobs? 💰
- What skills are required for these top‑paying jobs? 🛠️
- Which skills are most in demand for data analysts? 📊
- Which skills are associated with higher salaries? 📈
- What are the most optimal skills to learn? 


# 🛠️Tools I Used:
For my deep dive into the data job market, I harnessed the power of several key tools:
- SQL: The backbone of my analysis, allowing me to query the database and reach critical insights. 💡
- PostgreSQL: My go‑to for database management and executing SQL queries. 🐘
- Git (Version Control): Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking. 


### 1 Top paying jobs
```
SELECT 
    job_id,
    job_title_short,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN  company_dim ON job_postings_fact.company_id = company_dim.company_id 
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
     AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT 10;
 ```

### 2 Top payings job skills
```
WITH top_paying_jobs AS( --CTE
    SELECT 
    job_id,
    job_title_short,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN  company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE -- conditions
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id-- Skills with name after getting the links from top_paying_jobs
ORDER BY
    salary_year_avg
 ```

### 3 Top demanded skills
```
SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;
 ```

### 4 Top skills based on salary
```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 30;
 ```
 
### 5 Most optimal skill
```

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id, skills_dim.skills
),
average_salary AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id, skills_dim.skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 30;
 ```
 
# 📚 What I Learned

- SQL is essential for all roles.
- Cloud & big data skills boost pay.
- Visualization tools are core requirements.

# 🏁 Conclusions
Learn SQL + Python + a viz tool + cloud tech for the best mix of demand and salary. Remote roles with niche skills offer the highest rewards. 


