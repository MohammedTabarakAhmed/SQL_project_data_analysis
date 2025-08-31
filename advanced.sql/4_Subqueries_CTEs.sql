-- SubQueries

SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN(-- start of SubQuerying
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
);

-- CTEs
/*
Find the companies that have the most jobs openings.
    -Get the total number of job openings per company_id(job_postings_fact)
    -Return the total number of jobs with the company_name(company_dim)
*/
WITH company_job_count AS (
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN company_job_count
    ON company_job_count.company_id = company_dim.company_id;