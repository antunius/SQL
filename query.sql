drop table if exists funcionario cascade;

drop table if exists departamento cascade;

drop table if exists projeto cascade;

drop table if exists dependente cascade;

drop table if exists trabalhapj cascade;



create table funcionario
(

    CPF            integer,

    Datanasc       date,

    salario        decimal(10, 2),

    generio        char,

    pnome          varchar(10),

    Mnome          varchar(10),

    Sobrenome      varchar(10),

    CPF_supervisor integer,

    dep_nome       varchar(10),

    dep_numero     integer,

    constraint pk_func primary key (CPF),

    constraint fk_superv foreign key (CPF_supervisor) references funcionario (CPF) on delete cascade on update cascade

);



create table departamento
(

    nome        varchar(10),

    numero      integer,

    nro_func    integer,

    cpf_gerente integer,

    constraint pk_dep primary key (nome, numero),

    constraint fk_gerente foreign key (cpf_gerente) references funcionario (CPF) on delete cascade on update cascade

);



alter table funcionario
    add constraint fk_dep foreign key (dep_nome, dep_numero) references departamento (nome, numero);



create table projeto
(

    nome        varchar(10),

    numero      integer,

    localizacao varchar(30),

    dep_nome    varchar(10),

    dep_numero  integer,

    constraint pk_proj primary key (nome, numero),

    constraint fk_dep foreign key (dep_nome, dep_numero) references departamento (nome, numero)

);



create table dependente
(

    nome       varchar(10),

    CPF_func   integer,

    genero     char,

    datanasc   date,

    parentesco varchar(10),

    constraint pk_depend primary key (CPF_func, nome),

    constraint fk_depend foreign key (CPF_func) references funcionario (CPF) on update cascade on delete cascade

);



create table trabalhapj
(

    CPF_func    integer,

    proj_nome   varchar(10),

    proj_numero integer,

    horas       integer,

    constraint pk_trab primary key (cpf_func, proj_nome, proj_numero),

    constraint fk_cpf_trabpj foreign key (CPF_func) references funcionario (CPF),

    constraint fk_idproj_trabpj foreign key (proj_nome, proj_numero) references projeto (nome, numero)

);



insert into departamento
values ('criacao', 1, 0, NULL);

insert into departamento
values ('desenvolv', 1, 0, NULL);

insert into departamento
values ('desenvolv', 2, 0, NULL);

insert into departamento
values ('financas', 1, 0, NULL);

insert into departamento
values ('rh', 1, 0, NULL);

insert into departamento
values ('marketing', 1, 0, NULL);

--select * from departamento;


insert into funcionario
values (3244, to_date('22-06-1990', 'DD-MM-YYYY'), 5000, 'M', 'Joao', 'Pedro', 'Silva', NULL, 'criacao', 1);

insert into funcionario
values (3252, to_date('16-05-1985', 'DD-MM-YYYY'), 2200, 'F', 'Lucilia', 'Soares', 'Porto', 3244, 'criacao', 1);

insert into funcionario
values (3246, to_date('12-08-1992', 'DD-MM-YYYY'), 3100, 'F', 'Maria', 'Ramos', 'Dorio', NULL, 'desenvolv', 1);

insert into funcionario
values (3245, to_date('23-07-1991', 'DD-MM-YYYY'), 4300, 'M', 'Pedro', 'Augusto', 'Nefer', 3246, 'desenvolv', 1);

insert into funcionario
values (3247, to_date('13-09-1993', 'DD-MM-YYYY'), 2600, 'M', 'Joaquim', 'Lico', 'Martins', 3246, 'desenvolv', 1);

insert into funcionario
values (3248, to_date('05-01-1994', 'DD-MM-YYYY'), 4100, 'F', 'Josefa', 'Carla', 'da Silva', 3246, 'desenvolv', 2);

insert into funcionario
values (3249, to_date('13-02-1988', 'DD-MM-YYYY'), 3100, 'M', 'Lucas', 'Augusto', 'Santos', 3246, 'desenvolv', 2);

