-- Item a

SELECT
    s.name AS nome_school,
    st.enrolled_at,
    COUNT(*) AS total_students,
    SUM(c.price) AS total_revenue
FROM students st
JOIN courses c ON st.course_id = c.id
JOIN schools s ON c.school_id = s.id
WHERE LOWER(c.name) LIKE 'data%'
GROUP BY s.name, st.enrolled_at
ORDER BY st.enrolled_at DESC;

-- Item b

WITH base AS (
    SELECT
        s.name AS nome_school,
        st.enrolled_at,
        COUNT(*) AS total_students
    FROM students st
    JOIN courses c ON st.course_id = c.id
    JOIN schools s ON c.school_id = s.id
    WHERE LOWER(c.name) LIKE 'data%'
    GROUP BY s.name, st.enrolled_at
)

SELECT
    nome_school,
    enrolled_at,
    total_students,
    
    SUM(total_students) OVER (
        PARTITION BY nome_school
        ORDER BY enrolled_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS soma_cumulativa,

    AVG(total_students) OVER (
        PARTITION BY nome_school
        ORDER BY enrolled_at
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS media_movel_7_dias,

    AVG(total_students) OVER (
        PARTITION BY nome_school
        ORDER BY enrolled_at
        ROWS BETWEEN 30 PRECEDING AND CURRENT ROW
    ) AS media_movel_30_dias

FROM base
ORDER BY nome_school, enrolled_at DESC;

-- OBS: não foram fornecidos os dados para essa questão.