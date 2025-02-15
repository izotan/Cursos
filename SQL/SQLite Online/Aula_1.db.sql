-- Aula 1: Explorando as tabelas
SELECT * from categorias;
SELECT * from produtos;

SELECT COUNT(*) from produtos;
SELECT COUNT(*) as Vendas_Totais from vendas;

/* EXERCÍCIO:
Frequentemente, é necessário verificar a quantidade de registros presentes em diversas tabelas de um banco de dados.
Executar consultas individuais para cada tabela é um processo trabalhoso e não facilita a comparação direta entre os resultados obtidos.
Desenvolva uma solução que permita visualizar a quantidade de registros de várias tabelas em uma única consulta, consolidando os resultados em uma tabela única. 
Isso irá otimizar o processo de verificação e comparação, tornando-o mais eficiente e menos suscetível a erros.
*/

-- Minha solução:
SELECT COUNT(*) 
from (SELECT DISTINCT id_categoria, id_cliente, id_fornecedor, id_marca, id_produto, id_venda 
      from categorias, clientes, fornecedores, marcas, produtos, vendas);
      
/* OUTPUT:
Erro: Out of Memory
*/

-- Solução mais adequada para o exercício
SELECT COUNT(*) as Qtd, 'Categorias' as Tabela FROM categorias
UNION ALL
SELECT COUNT(*) as Qtd, 'Clientes' as Tabela FROM clientes
UNION ALL
SELECT COUNT(*) as Qtd, 'Fornecedores' as Tabela FROM fornecedores
UNION ALL
SELECT COUNT(*) as Qtd, 'ItensVenda' as Tabela FROM itens_venda
UNION ALL
SELECT COUNT(*) as Qtd, 'Marcas' as Tabela FROM marcas
UNION ALL
SELECT COUNT(*) as Qtd, 'Produtos' as Tabela FROM produtos
UNION ALL
SELECT COUNT(*) as Qtd, 'Vendas' as Tabela FROM vendas;   

/* OUTPUT:
 QTD	|	  Tabela
 5		|	Categorias
 10000	|	Clientes
 10		|	Fornecedores
 150034	|	ItensVenda
 10		|	Marcas
 10000	|	Produtos
 50000	|	Vendas
*/


/* DESAFIO:
Em bases de dados reais, é comum encontrar erros e inconsistências, especialmente em valores numéricos como preços de produtos. 
Identificar e corrigir esses erros é essencial para a validação das análises de dados.
Há uma necessidade de verificar e ajustar os preços dos produtos na base de dados, já que alguns itens apresentam valores fora 
do intervalo considerado normal ou esperado.

Tarefa:
    Análise da base de dados de produtos para identificar preços que estão fora dos intervalos especificados.
    Atualize os registros de preços para assegurar que todos estejam dentro dos limites aceitáveis.

Tabela de Intervalos de Preços Aceitáveis:
	Produto		|Preço Mínimo|	Preço Máximo
Bola de Futebol	|	  20	 |		100
Chocolate		|	  10	 |		50
Celular			|	  80	 |		5000
Livro de Ficção	|	  10	 |		200
Camisa			|	  80	 |		200
*/

-- Minha Solução
SELECT COUNT(*) as Qtd, nome_produto, MIN(preco) as preco_minimo, MAX(preco) as preco_maximo from produtos
GROUP By nome_produto; -- verificando se valores estão conforme a Tabela de Intervalos de Preços Aceitáveis

SELECT COUNT(*) as Qtd_Inaceitaveis from (SELECT id_produto, nome_produto, preco from produtos
where (nome_produto = 'Bola de Futebol' and preco < 20 or preco > 100) or 
	  (nome_produto = 'Chocolate' and preco < 10 or preco > 50) OR
      (nome_produto = 'Celular' and preco < 80 or preco > 5000) OR
      (nome_produto = 'Livro de Ficção' and preco < 10 or preco > 200) OR
      (nome_produto = 'Camisa' and preco < 80 or preco > 200)); -- verificando quantos valores que não são aceitáveis há na base de dados
/**/

-- Solução mais adequada para o desafio
SELECT id_produto, nome_produto, preco from produtos
where (nome_produto = 'Bola de Futebol' and preco < 20 or preco > 100) or 
	  (nome_produto = 'Chocolate' and preco < 10 or preco > 50) OR
      (nome_produto = 'Celular' and preco < 80 or preco > 5000) OR
      (nome_produto = 'Livro de Ficção' and preco < 10 or preco > 200) OR
      (nome_produto = 'Camisa' and preco < 80 or preco > 200);
/**/