insert into funcionario
values (3250, to_date('14-03-1978', 'DD-MM-YYYY'), 4300, 'F', 'Patricia', 'Maria', 'Nessa', NULL, 'financas', 1);

insert into funcionario
values (3251, to_date('15-04-1987', 'DD-MM-YYYY'), 3800, 'M', 'Carlos', 'Juca', 'Lori', 3250, 'financas', 1);

insert into funcionario
values (3253, to_date('16-06-1984', 'DD-MM-YYYY'), 3600, 'M', 'Jorge', 'Tibiri', 'Junior', NULL, 'rh', 1);

insert into funcionario
values (3254, to_date('17-07-1983', 'DD-MM-YYYY'), 2700, 'F', 'Carla', 'Rodrigues', 'Santos', 3253, 'rh', 1);

insert into funcionario
values (3255, to_date('19-08-1982', 'DD-MM-YYYY'), 2600, 'M', 'Julio', 'Borges', 'Silva', NULL, 'marketing', 1);

insert into funcionario
values (3256, to_date('21-09-1981', 'DD-MM-YYYY'), 3200, 'M', 'Cesar', 'Boro', 'Barbosa', 3255, 'marketing', 1);

--select * from funcionario;


--inserindo dependentes

insert into dependente
values ('Beatriz', 3252, 'F', to_date('16-05-2015', 'DD-MM-YYYY'), 'Filha');

insert into dependente
values ('Lizangela', 3245, 'F', to_date('23-07-2006', 'DD-MM-YYYY'), 'Filha');

insert into dependente
values ('Rafael', 3247, 'M', to_date('13-09-2007', 'DD-MM-YYYY'), 'Filho');

insert into dependente
values ('Juca', 3250, 'M', to_date('14-03-2008', 'DD-MM-YYYY'), 'Filho');

insert into dependente
values ('Pietro', 3254, 'M', to_date('17-07-2008', 'DD-MM-YYYY'), 'Filho');

insert into dependente
values ('Lucca', 3255, 'M', to_date('19-08-2010', 'DD-MM-YYYY'), 'Filho');


--Ajustando gerentes

update departamento
set cpf_gerente = 3244
where nome = 'criacao'
  and numero = 1;

update departamento
set cpf_gerente = 3246
where nome = 'desenvolv'
  and numero = 1;

update departamento
set cpf_gerente = 3248
where nome = 'desenvolv'
  and numero = 2;

update departamento
set cpf_gerente = 3250
where nome = 'financas'
  and numero = 1;

update departamento
set cpf_gerente = 3253
where nome = 'rh'
  and numero = 1;

update departamento
set cpf_gerente = 3255
where nome = 'marketing'
  and numero = 1;



UPDATE departamento

SET nro_func =(
    SELECT count(*)

    FROM funcionario

    WHERE funcionario.dep_nome = departamento.nome
      and funcionario.dep_numero = departamento.numero
);


--Criacao de projetos

insert into projeto
values ('NOVOSIST', 1, 'Sala de Criacao', 'criacao', 1);

insert into projeto
values ('UNICPD', 1, 'Laboratorio Desenv', 'desenvolv', 1);

insert into projeto
values ('EngRest', 1, 'Laboratorio Desenv', 'desenvolv', 1);

insert into projeto
values ('EngRest', 2, 'Laboratorio Desenv', 'desenvolv', 2);

--select * from projeto


--Alocar funcionarios para trabalharem em projetos

insert into trabalhapj
values (3244, 'NOVOSIST', 1, 30);

insert into trabalhapj
values (3252, 'NOVOSIST', 1, 40);

insert into trabalhapj
values (3246, 'UNICPD', 1, 40);

insert into trabalhapj
values (3245, 'UNICPD', 1, 40);

insert into trabalhapj
values (3247, 'UNICPD', 1, 20);

insert into trabalhapj
values (3248, 'UNICPD', 1, 20);

insert into trabalhapj
values (3249, 'UNICPD', 1, 20);

insert into trabalhapj
values (3247, 'EngRest', 1, 20);

