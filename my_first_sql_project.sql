/*
Q #1: 
*/

SELECT CASE WHEN product_name LIKE '%Vintage%' THEN 'Nike Vintage'
						ELSE 'Nike Official'
       END AS business_unit,
			 product_name,
			 (retail_price-cost) / retail_price AS profit_margin

FROM products;


/*
 Q #2: 
*/

SELECT CASE WHEN product_name LIKE '%Vintage%' THEN 'Nike Vintage'
						ELSE 'Nike Official'
       END AS business_unit,
			 product_name,
			 (retail_price-cost) / retail_price AS profit_margin

FROM products;


/*
Q #3: 
*/


SELECT 
    products.product_name,
    SUM(order_items.sale_price - products.cost) / SUM(order_items.sale_price) AS profit_margin
FROM products
LEFT JOIN order_items ON order_items.product_id = products.product_id
WHERE products.product_name IN ('Nike Pro Tights', 'Nike Dri-FIT Shorts', 'Nike Legend Tee')
GROUP BY products.product_name;


     

/*
Q #4: 
*/
SELECT 
    products.product_name,
    CASE 
        WHEN order_items.created_at < '2021-05-01' THEN 'PRE-MAY'
        ELSE 'POST-MAY'
    END AS may21_split,
    SUM(order_items.sale_price - products.cost) / SUM(order_items.sale_price) AS profit_margin
FROM order_items
FULL JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_name, may21_split
HAVING profit_margin IS NOT NULL
ORDER BY products.product_name;



/*
Q #5: 
*/

SELECT 
    products.product_name,
    SUM(order_items.sale_price - products.cost) / SUM(order_items.sale_price) AS profit_margin
FROM products
FULL JOIN order_items ON order_items.product_id = products.product_id
GROUP BY products.product_name
HAVING profit_margin IS NOT NULL

UNION ALL

SELECT 
    products.product_name,
    SUM(order_items_vintage.sale_price - products.cost) / SUM(order_items_vintage.sale_price) AS profit_margin
FROM products
FULL JOIN order_items_vintage ON order_items_vintage.product_id = products.product_id
GROUP BY products.product_name
HAVING profit_margin IS NOT NULL;



/*
Q6: 
*/
SELECT CASE WHEN product_name LIKE '%Vintage%' THEN 'Nike Vintage'
						ELSE 'Nike Official'
       END AS business_unit,
			 products.product_name,
			 (SUM(order_items.sale_price)-SUM(products.cost)) / SUM(order_items.sale_price) AS profit_margin

FROM order_items
		 LEFT JOIN products ON products.product_id = order_items.product_id
          
GROUP BY products.product_name

UNION ALL

SELECT CASE WHEN product_name LIKE '%Vintage%' THEN 'Nike Vintage'
						ELSE 'Nike Official'
       END AS business_unit,
			 products.product_name,
			 (SUM(order_items_vintage.sale_price)-SUM(products.cost)) / SUM(order_items_vintage.sale_price) AS profit_margin

FROM order_items_vintage
		 LEFT JOIN products ON products.product_id = order_items_vintage.product_id
          
GROUP BY products.product_name

ORDER BY profit_margin DESC

LIMIT 10;

