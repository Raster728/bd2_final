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
