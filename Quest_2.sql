SELECT 
    d.nome AS departamento,
    COUNT(e.matr) AS qtd_empregados,
    ROUND(COALESCE(AVG(v.valor), 0), 2) AS media_salarial,
    COALESCE(MAX(v.valor), 0) AS maior_salario,
    COALESCE(MIN(v.valor), 0) AS menor_salario
FROM departamento d
LEFT JOIN empregado e ON d.cod_dep = e.gerencia_cod_dep
LEFT JOIN vencimento v ON e.matr = e.matr
GROUP BY d.nome
ORDER BY media_salarial DESC;

