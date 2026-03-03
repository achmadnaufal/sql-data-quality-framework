-- Referential Integrity Validation Rules
-- Checks foreign key relationships and data consistency

-- Rule 1: Verify all customer IDs in orders exist in customers table
create or replace view rule_fk_customer_orders as
select
    'referential_integrity' as rule_type,
    'fk_orders.customer_id -> customers.id' as rule_name,
    count(*) as violations,
    round(count(*) * 100.0 / nullif((select count(*) from orders), 0), 2) as violation_pct,
    current_timestamp as check_timestamp
from orders o
left join customers c on o.customer_id = c.id
where c.id is null;

-- Rule 2: Verify all product IDs in order_items exist in products table
create or replace view rule_fk_product_items as
select
    'referential_integrity' as rule_type,
    'fk_order_items.product_id -> products.id' as rule_name,
    count(*) as violations,
    round(count(*) * 100.0 / nullif((select count(*) from order_items), 0), 2) as violation_pct,
    current_timestamp as check_timestamp
from order_items oi
left join products p on oi.product_id = p.id
where p.id is null;

-- Rule 3: Verify order dates are not in the future
create or replace view rule_order_dates_valid as
select
    'temporal_validity' as rule_type,
    'orders.order_date <= current_date' as rule_name,
    count(*) as violations,
    round(count(*) * 100.0 / nullif((select count(*) from orders), 0), 2) as violation_pct,
    current_timestamp as check_timestamp
from orders
where order_date > current_date;
