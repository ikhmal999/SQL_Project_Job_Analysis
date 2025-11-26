/*

Question : What are the top skills based on salary ?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on role with specified salaries (NO NULL), regardless of location
- Why ? It reveals how different skill impact salary level of Data Analysts and helps 
identify the most financially rewarding skills to acquire or improve

*/

    SELECT 
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_sal
    FROM job_postings_fact
    JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY skills
    ORDER BY avg_sal DESC
    LIMIT 30;