insert into trabalhapj
values (3248, 'EngRest', 1, 20);

insert into trabalhapj
values (3249, 'EngRest', 2, 20);

/*1 Selecione o primeiro nome e o sobrenome de todos os funcionários.*/
select f.pnome, f.sobrenome
from funcionario f;

/*2 Selecione os nomes dos funcionários supervisionados, indicando o
nome do supervisor de cada um.*/
select f.pnome as funcionario, s.pnome as supervisor
from funcionario f
         inner join funcionario s on s.CPF = f.CPF_supervisor;

/*3 Selecione os nomes dos funcionarios que possuam dependentes,
listando em ordem alfabética os nomes dos funcionarios e o nome dos
dependentes.*/
select f.pnome as funcionario, d.nome as dependente
from funcionario f
         inner join dependente d on f.CPF = d.CPF_func
order by pnome;

/*4 Selecione os nomes de todos funcionários em ordem alfabética,
indicando o nome dos dependentes se houver.*/
select f.pnome, d.nome
from funcionario f
         LEFT JOIN dependente d ON f.CPF = d.CPF_func
order by pnome;

/*5 Selecione os nomes dos funcionários e os nomes dos departamentos
que eles trabalham.*/
select f.pnome, f.dep_nome
from funcionario f
order by dep_nome;

/*6 Selecione os nomes dos funcionários que gerenciam algum
departamento, indicando o nome e o numero do departamento
gerenciado.*/

select f.pnome, f.dep_nome, d.numero
from funcionario f
         INNER JOIN departamento d on f.CPF = d.cpf_gerente;

/*7 Selecione o nome e o número dos projetos, indicando quais
departamentos gerenciam cada projeto.*/
select p.nome, p.numero, d.nome, d.numero
from projeto p
         inner join departamento d on p.dep_nome = d.nome and p.dep_numero = d.numero;


/*8 Para cada projeto, indicar quantos funcionários trabalham nele.*/
select p.nome, count(f.pnome)
from projeto p
         inner join funcionario f on p.dep_nome = f.dep_nome
group by p.nome;

/*9 Selecione os nomes dos funcionários que trabalham em algum projeto.*/
select f.pnome
from funcionario f
         inner join trabalhapj t on f.CPF = t.CPF_func;

/*10 Selecione os nomes dos funcionários que trabalham em algum projeto,
indicando o nome do projeto e o número de horas trabalhadas em
cada.*/
select f.pnome, p.nome, t.horas
from funcionario f
         inner join trabalhapj t on f.CPF = t.CPF_func
         inner join projeto p on t.proj_nome = p.nome and t.proj_numero = p.numero;

/*11 Selecione os nomes dos funcionários que trabalham em algum projeto,
indicando o total de horas trabalhadas.*/
select f.pnome, sum(t.horas)
from funcionario f
         inner join trabalhapj t on f.CPF = t.CPF_func
group by f.pnome;


/*12 Selecione os nomes dos funcionários que trabalham em algum projeto,
indicando o número de projetos que trabalham.*/
select f.pnome, count(p.numero)
from funcionario f
         inner join trabalhapj t on f.CPF = t.CPF_func
         inner join projeto p on t.proj_nome = p.nome and t.proj_numero = p.numero
group by f.pnome;

/*Desafio Selecione os nomes dos funcionários que trabalham em mais que um
projeto*/
select f.pnome
from funcionario f
         inner join trabalhapj t on f.CPF = t.CPF_func
         inner join projeto p on t.proj_nome = p.nome and t.proj_numero = p.numero
group by f.pnome
having count(p.numero) > 1;

/*Desafio Selecione os supervisores que trabalham em algum projeto, indicando
o nome do projeto.*/
select f.pnome, p.nome
from funcionario f
         inner join funcionario s on f.CPF = s.CPF_supervisor
         inner join trabalhapj t on f.CPF = t.CPF_func
         inner join projeto p on t.proj_nome = p.nome and t.proj_numero = p.numero
group by f.pnome, p.nome;
