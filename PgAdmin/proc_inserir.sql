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
	IN data_e timestamp without time zone)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    encomenda_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.encomenda_id_sequence') INTO encomenda_id;
    INSERT INTO encomenda (id_enc, id_forn, notas_enc, data_enc)
    VALUES (encomenda_id, forn, notas, data_e);
    
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
