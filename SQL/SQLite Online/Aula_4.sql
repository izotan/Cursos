-- Papel dos fornecedores na black friday
SELECT Ano_Mes, 
	   SUM(CASE WHEN Nome_Fornecedor == 'NebulaNetworks' then Qtd_Vendas ELSE 0 END) as Qtd_Vendas_NebulaNetworks, 
	   SUM(CASE WHEN Nome_Fornecedor == 'HorizonDistributors' then Qtd_Vendas ELSE 0 END) as Qtd_Vendas_HorizonDistributors, 
	   SUM(CASE WHEN Nome_Fornecedor == 'AstroSupply' then Qtd_Vendas ELSE 0 END) as Qtd_Vendas_AstroSupply
from(
  SELECT strftime('%Y/%m', vendas.data_venda) as Ano_Mes, fornecedores.nome as Nome_Fornecedor, Count(itens_venda.produto_id) as Qtd_Vendas
  from itens_venda
  JOIN vendas on vendas.id_venda = itens_venda.venda_id
  join produtos on produtos.id_produto = itens_venda.produto_id
  join fornecedores on fornecedores.id_fornecedor = produtos.fornecedor_id
  where Nome_Fornecedor = 'NebulaNetworks' OR Nome_Fornecedor = 'HorizonDistributors' OR Nome_Fornecedor = 'AstroSupply'
  group By Nome_Fornecedor, Ano_Mes
  ORDER By Ano_Mes
)
GROUP by Ano_Mes
 ;
 
-- Porcentagem das categorias

SELECT COUNT(itens_venda.produto_id) as Qtd_Vendas from itens_venda;

SELECT categorias.nome_categoria as Nome_Categoria, Count(itens_venda.produto_id) as Qtd_Vendas
from itens_venda
JOIN vendas on vendas.id_venda = itens_venda.venda_id
join produtos on produtos.id_produto = itens_venda.produto_id
join categorias on categorias.id_categoria = produtos.categoria_id
group By Nome_Categoria
ORDER By Qtd_Vendas;

SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0 * Qtd_Vendas / (SELECT COUNT(*) from itens_venda), 2) || '%' as '%_Vendas'
FROM(
  SELECT categorias.nome_categoria as Nome_Categoria, Count(itens_venda.produto_id) as Qtd_Vendas
  from itens_venda
  JOIN vendas on vendas.id_venda = itens_venda.venda_id
  join produtos on produtos.id_produto = itens_venda.produto_id
  join categorias on categorias.id_categoria = produtos.categoria_id
  group By Nome_Categoria
  ORDER By Qtd_Vendas
);