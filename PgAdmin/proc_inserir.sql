-- PROCEDURE: public.proc_inserir_cliente(text)

-- DROP PROCEDURE IF EXISTS public.proc_inserir_cliente(text);

CREATE OR REPLACE PROCEDURE public.proc_inserir_cliente(
	IN nome text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    cliente_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.cliente_id_sequence') INTO cliente_id;
    INSERT INTO clientes (id_cliente, nome_cliente)
    VALUES (cliente_id, nome);
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_encomenda(
	IN forn integer,
	IN notas text,
	IN data_e timestamp without time zone,
	OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    encomenda_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.encomenda_id_sequence') INTO encomenda_id;
    INSERT INTO encomenda (id_enc, id_forn, notas_enc, data_enc)
    VALUES (encomenda_id, forn, notas, data_e);
    id := encomenda_id;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_equipamentos(
	IN nome text,
	IN tp text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    equipamento_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.equipamentos_id_sequence') INTO equipamento_id;
    INSERT INTO equipamentos (id_equipamento, nome_equipamento, tipo)
    VALUES (equipamento_id, nome, tp);
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_criar_guia_remessa_com_itens(
	IN id_arm integer,
	IN id_it_e integer,
	IN id_iguia_r integer,
	IN quantidade integer,
	IN quantidade_antiga integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    item_remessa_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.item_remessa_id_sequence') INTO item_remessa_id;
    INSERT INTO itens_remessa (id_item_remessa, id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
    VALUES (item_remessa_id, id_arm, id_it_e, id_iguia_r, quantidade);

	
	UPDATE item_enc
	SET quantidade_enc = quantidade_antiga - quantidade
	WHERE id_item_enc = id_it_e;
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_fornecedor(
	IN nome text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    fornecedor_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.fornecedor_id_sequence') INTO fornecedor_id;
    INSERT INTO clientes (id_forn, nome_forn)
    VALUES (fornecedor_id, nome);
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_guia_remessa(
	IN data_che timestamp without time zone,
	OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    guia_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.guia_remessa_id_sequence') INTO guia_id;
    INSERT INTO guia_remessa (id_guia_remessa, data_chegada)
    VALUES (guia_id, data_che);
	id := guia_id;
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_item_remessa(
	IN id_arm integer,
	IN id_item integer,
	IN id_guia integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    item_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.item_remessa_id_sequence') INTO item_id;
    INSERT INTO guia_remessa (id_item_remessa, id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
    VALUES (item_id, id_arm, id_item, id_guia, quantidade);
    
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_itens_encomenda(
	IN enc integer,
	IN componente integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    item_encomenda_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.item_enc_sequence') INTO item_encomenda_id;
    INSERT INTO item_enc (id_item_enc, id_enc, id_componente, quantidade_enc)
    VALUES (item_encomenda_id, enc, componente, quantidade);
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_mo_usada(
	IN ficha_prod integer,
	IN mo integer,
	IN inicio timestamp without time zone,
	IN fim timestamp without time zone)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    mo_usada_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.mo_usada_id_sequence') INTO mo_usada_id;
    INSERT INTO mo_usada (id_mo_usada, id_ficha_prod, id_mao_obra, hora_inicio, hora_fim)
    VALUES (mo_usada_id, ficha_prod, mo, inicio, fim);
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_ficha_producao(
	IN equipamento integer,
	IN custo text,
	OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    ficha_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.ficha_producao_id_sequence') INTO ficha_id;
    INSERT INTO ficha_producao (id_ficha_prod, id_equipamento, custo_producao)
    VALUES (ficha_id, equipamento, custo::money);
    id := ficha_id;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_inserir_componentes_producao(
	IN componente integer,
	IN ficha_prod integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    comp_prod_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.comp_prod_id_sequence') INTO comp_prod_id;
    INSERT INTO componentes_producao (id_comp_prod, id_componente, id_ficha_prod, quantidade_usada)
    VALUES (comp_prod_id, componente, ficha_prod, quantidade);
END;
$BODY$;
