/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     9/30/2023 3:01:17 AM                         */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_F_RELATIONS_DATES_DI') then
    alter table ORDERS_FACT
       delete foreign key FK_ORDERS_F_RELATIONS_DATES_DI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_F_RELATIONS_PRODUCTS') then
    alter table ORDERS_FACT
       delete foreign key FK_ORDERS_F_RELATIONS_PRODUCTS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_F_RELATIONS__CUSTOME') then
    alter table ORDERS_FACT
       delete foreign key FK_ORDERS_F_RELATIONS__CUSTOME
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_F_RELATIONS_CATEGORI') then
    alter table ORDERS_FACT
       delete foreign key FK_ORDERS_F_RELATIONS_CATEGORI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_F_RELATIONS_PAYMENTS') then
    alter table ORDERS_FACT
       delete foreign key FK_ORDERS_F_RELATIONS_PAYMENTS
end if;

drop index if exists CATEGORIES_DIM.CATEGORIES_DIM_PK;

drop table if exists CATEGORIES_DIM;

drop index if exists DATES_DIM.DATES_DIM_PK;

drop table if exists DATES_DIM;

drop index if exists ORDERS_FACT.RELATIONSHIP_5_FK;

drop index if exists ORDERS_FACT.RELATIONSHIP_4_FK;

drop index if exists ORDERS_FACT.RELATIONSHIP_3_FK;

drop index if exists ORDERS_FACT.RELATIONSHIP_2_FK;

drop index if exists ORDERS_FACT.RELATIONSHIP_1_FK;

drop index if exists ORDERS_FACT.ORDERS_FACT_PK;

drop table if exists ORDERS_FACT;

drop index if exists PAYMENTS_DIM.PAYMENTS_DIM_PK;

drop table if exists PAYMENTS_DIM;

drop index if exists PRODUCTS_DIM.PRODUCTS_DIM_PK;

drop table if exists PRODUCTS_DIM;

drop index if exists _CUSTOMERS_DIM._CUSTOMERS_DIM_PK;

drop table if exists _CUSTOMERS_DIM;

/*==============================================================*/
/* Table: CATEGORIES_DIM                                        */
/*==============================================================*/
create table CATEGORIES_DIM 
(
   CATEGORYID           integer                        not null,
   CATEGORYNAME         varchar(255)                   not null,
   constraint PK_CATEGORIES_DIM primary key (CATEGORYID)
);

/*==============================================================*/
/* Index: CATEGORIES_DIM_PK                                     */
/*==============================================================*/
create unique index CATEGORIES_DIM_PK on CATEGORIES_DIM (
CATEGORYID ASC
);

/*==============================================================*/
/* Table: DATES_DIM                                             */
/*==============================================================*/
create table DATES_DIM 
(
   DATEID               integer                        not null,
   ORDERDATE            date                           not null,
   DAYOFWEEK            varchar(15)                    null,
   MONTH                varchar(15)                    null,
   YEAR                 integer                        null,
   constraint PK_DATES_DIM primary key (DATEID)
);

/*==============================================================*/
/* Index: DATES_DIM_PK                                          */
/*==============================================================*/
create unique index DATES_DIM_PK on DATES_DIM (
DATEID ASC
);

/*==============================================================*/
/* Table: ORDERS_FACT                                           */
/*==============================================================*/
create table ORDERS_FACT 
(
   ORDEID               integer                        not null,
   COSTUMERID           integer                        null,
   CATEGORYID           integer                        null,
   DATEID               integer                        null,
   PRODUCTID            integer                        null,
   PAYMENTID            integer                        null,
   ORDERDATE            date                           not null,
   QUANTITY             integer                        not null,
   constraint PK_ORDERS_FACT primary key (ORDEID)
);

/*==============================================================*/
/* Index: ORDERS_FACT_PK                                        */
/*==============================================================*/
create unique index ORDERS_FACT_PK on ORDERS_FACT (
ORDEID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on ORDERS_FACT (
DATEID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on ORDERS_FACT (
PRODUCTID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on ORDERS_FACT (
COSTUMERID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on ORDERS_FACT (
CATEGORYID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on ORDERS_FACT (
PAYMENTID ASC
);

/*==============================================================*/
/* Table: PAYMENTS_DIM                                          */
/*==============================================================*/
create table PAYMENTS_DIM 
(
   PAYMENTID            integer                        not null,
   PAYMENTDATE          date                           not null,
   PAYMENTAMOUNT        decimal(20,2)                  not null,
   PAYMENTMETHOD        varchar(50)                    null,
   constraint PK_PAYMENTS_DIM primary key (PAYMENTID)
);

/*==============================================================*/
/* Index: PAYMENTS_DIM_PK                                       */
/*==============================================================*/
create unique index PAYMENTS_DIM_PK on PAYMENTS_DIM (
PAYMENTID ASC
);

/*==============================================================*/
/* Table: PRODUCTS_DIM                                          */
/*==============================================================*/
create table PRODUCTS_DIM 
(
   PRODUCTID            integer                        not null,
   PRODUCTNAME          varchar(100)                   not null,
   PRICE                integer                        not null,
   QUANTITY             integer                        not null,
   CATEGORY             varchar(50)                    not null,
   constraint PK_PRODUCTS_DIM primary key (PRODUCTID)
);

/*==============================================================*/
/* Index: PRODUCTS_DIM_PK                                       */
/*==============================================================*/
create unique index PRODUCTS_DIM_PK on PRODUCTS_DIM (
PRODUCTID ASC
);

/*==============================================================*/
/* Table: _CUSTOMERS_DIM                                        */
/*==============================================================*/
create table _CUSTOMERS_DIM 
(
   COSTUMERID           integer                        not null,
   FIRSTNAME            varchar(255)                   not null,
   LASTNAME             varchar(255)                   null,
   EMAIL                varchar(255)                   null,
   PHONE                integer                        null,
   ADDRESS              varchar(255)                   null,
   constraint PK__CUSTOMERS_DIM primary key (COSTUMERID)
);

/*==============================================================*/
/* Index: _CUSTOMERS_DIM_PK                                     */
/*==============================================================*/
create unique index _CUSTOMERS_DIM_PK on _CUSTOMERS_DIM (
COSTUMERID ASC
);

alter table ORDERS_FACT
   add constraint FK_ORDERS_F_RELATIONS_DATES_DI foreign key (DATEID)
      references DATES_DIM (DATEID)
      on update restrict
      on delete restrict;

alter table ORDERS_FACT
   add constraint FK_ORDERS_F_RELATIONS_PRODUCTS foreign key (PRODUCTID)
      references PRODUCTS_DIM (PRODUCTID)
      on update restrict
      on delete restrict;

alter table ORDERS_FACT
   add constraint FK_ORDERS_F_RELATIONS__CUSTOME foreign key (COSTUMERID)
      references _CUSTOMERS_DIM (COSTUMERID)
      on update restrict
      on delete restrict;

alter table ORDERS_FACT
   add constraint FK_ORDERS_F_RELATIONS_CATEGORI foreign key (CATEGORYID)
      references CATEGORIES_DIM (CATEGORYID)
      on update restrict
      on delete restrict;

alter table ORDERS_FACT
   add constraint FK_ORDERS_F_RELATIONS_PAYMENTS foreign key (PAYMENTID)
      references PAYMENTS_DIM (PAYMENTID)
      on update restrict
      on delete restrict;

