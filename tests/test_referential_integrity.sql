-- Unit tests for referential integrity rules
-- These can be run with any SQL testing framework (dbt tests, etc.)

-- Test: Check for orphaned customer references
select
    case
        when count(*) = 0 then 'PASS'
        else 'FAIL'
    end as test_result,
    count(*) as orphaned_records
from (
    select o.customer_id
    from orders o
    left join customers c on o.customer_id = c.id
    where c.id is null
) orphans;

-- Test: Verify no future-dated orders
select
    case
        when count(*) = 0 then 'PASS'
        else 'FAIL'
    end as test_result,
    count(*) as future_orders
from orders
where order_date > current_date;
