select *
from address;
select *
from city;
select *
from client;
select *
from comfort;
select *
from country;
select *
from employee;
select *
from hotel;
select *
from orders;
select *
from position;
select *
from room;



CREATE USER 'databaseTester'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'databaseTester'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'databaseTester'@'localhost';
# mysql -u databaseTester -p


CREATE USER 'anon'@'localhost' IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON *.* TO 'anon'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'anon'@'localhost';
# mysql -u databaseTester -p


CREATE PROCEDURE showHiltonEmployee()
BEGIN
    select name, surname, positionID
    from employee
    where positionID = (select id from hotel where hotel.name = 'Hilton');
END;


call showHiltonEmployee;


drop procedure showHiltonEmployee;


create procedure evictInhabitant(currentClientID int)
begin
    update orders
    set livingDays = 0
    where orders.clientID = currentClientID;
end;


call evictInhabitant(10);


-- logs
CREATE TABLE `log`
(
    id     INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    msg    VARCHAR(255)     NOT NULL,
    time   TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    row_id INT(11)          NOT NULL
);

DELIMITER |
CREATE TRIGGER logOrders
    AFTER UPDATE
    ON orders
    FOR EACH ROW
BEGIN
    INSERT INTO log Set msg = 'insert', row_id = NEW.id;
END;


create view names_view_who_has_order as
select id, name, surname
from client
where (select clientID from orders where clientID = client.id) = id;

select *
from names_view_who_has_order;


select  surname from names_view_who_has_order;



create view roomFacilities as
select *
from comfort;

select description
from roomFacilities;



create index connector on orders (payment);


# 0
select payment
from orders
where payment > 200;




#19
select sum(payment)
from orders;


# 2 всі описи комфортів з довжиною понад 8
select description
from comfort
where length(description) > 8;


# 3 оплата в усіх готелях
select payment, hotelID, name
from orders, hotel;


# 4 вибір всіх прибиральників 
select *
from employee
where positionID = 6;


# 5 довжина менше 10
select description
from position
where description < 10;





# 6 inner select
# замовлення де менш середнього ціна
select clientID, payment, hotelID
from orders
where payment < (select AVG(payment) from orders);


# 7 reduce  мін
select min(payment)
from orders;


# 8 reduce
select avg(population)
from country;


# 9 diapason
select name, population
from city
where population in (1000000, 50000);


# 10 комбіноване
select *
from client, orders;


# 11 комбіноване
select *
from position,comfort;


# 1 regex обрати всі готелі на 'H'
select name
from hotel
where name regexp '^h';


# 12 regex
select *
from client
where name not regexp ('GJRhjhPhVx');


# 13 reduce
select payment, inDate
from orders
where payment = (select max(payment) from orders);


# 14 reduce UP low
select UPPER(name), LOWER(surname)
from client;



# 15 group
select payment, count(*) as count
from orders
group by payment;


# 16 broup
select hotelID, count(*) as count
from employee
group by hotelID;


# 17 ordered
select *
from orders
order by inDate;


# 18 ordered
select id, description
from address
order by description desc;

# 20 union
select description
from position
union all
select description
from comfort;



