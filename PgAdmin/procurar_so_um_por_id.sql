-- FUNCTION: public.func_cliente_id(integer)

-- DROP FUNCTION IF EXISTS public.func_cliente_id(integer);

CREATE OR REPLACE FUNCTION public.func_cliente_id(
	id integer)
    RETURNS TABLE(id_cliente integer, nome_cliente text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vc.id_cliente, vc.nome_cliente
    FROM public.view_clients vc
    WHERE vc.id_cliente = id;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.func_componente_nome(
	id integer)
    RETURNS TABLE(id_componente integer, nome_comp text, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vc.id_componente, vc.nome_comp, vc.desc_comp
    FROM public.view_componentes vc
    WHERE vc.id_componente = id;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.func_equipamento_nome(
	id integer)
    RETURNS TABLE(id_equipamento integer, nome_equipamento text, tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vc.id_equipamento, vc.nome_equipamento, vc.tipo
    FROM public.view_equipamentos vc
    WHERE vc.id_equipamento = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_armazem_id(
	id integer)
    RETURNS TABLE(id_armazem integer, nome_arm text, setor text, notas text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT va.id_armazem, va.nome_arm, va.setor, va.notas
    FROM public.view_armazem va
    WHERE va.id_armazem = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_encomenda_id(
	id integer)
    RETURNS TABLE(id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT ve.id_enc, ve.nome_forn, ve.notas_enc, ve.data_enc
    FROM public.view_encomenda ve
    WHERE va.id_armazem = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_itens_remessa_id(
	id integer)
    RETURNS TABLE(id_item_remessa integer, nome_comp text, quantidade_remessa integer, nome_arm text, setor text, data_chegada timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vir.id_item_remessa, vir.nome_comp, vir.quantidade_remessa, vir.nome_arm, vir.setor, vir.data_chegada
    FROM public.view_itens_remessa vir
    WHERE va.id_item_remessa = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_itens_enc_id_com_id(
	id integer)
    RETURNS TABLE(id_item_enc integer, id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone, nome_comp text, quantidade_enc integer, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vie.id_item_enc, vie.id_enc, vie.nome_forn, vie.notas_enc, vie.data_enc, vie.nome_comp, vie.quantidade_enc, vie.desc_comp
    FROM public.view_itens_com_id vie
    WHERE vie.id_enc = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_itens_enc_id(
	id integer)
    RETURNS TABLE(id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone, nome_comp text, quantidade_enc integer, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vie.id_enc, vie.nome_forn, vie.notas_enc, vie.data_enc, vie.nome_comp, vie.quantidade_enc, vie.desc_comp
    FROM public.view_itens_encomenda vie
    WHERE vie.id_enc = id;
END;
$BODY$;

