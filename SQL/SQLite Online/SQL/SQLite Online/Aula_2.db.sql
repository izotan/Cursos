-- Aula 2: Preparando dados para consultas
SELECT * from vendas limit 5;

SELECT DISTINCT(strftime('%Y',data_venda)) as Ano from vendas 
ORDER by Ano;

SELECT strftime('%Y',data_venda) as Ano, strftime('%m',data_venda) as Mês, COUNT(id_venda) as Total_vendas
from vendas
GROUP by Ano, Mês
ORDER BY Ano;

SELECT strftime('%Y',data_venda) as Ano, strftime('%m',data_venda) as Mês, COUNT(id_venda) as Total_vendas
from vendas
WHERE Mês = '01' OR Mês = '11' or Mês = '12'
GROUP by Ano, Mês
ORDER BY Ano;

