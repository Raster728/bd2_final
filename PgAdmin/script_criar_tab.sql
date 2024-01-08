/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     08/01/2024 22:06:13                          */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('ARMAZEM')
            and   type = 'U')
   drop table ARMAZEM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTES')
            and   type = 'U')
   drop table CLIENTES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPONENTES')
            and   type = 'U')
   drop table COMPONENTES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPONENTES_PRODUCAO')
            and   type = 'U')
   drop table COMPONENTES_PRODUCAO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ENCOMENDA')
            and   type = 'U')
   drop table ENCOMENDA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EQUIPAMENTOS')
            and   type = 'U')
   drop table EQUIPAMENTOS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EQUIPAMNETOS_ARM')
            and   type = 'U')
   drop table EQUIPAMNETOS_ARM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FATURA_ENCOMENDA')
            and   type = 'U')
   drop table FATURA_ENCOMENDA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FATURA_VENDA')
            and   type = 'U')
   drop table FATURA_VENDA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FICHA_PRODUCAO')
            and   type = 'U')
   drop table FICHA_PRODUCAO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FORNECEDORES')
            and   type = 'U')
   drop table FORNECEDORES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GUIA_REMESSA')
            and   type = 'U')
   drop table GUIA_REMESSA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ITEM_ENC')
            and   type = 'U')
   drop table ITEM_ENC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ITEM_FATURA_ENC')
            and   type = 'U')
   drop table ITEM_FATURA_ENC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ITENS_REMESSA')
            and   type = 'U')
   drop table ITENS_REMESSA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MAO_OBRA')
            and   type = 'U')
   drop table MAO_OBRA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MO_USADA')
            and   type = 'U')
   drop table MO_USADA
go

/*==============================================================*/
/* Table: ARMAZEM                                               */
/*==============================================================*/
create table ARMAZEM (
   ID_ARMAZEM           int                  not null,
   NOME_ARM             text                 null,
   SETOR                text                 null,
   NOTAS                text                 null,
   constraint PK_ARMAZEM primary key (ID_ARMAZEM)
)
go

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
   ID_CLIENTE           int                  not null,
   NOME_CLIENTE         text                 null,
   constraint PK_CLIENTES primary key (ID_CLIENTE)
)
go

/*==============================================================*/
/* Table: COMPONENTES                                           */
/*==============================================================*/
create table COMPONENTES (
   ID_COMPONENTE        int                  not null,
   NOME_COMP            text                 null,
   DESC_COMP            text                 null,
   constraint PK_COMPONENTES primary key (ID_COMPONENTE)
)
go

/*==============================================================*/
/* Table: EQUIPAMENTOS                                          */
/*==============================================================*/
create table EQUIPAMENTOS (
   ID_EQUIPAMENTO       int                  not null,
   NOME_EQUIPAMENTO     text                 null,
   TIPO                 text                 null,
   constraint PK_EQUIPAMENTOS primary key (ID_EQUIPAMENTO)
)
go

/*==============================================================*/
/* Table: FICHA_PRODUCAO                                        */
/*==============================================================*/
create table FICHA_PRODUCAO (
   ID_FICHA_PROD        int                  not null,
   ID_EQUIPAMENTO       int                  null,
   CUSTO_PRODUCAO       money                null,
   constraint PK_FICHA_PRODUCAO primary key (ID_FICHA_PROD),
   constraint FK_FICHA_PR_RELATIONS_EQUIPAME foreign key (ID_EQUIPAMENTO)
      references EQUIPAMENTOS (ID_EQUIPAMENTO)
)
go

/*==============================================================*/
/* Table: COMPONENTES_PRODUCAO                                  */
/*==============================================================*/
create table COMPONENTES_PRODUCAO (
   ID_COMP_PROD         int                  not null,
   ID_COMPONENTE        int                  null,
   ID_FICHA_PROD        int                  null,
   QUANTIDADE_USADA     int                  null,
   constraint PK_COMPONENTES_PRODUCAO primary key (ID_COMP_PROD),
   constraint FK_COMPONEN_RELATIONS_FICHA_PR foreign key (ID_FICHA_PROD)
      references FICHA_PRODUCAO (ID_FICHA_PROD),
   constraint FK_COMPONEN_RELATIONS_COMPONEN foreign key (ID_COMPONENTE)
      references COMPONENTES (ID_COMPONENTE)
)
go

/*==============================================================*/
/* Table: FORNECEDORES                                          */
/*==============================================================*/
create table FORNECEDORES (
   ID_FORN              int                  not null,
   NOME_FORN            text                 null,
   constraint PK_FORNECEDORES primary key (ID_FORN)
)
go

/*==============================================================*/
/* Table: ENCOMENDA                                             */
/*==============================================================*/
create table ENCOMENDA (
   ID_ENC               int                  not null,
   ID_FORN              int                  null,
   NOTAS_ENC            text                 null,
   DATA_ENC             datetime             null,
   constraint PK_ENCOMENDA primary key (ID_ENC),
   constraint FK_ENCOMEND_RELATIONS_FORNECED foreign key (ID_FORN)
      references FORNECEDORES (ID_FORN)
)
go

/*==============================================================*/
/* Table: EQUIPAMNETOS_ARM                                      */
/*==============================================================*/
create table EQUIPAMNETOS_ARM (
   ID_EQ_ARM            int                  not null,
   ID_ARMAZEM           int                  null,
   ID_FICHA_PROD        int                  null,
   ID_QUANT_EQ_ARM      int                  null,
   constraint PK_EQUIPAMNETOS_ARM primary key (ID_EQ_ARM),
   constraint FK_EQUIPAMN_RELATIONS_FICHA_PR foreign key (ID_FICHA_PROD)
      references FICHA_PRODUCAO (ID_FICHA_PROD),
   constraint FK_EQUIPAMN_RELATIONS_ARMAZEM foreign key (ID_ARMAZEM)
      references ARMAZEM (ID_ARMAZEM)
)
go

