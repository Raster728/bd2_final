CREATE TABLE IF NOT EXISTS public.armazem
(
    id_armazem integer NOT NULL DEFAULT nextval('armazem_id_sequence'::regclass),
    nome_arm text COLLATE pg_catalog."default",
    setor text COLLATE pg_catalog."default",
    notas text COLLATE pg_catalog."default",
    CONSTRAINT pk_armazem PRIMARY KEY (id_armazem)
)

TABLESPACE pg_default;

CREATE TABLE IF NOT EXISTS public.fornecedores
(
    id_forn integer NOT NULL DEFAULT nextval('fornecedor_id_sequence'::regclass),
    nome_forn text COLLATE pg_catalog."default",
    CONSTRAINT pk_fornecedores PRIMARY KEY (id_forn)
)

TABLESPACE pg_default;

CREATE TABLE IF NOT EXISTS public.equipamentos
(
    id_equipamento integer NOT NULL DEFAULT nextval('equipamentos_id_sequence'::regclass),
    nome_equipamento text COLLATE pg_catalog."default",
    tipo text COLLATE pg_catalog."default",
    CONSTRAINT pk_equipamentos PRIMARY KEY (id_equipamento)
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.ficha_producao
(
    id_ficha_prod integer NOT NULL DEFAULT nextval('ficha_producao_id_sequence'::regclass),
    id_equipamento integer,
    custo_producao money,
    CONSTRAINT pk_ficha_producao PRIMARY KEY (id_ficha_prod),
    CONSTRAINT fk_ficha_pr_relations_equipame FOREIGN KEY (id_equipamento)
        REFERENCES public.equipamentos (id_equipamento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.clientes
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_sequence'::regclass),
    nome_cliente text COLLATE pg_catalog."default",
    nif text COLLATE pg_catalog."default",
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente)
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.componentes
(
    id_componente integer NOT NULL DEFAULT nextval('componentes_id_sequence'::regclass),
    nome_comp text COLLATE pg_catalog."default",
    desc_comp text COLLATE pg_catalog."default",
    CONSTRAINT pk_componentes PRIMARY KEY (id_componente)
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.componentes_producao
(
    id_comp_prod integer NOT NULL DEFAULT nextval('comp_prod_id_sequence'::regclass),
    id_componente integer,
    id_ficha_prod integer,
    quantidade_usada integer,
    CONSTRAINT pk_componentes_producao PRIMARY KEY (id_comp_prod),
    CONSTRAINT fk_componen_relations_componen FOREIGN KEY (id_componente)
        REFERENCES public.componentes (id_componente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_componen_relations_ficha_pr FOREIGN KEY (id_ficha_prod)
        REFERENCES public.ficha_producao (id_ficha_prod) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;



CREATE TABLE IF NOT EXISTS public.encomenda
(
    id_enc integer NOT NULL DEFAULT nextval('encomenda_id_sequence'::regclass),
    id_forn integer,
    notas_enc text COLLATE pg_catalog."default",
    data_enc timestamp without time zone,
    CONSTRAINT pk_encomenda PRIMARY KEY (id_enc),
    CONSTRAINT fk_encomend_relations_forneced FOREIGN KEY (id_forn)
        REFERENCES public.fornecedores (id_forn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.item_enc
(
    id_item_enc integer NOT NULL DEFAULT nextval('item_enc_sequence'::regclass),
    id_enc integer,
    id_componente integer,
    quantidade_enc integer,
    CONSTRAINT pk_item_enc PRIMARY KEY (id_item_enc),
    CONSTRAINT fk_item_enc_relations_componen FOREIGN KEY (id_componente)
        REFERENCES public.componentes (id_componente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_item_enc_relations_encomend FOREIGN KEY (id_enc)
        REFERENCES public.encomenda (id_enc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.equipamnetos_arm
(
    id_eq_arm integer NOT NULL DEFAULT nextval('equipamentos_arm_id_sequence'::regclass),
    id_armazem integer,
    id_ficha_prod integer,
    CONSTRAINT pk_equipamnetos_arm PRIMARY KEY (id_eq_arm),
    CONSTRAINT fk_equipamn_relations_armazem FOREIGN KEY (id_armazem)
        REFERENCES public.armazem (id_armazem) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_equipamn_relations_ficha_pr FOREIGN KEY (id_ficha_prod)
        REFERENCES public.ficha_producao (id_ficha_prod) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.fatura_encomenda
(
    id_fatura_enc integer NOT NULL DEFAULT nextval('fatura_encomenda_id_sequence'::regclass),
    preco_total_enc money,
    CONSTRAINT pk_fatura_encomenda PRIMARY KEY (id_fatura_enc)
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.fatura_venda
(
    id_fatura_venda integer NOT NULL DEFAULT nextval('fatura_venda_id_sequence'::regclass),
    id_cliente integer,
    preco_total money,
    data_fatura timestamp without time zone,
    CONSTRAINT pk_fatura_venda PRIMARY KEY (id_fatura_venda),
    CONSTRAINT fk_fatura_v_relations_clientes FOREIGN KEY (id_cliente)
        REFERENCES public.clientes (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;




CREATE TABLE IF NOT EXISTS public.guia_remessa
(
    id_guia_remessa integer NOT NULL DEFAULT nextval('guia_remessa_id_sequence'::regclass),
    data_chegada timestamp without time zone,
    CONSTRAINT pk_guia_remessa PRIMARY KEY (id_guia_remessa)
)

TABLESPACE pg_default;

CREATE TABLE IF NOT EXISTS public.itens_remessa
(
    id_item_remessa integer NOT NULL DEFAULT nextval('item_remessa_id_sequence'::regclass),
    id_armazem integer,
    id_item_enc integer,
    id_guia_remessa integer,
    quantidade_remessa integer,
    CONSTRAINT pk_itens_remessa PRIMARY KEY (id_item_remessa),
    CONSTRAINT fk_itens_re_relations_armazem FOREIGN KEY (id_armazem)
        REFERENCES public.armazem (id_armazem) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_itens_re_relations_guia_rem FOREIGN KEY (id_guia_remessa)
        REFERENCES public.guia_remessa (id_guia_remessa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_itens_re_relations_item_enc FOREIGN KEY (id_item_enc)
        REFERENCES public.item_enc (id_item_enc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.item_fatura_enc
(
    id_item_fatura integer NOT NULL DEFAULT nextval('item_fatura_enc_id_sequence'::regclass),
    id_fatura_enc integer,
    id_item_remessa integer,
    preco_item_fatura money,
    CONSTRAINT pk_item_fatura_enc PRIMARY KEY (id_item_fatura),
    CONSTRAINT fk_item_fat_relations_fatura_e FOREIGN KEY (id_fatura_enc)
        REFERENCES public.fatura_encomenda (id_fatura_enc) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_item_fat_relations_itens_re FOREIGN KEY (id_item_remessa)
        REFERENCES public.itens_remessa (id_item_remessa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.itens_fatura_venda
(
    id_item_venda integer NOT NULL DEFAULT nextval('itens_fatura_venda_id_sequence'::regclass),
    id_fatura_venda integer,
    id_eq_arm integer,
    preco_venda money,
    CONSTRAINT pk_itens_fatura_venda PRIMARY KEY (id_item_venda),
    CONSTRAINT fk_itens_fa_relations_equipamn FOREIGN KEY (id_eq_arm)
        REFERENCES public.equipamnetos_arm (id_eq_arm) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_itens_fa_relations_fatura_v FOREIGN KEY (id_fatura_venda)
        REFERENCES public.fatura_venda (id_fatura_venda) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;



CREATE TABLE IF NOT EXISTS public.mao_obra
(
    id_mao_obra integer NOT NULL DEFAULT nextval('mao_obra_id_sequence'::regclass),
    nome_mo text COLLATE pg_catalog."default",
    custo_mo text COLLATE pg_catalog."default",
    tipo_mo text COLLATE pg_catalog."default",
    CONSTRAINT pk_mao_obra PRIMARY KEY (id_mao_obra)
)

TABLESPACE pg_default;


CREATE TABLE IF NOT EXISTS public.mo_usada
(
    id_mo_usada integer NOT NULL DEFAULT nextval('mo_usada_id_sequence'::regclass),
    id_ficha_prod integer,
    id_mao_obra integer,
    hora_inicio timestamp without time zone,
    hora_fim timestamp without time zone,
    CONSTRAINT pk_mo_usada PRIMARY KEY (id_mo_usada),
    CONSTRAINT fk_mo_usada_relations_ficha_pr FOREIGN KEY (id_ficha_prod)
        REFERENCES public.ficha_producao (id_ficha_prod) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mo_usada_relations_mao_obra FOREIGN KEY (id_mao_obra)
        REFERENCES public.mao_obra (id_mao_obra) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;
