/*

Question : What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings
- Why? Retrieve the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers */

WITH CTE1 AS 
(
    SELECT 
        skill_id,
        COUNT(*) AS total
    FROM job_postings_fact
    JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT 
    CTE1.*,
    skills
FROM CTE1
JOIN skills_dim
    ON CTE1.skill_id = skills_dim.skill_id
ORDER BY total DESC
LIMIT 10;

-- Much more simple query


SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS total
FROM job_postings_fact
JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY total DESC
LIMIT 10;