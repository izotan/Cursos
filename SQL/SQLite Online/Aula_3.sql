-- Papel dos fornecedores na Black Friday

SELECT strftime('%Y/%m', vendas.data_venda) as Ano_Mes, fornecedores.nome as Nome_Fornecedor, Count(itens_venda.produto_id) as Qtd_Vendas
from itens_venda
JOIN vendas on vendas.id_venda = itens_venda.venda_id
join produtos on produtos.id_produto = itens_venda.produto_id
join fornecedores on fornecedores.id_fornecedor = produtos.fornecedor_id
where strftime('%m', vendas.data_venda) = '11'
group By Nome_Fornecedor, Ano_Mes
ORDER By Ano_Mes;

-- Papel de produtos na Black Friday

SELECT strftime('%Y/%m', vendas.data_venda) as Ano_Mes, categorias.nome_categoria as Nome_Categoria, Count(itens_venda.produto_id) as Qtd_Vendas
from itens_venda
JOIN vendas on vendas.id_venda = itens_venda.venda_id
join produtos on produtos.id_produto = itens_venda.produto_id
join categorias on categorias.id_categoria = produtos.categoria_id
where strftime('%m', vendas.data_venda) = '11'
group By Nome_Categoria, Ano_Mes
ORDER By Nome_Categoria;

-- Extraindo base 

SELECT strftime('%Y/%m', vendas.data_venda) as Ano_Mes, fornecedores.nome as Nome_Fornecedor, Count(itens_venda.produto_id) as Qtd_Vendas
from itens_venda
JOIN vendas on vendas.id_venda = itens_venda.venda_id
join produtos on produtos.id_produto = itens_venda.produto_id
join fornecedores on fornecedores.id_fornecedor = produtos.fornecedor_id
where Nome_Fornecedor = 'NebulaNetworks'
group By Nome_Fornecedor, Ano_Mes
ORDER By Ano_Mes;