/*==============================================================*/
/* Table: FATURA_ENCOMENDA                                      */
/*==============================================================*/
create table FATURA_ENCOMENDA (
   ID_FATURA_ENC        int                  not null,
   PRECO_TOTAL_ENC      money                null,
   constraint PK_FATURA_ENCOMENDA primary key (ID_FATURA_ENC)
)
go

/*==============================================================*/
/* Table: FATURA_VENDA                                          */
/*==============================================================*/
create table FATURA_VENDA (
   ID_FATURA_VENDA      int                  not null,
   ID_EQ_ARM            int                  null,
   ID_CLIENTE           int                  null,
   PRECO_VENDA          money                null,
   QUANTIDAE_VENDA      int                  null,
   DATA_FATURA          datetime             null,
   constraint PK_FATURA_VENDA primary key (ID_FATURA_VENDA),
   constraint FK_FATURA_V_RELATIONS_CLIENTES foreign key (ID_CLIENTE)
      references CLIENTES (ID_CLIENTE),
   constraint FK_FATURA_V_RELATIONS_EQUIPAMN foreign key (ID_EQ_ARM)
      references EQUIPAMNETOS_ARM (ID_EQ_ARM)
)
go

/*==============================================================*/
/* Table: GUIA_REMESSA                                          */
/*==============================================================*/
create table GUIA_REMESSA (
   ID_GUIA_REMESSA      int                  not null,
   DATA_CHEGADA         datetime             null,
   constraint PK_GUIA_REMESSA primary key (ID_GUIA_REMESSA)
)
go

/*==============================================================*/
/* Table: ITEM_ENC                                              */
/*==============================================================*/
create table ITEM_ENC (
   ID_ITEM_ENC          int                  not null,
   ID_ENC               int                  null,
   ID_COMPONENTE        int                  null,
   QUANTIDADE_ENC       int                  null,
   constraint PK_ITEM_ENC primary key (ID_ITEM_ENC),
   constraint FK_ITEM_ENC_RELATIONS_COMPONEN foreign key (ID_COMPONENTE)
      references COMPONENTES (ID_COMPONENTE),
   constraint FK_ITEM_ENC_RELATIONS_ENCOMEND foreign key (ID_ENC)
      references ENCOMENDA (ID_ENC)
)
go

/*==============================================================*/
/* Table: ITENS_REMESSA                                         */
/*==============================================================*/
create table ITENS_REMESSA (
   ID_ITEM_REMESSA      int                  not null,
   ID_ARMAZEM           int                  null,
   ID_ITEM_ENC          int                  null,
   ID_GUIA_REMESSA      int                  null,
   QUANTIDADE_REMESSA   int                  null,
   constraint PK_ITENS_REMESSA primary key (ID_ITEM_REMESSA),
   constraint FK_ITENS_RE_RELATIONS_GUIA_REM foreign key (ID_GUIA_REMESSA)
      references GUIA_REMESSA (ID_GUIA_REMESSA),
   constraint FK_ITENS_RE_RELATIONS_ARMAZEM foreign key (ID_ARMAZEM)
      references ARMAZEM (ID_ARMAZEM),
   constraint FK_ITENS_RE_RELATIONS_ITEM_ENC foreign key (ID_ITEM_ENC)
      references ITEM_ENC (ID_ITEM_ENC)
)
go

/*==============================================================*/
/* Table: ITEM_FATURA_ENC                                       */
/*==============================================================*/
create table ITEM_FATURA_ENC (
   ID_ITEM_FATURA       int                  not null,
   ID_FATURA_ENC        int                  null,
   ID_ITEM_REMESSA      int                  null,
   PRECO_ITEM_FATURA    money                null,
   constraint PK_ITEM_FATURA_ENC primary key (ID_ITEM_FATURA),
   constraint FK_ITEM_FAT_RELATIONS_ITENS_RE foreign key (ID_ITEM_REMESSA)
      references ITENS_REMESSA (ID_ITEM_REMESSA),
   constraint FK_ITEM_FAT_RELATIONS_FATURA_E foreign key (ID_FATURA_ENC)
      references FATURA_ENCOMENDA (ID_FATURA_ENC)
)
go

/*==============================================================*/
/* Table: MAO_OBRA                                              */
/*==============================================================*/
create table MAO_OBRA (
   ID_MAO_OBRA          int                  not null,
   NOME_MO              text                 null,
   CUSTO_MO             text                 null,
   TIPO_MO              text                 null,
   constraint PK_MAO_OBRA primary key (ID_MAO_OBRA)
)
go

/*==============================================================*/
/* Table: MO_USADA                                              */
/*==============================================================*/
create table MO_USADA (
   ID_MO_USADA          int                  not null,
   ID_FICHA_PROD        int                  null,
   ID_MAO_OBRA          int                  null,
   HORA_INICIO          datetime             null,
   HORA_FIM             datetime             null,
   constraint PK_MO_USADA primary key (ID_MO_USADA),
   constraint FK_MO_USADA_RELATIONS_MAO_OBRA foreign key (ID_MAO_OBRA)
      references MAO_OBRA (ID_MAO_OBRA),
   constraint FK_MO_USADA_RELATIONS_FICHA_PR foreign key (ID_FICHA_PROD)
      references FICHA_PRODUCAO (ID_FICHA_PROD)
)
go

