create database todo;
use todo;
create table users (
userid int unsigned not null auto_increment primary key,
fname varchar(16) not null,
sname varchar(16) not null,
date date not null,
email varchar(100) not null,
passwd char(40) not null
);
create table todos (
id int unsigned not null auto_increment primary key,
head varchar(50) not null,
body text not null,
status bool,
time_create timestamp,
time_end timestamp
);
create table link (
userid int unsigned not null,
id int unsigned not null,
primary key (userid, id)
);

grant select, insert, update, delete
	on todo.*
	to todo_user@localhost identified by 'foobar';