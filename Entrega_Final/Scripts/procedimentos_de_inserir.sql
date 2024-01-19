CREATE OR REPLACE PROCEDURE public.proc_criar_guia_remessa_com_itens(
	IN id_arm integer,
	IN id_it_e integer,
	IN id_iguia_r integer,
	IN quantidade integer,
	IN quantidade_antiga integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO itens_remessa (id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
    VALUES (id_arm, id_it_e, id_iguia_r, quantidade);

	
	UPDATE item_enc
	SET quantidade_enc = quantidade_antiga - quantidade
	WHERE id_item_enc = id_it_e;
    
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_inserir_cliente(
	IN nome text,
	IN n text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO clientes (nome_cliente, nif)
    VALUES (nome, n);
    
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_inserir_componentes_producao(
	IN componente integer,
	IN ficha_prod integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO componentes_producao (id_componente, id_ficha_prod, quantidade_usada)
    VALUES (componente, ficha_prod, quantidade);
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
    INSERT INTO encomenda (id_forn, notas_enc, data_enc)
    VALUES (forn, notas, data_e) RETURNING id_enc INTO encomenda_id;
	
	id := encomenda_id;
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_equipamento(
	IN nome text,
	IN tipo text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO equipamentos (nome_equipamento, tipo)
    VALUES (nome, tipo);
    
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_inserir_factura_enc(
	OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    factura_enc_id INT;
BEGIN
    INSERT INTO fatura_encomenda (preco_total_enc)
    VALUES ( 0) RETURNING id_fatura_enc INTO factura_enc_id;
	id := factura_enc_id;
    
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_fatura_venda(
    IN cliente integer,
    OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    fatura_id INT;
BEGIN
    INSERT INTO fatura_venda (id_cliente, preco_total, data_fatura)
    VALUES (cliente, 0, CURRENT_TIMESTAMP) RETURNING id_fatura_venda INTO fatura_id;
    id := fatura_id;
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_ficha_producao(
	IN equipamento integer,
	OUT id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    ficha_id INT;
BEGIN
    INSERT INTO ficha_producao (id_equipamento, custo_producao)
    VALUES (equipamento, 0) RETURNING id_ficha_prod INTO ficha_id;
    id := ficha_id;
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_fornecedor(
	IN nome text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO fornecedores (nome_forn)
    VALUES (nome);
    
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
    INSERT INTO guia_remessa (data_chegada)
    VALUES (data_che) RETURNING id_guia_remessa INTO guia_id;
    id := guia_id;
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_item_fatura(
	IN fatura integer,
	IN item_remessa integer,
	IN preco money)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    item_fatura_id INT;
BEGIN
    -- Insert a new record into the table
	SELECT nextval('public.item_fatura_enc_id_sequence') INTO item_fatura_id;
    INSERT INTO item_fatura_enc (id_fatura_enc, id_item_remessa, preco_item_fatura)
    VALUES (fatura, item_remessa, preco::money);
    
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_item_remessa(
	IN id_arm integer,
	IN id_item integer,
	IN id_guia integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO guia_remessa (id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
    VALUES (id_arm, id_item, id_guia, quantidade);
    
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_itens_encomenda(
	IN enc integer,
	IN componente integer,
	IN quantidade integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO item_enc (id_enc, id_componente, quantidade_enc)
    VALUES (enc, componente, quantidade);
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.proc_inserir_itens_fatura_venda(
	IN fatura integer,
	IN equipamento integer,
	IN preco text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO itens_fatura_venda (id_fatura_venda, id_eq_arm, preco_venda)
    VALUES (fatura, equipamento, preco::money);
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_inserir_mo_usada(
	IN ficha_prod integer,
	IN mo integer,
	IN inicio timestamp without time zone,
	IN fim timestamp without time zone)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO mo_usada (id_ficha_prod, id_mao_obra, hora_inicio, hora_fim)
    VALUES (ficha_prod, mo, inicio, fim);
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_inserir_equipamento_armazenado(
	IN armazem integer,
	IN ficha_prod integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO equipamnetos_arm (id_armazem, id_ficha_prod, estado)
    VALUES (armazem, ficha_prod, 'nao');
    
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.proc_inserir_componentes(
	IN componente text,
	IN descricao text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO componentes (nome_comp, desc_comp)
    VALUES (componente, descricao);
END;
$BODY$;