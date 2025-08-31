SELECT skills_dim.skill_id,
       skills_dim.skill_name,
       top_skills.skill_count
FROM (
    SELECT skill_id,
           COUNT(skill_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(skill_id) DESC
    LIMIT 5
) AS top_skills
JOIN skills_dim
ON top_skills.skill_id = skills_dim.skill_id;