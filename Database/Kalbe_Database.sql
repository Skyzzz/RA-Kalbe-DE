create  database kalbe;

use kalbe;

create table Inventory (
	Item_code int primary key not null,
	Item_name varchar(255) not null,
	Item_price int not null,
	Item_total int
);

insert into inventory (
	Item_code, 
	Item_name, 
	Item_price, 
	Item_total
)
values 
	(2341, "Promag Tablet", 3000, 100),
	(2342, "Hydro Coco 250ML", 7000, 20),
	(2343, "Nutrive Benecol 100ML", 20000, 30),
	(2344, "Blackmores Vit C 500Mg", 95000, 45),
	(2345, "Entrasol Gold 370G", 90000, 120);
	
select Item_name
from inventory
where Item_total = (select max(Item_total) from inventory );

update inventory 
set Item_price = 70000
where Item_name = "Entrasol Gold 370G";

insert into inventory
values (2343, "Paracetamol 500Mg", 10000, 30);

delete from inventory 
where Item_total = (select min(Item_total) from inventory);

select *
from inventory;
