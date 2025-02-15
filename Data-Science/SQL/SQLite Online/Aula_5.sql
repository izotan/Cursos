-- Quadro Geral

SELECT strftime('%Y/%m', data_venda) AS Ano_Mes, COUNT(*) AS Qtd_Vendas
FROM Vendas
GROUP BY Ano_Mes
ORDER BY Ano_Mes
;

SELECT Mes,
SUM(CASE WHEN Ano=='2020' THEN Qtd_Vendas ELSE 0 END) AS '2020',
SUM(CASE WHEN Ano=='2021' THEN Qtd_Vendas ELSE 0 END) AS '2021',
SUM(CASE WHEN Ano=='2022' THEN Qtd_Vendas ELSE 0 END) AS '2022',
SUM(CASE WHEN Ano=='2023' THEN Qtd_Vendas ELSE 0 END) AS '2023'
FROM(
    SELECT strftime('%m', data_venda) AS Mes, strftime('%Y', data_venda) AS Ano, COUNT(*) AS Qtd_Vendas
    FROM Vendas
    GROUP BY Mes, Ano
    ORDER BY Mes
    )
GROUP BY Mes
;


-- Métrica

SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', data_venda) as Ano
FROM vendas
WHERE strftime('%m', data_venda) = '11' and Ano != '2022'
group by Ano
;

SELECT AVG(Qtd_Vendas) as Media_Qtd_Vendas
from(
  SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', data_venda) as Ano
  FROM vendas
  WHERE strftime('%m', data_venda) = '11' and Ano != '2022'
  group by Ano
  )
;

SELECT COUNT(*) AS Qtd_Vendas_Atual
FROM vendas
WHERE strftime('%m', data_venda) = '11' and strftime('%Y', data_venda) = '2022';

WITH Media_Vendas_Anteriores as (
      SELECT AVG(Qtd_Vendas) as Media_Qtd_Vendas
      from(
          SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', data_venda) as Ano
          FROM vendas
          WHERE strftime('%m', data_venda) = '11' and Ano != '2022'
          group by Ano
          )
	), 
    Vendas_Atual as (
      SELECT COUNT(*) AS Qtd_Vendas_Atual
      FROM vendas
      WHERE strftime('%m', data_venda) = '11' and strftime('%Y', data_venda) = '2022'
    )
    SELECT Media_Qtd_Vendas,
    	   Qtd_Vendas_Atual,
           ROUND(100.0*(Qtd_Vendas_Atual/Media_Qtd_Vendas - 1),2) || '%' as '% Comparacao_Resultado'
    from Media_Vendas_Anteriores, Vendas_Atual
    ;