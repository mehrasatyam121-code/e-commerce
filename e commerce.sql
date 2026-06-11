1. Total Orders

select  count(*) as total_orders
from dbo.olist_order_items_dataset


2. Total Customers

select count(distinct customer_id) as total_customers
from dbo.olist_customers_dataset

3. Top 10 Selling Products

select top 10
product_id,count(*) as top_products
from dbo.olist_order_items_dataset
group by product_id
order by top_products desc

4. Total Revenue

select sum(price) as total_revenue
from dbo.olist_order_items_dataset

5. Orders by Status

select order_status,count(*) as total_orders
from dbo.olist_orders_dataset
group by order_status


6. Monthly Sales Trend

select year(order_purchase_timestamp)as year,
month(order_purchase_timestamp)as month,
sum(price)as revenue
from dbo.olist_orders_dataset as od
join dbo.olist_order_items_dataset as oi 
on od.order_id =oi.order_id
group by year(order_purchase_timestamp), month(order_purchase_timestamp)
order by year,month


7. Top Customers by Revenue

select top 10
customer_id,sum(price) as total_sales
from dbo.olist_orders_dataset as od
join dbo.olist_order_items_dataset as oi
on oi.order_id=od.order_id
group by customer_id
order by total_sales desc


8. Average Delivery Time

select avg(datediff(day,order_purchase_timestamp,
        order_delivered_customer_date)
    ) AS avg_delivery_days
	from dbo.olist_orders_dataset


9. Top States by Orders

select top 5
customer_state,count(*) as total_orders
from dbo.olist_customers_dataset as c
join olist_orders_dataset as o
on o.customer_id=c.customer_id
group by customer_state
order by total_orders desc


10. Highest Revenue Categories

select top 10
product_category_name,sum(price) as revenue
from dbo.olist_products_dataset as p
join dbo.olist_order_items_dataset as o
on p.product_id=o.product_id
group by product_category_name
order by revenue desc


11. Running Revenue Total

select order_purchase_timestamp,sum(price) over (order by order_purchase_timestamp)as running_revenue
from dbo.olist_orders_dataset as o
join dbo.olist_order_items_dataset as od
on o.order_id=od.order_id


12. Rank Products by Sales

select product_id,count(*) as total_sales,
rank()over (order by count(*) desc) as ranked_products
from dbo.olist_order_items_dataset
group by product_id


13. Repeat Customers

select customer_id,count(order_id) as repear_customer
from dbo.olist_orders_dataset
group by customer_id
having count(order_id)>1


