1- Selecione o nome dos clientes que é do estado RS.
SELECT name
FROM customers
WHERE state = 'RS';

2-Seu trabalho é ter os nomes e endereços dos clientes que moram em 'Porto Alegre', para entregar os convites pessoalmente.
SELECT name, street
FROM customers
WHERE city = 'Porto Alegre';

3-O setor financeiro da empresa precisa de um relatório que mostre o ID e o nome dos produtos cujo preço seja menor que 10 ou maior que 100.
SELECT id,name
FROM products
WHERE price < 10 or price > 100;

4-Seu trabalho é retornar os nomes dos produtos e fornecedores cujo ID de categoria é 6.
SELECT p.name, c.name
FROM products p, providers c
WHERE p.id_categories = 6 and p.id_providers = c.id;

5-Seu chefe precisa que você selecione o ID e o nome dos produtos, cujo nome da categoria começa com 'super'.
SELECT p.id, p.name
FROM products p, categories c
WHERE c.name LIKE 'super%' and p.id_categories = c.id;

6-Todos os meses a empresa pede um relatório das cidades que os provedores estão cadastrados. Então, faça uma consulta que retorne todas as cidades dos provedores, mas em ordem alfabética.
SELECT DISTINCT(city)
FROM providers
ORDER BY city;

7-O setor financeiro de nossa empresa, quer saber os valores menores e maiores dos produtos, que vendemos.
Para isso, você deve exibir apenas o preço mais alto e o mais baixo da tabela de produtos.
SELECT MAX(price),MIN(price)
FROM products;

8-Como de costume, o setor de vendas está fazendo uma análise de quantos produtos temos em estoque e você pode ajudá-los.
Em seguida, seu trabalho exibirá o nome e a quantidade de produtos de cada categoria.
SELECT c.name, SUM(p.amount)
FROM products p,categories c
WHERE p.id_categories = c.id
GROUP BY c.name;

9-Na empresa que você trabalha está sendo feito um levantamento sobre os valores dos produtos que são comercializados.
Para ajudar a indústria que está fazendo essa pesquisa, você deve calcular e exibir o valor médio do preço dos produtos.
OBS: Mostre o valor com dois números após o ponto.
SELECT ROUND(AVG(price),2)
FROM products;

10-Um empreiteiro de locadora de vídeo contratou seus serviços para catalogar seus filmes. Eles precisam que você selecione o código e o nome dos filmes cuja descrição do gênero é 'Ação'.
SELECT m.id, m.name
FROM movies m,genres g
WHERE g.description = 'Action' and m.id_genres = g.id;
