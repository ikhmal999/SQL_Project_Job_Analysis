/*
Question : What are the skills required for these top-paying roles?
Hint * use subquery or CTE
- Use the top 10 highest paying Data Analyst roles from first query
- Add the specific skills required for these roles
- Why ? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers 
understand which skills to develop that allign with top salaries */

WITH top_paying_job AS
(
    SELECT 
    job_id,
    job_postings_fact.company_id,
    company_dim.name,
    job_title,
    job_location,
    salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        (job_work_from_home IS TRUE) AND
        (job_title_short = 'Data Analyst') AND
        (salary_year_avg IS NOT NULL) 
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_job.*,
    skills
FROM top_paying_job
JOIN skills_job_dim
    ON top_paying_job.job_id = skills_job_dim.job_id
JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id;
