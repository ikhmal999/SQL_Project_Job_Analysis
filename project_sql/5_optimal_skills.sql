/*
    Question : What are the most optimal skills to learn ?
    - Optimal : High Demand AND High Paying
    - Identify skills in high demand and associated with high average salaries for Data Analyst Roles
    - Concentrates on remote positions with specified salaries(NO NULL)
    - Why? Target skills that offer job security(high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis

*/

WITH demand_skill AS
(
    SELECT 
        skills,
        COUNT(job_postings_fact.job_id) AS total
    FROM job_postings_fact
    JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        (job_title_short = 'Data Analyst') AND
        (salary_year_avg IS NOT NULL) AND
        job_work_from_home IS TRUE
    GROUP BY skills
    ORDER BY total DESC
),
top_skill_highest_salary AS
(
    SELECT 
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_sal
    FROM job_postings_fact
    JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        (job_title_short = 'Data Analyst') AND
        (salary_year_avg IS NOT NULL) AND
        job_work_from_home IS TRUE
    GROUP BY skills
    ORDER BY avg_sal DESC
)
SELECT 
    demand_skill.skills,
    total,
    avg_sal
FROM demand_skill
JOIN top_skill_highest_salary
    ON demand_skill.skills = top_skill_highest_salary.skills
ORDER BY total DESC, avg_sal DESC
LIMIT 30;
