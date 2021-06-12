/*
                                                         Tarefa: Desafios de SQL 2


1 - retorne a quantidade de itens vendidos em cada categoria por estado em que o cliente se encontra, 
mostrando somente categorias que tenham vendido uma quantidade de items acima de 1000.			
*/

SELECT
prod.product_category_name as categoria_produto,
customer_state,
count(1) as quantidade_itens_vendidos
FROM olist_products_dataset as prod
LEFT JOIN olist_order_items_dataset as it
on prod.product_id = it.product_id
LEFT JOIN olist_orders_dataset as ord
on it.order_id = ord.order_id 
LEFT JOIN olist_customers_dataset as cust
on ord.customer_id = cust.customer_id
group by prod.product_category_name, cust.customer_state
HAVING quantidade_itens_vendidos > 1000
order by 1, 3 DESC;
	

/*
2 - mostre os 5 clientes (customer_id) que gastaram mais dinheiro em compras, qual foi o valor total de todas as compras deles, quantidade de compras, e valor médio gasto por compras. 
Ordene os mesmos por ordem decrescente pela média do valor de compra.	
*/

SELECT
cust.customer_id,
count (1) as qtd_compras,
sum (pay.payment_value) as soma_pagamentos,
avg (pay.payment_value) as media_por_compras
FROM olist_order_payments_dataset as pay
LEFT JOIN olist_orders_dataset as ord
on pay.order_id = ord.order_id
LEFT JOIN olist_customers_dataset as cust
on ord.customer_id = cust.customer_id
group by cust.customer_id 
order by 4 DESC
LIMIT 5;	

/*
3 - mostre o valor vendido total de cada vendedor (seller_id) em cada uma das categorias de produtos, somente retornando os vendedores que nesse somatório e agrupamento venderam mais de $1000. 
Desejamos ver a categoria do produto e os vendedores. 
Para cada uma dessas categorias, mostre seus valores de venda de forma decrescente.		
*/

SELECT 
it.seller_id,
prod.product_category_name,
sum (it.price) as soma_vendidos
FROM olist_order_items_dataset as it
JOIN olist_products_dataset as prod 
on it.product_id = prod.product_id
group by it.seller_id, product_category_name
HAVING sum (it.price) > 1000
order by 3 DESC, 2 DESC, 1 DESC;		


		 