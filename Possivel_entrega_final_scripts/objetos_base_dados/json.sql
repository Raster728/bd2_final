CREATE OR REPLACE FUNCTION public.export_to_json(
	encomenda_id integer)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    result_json jsonb;
BEGIN
    SELECT json_agg(row_to_json(b)) INTO result_json
    FROM (SELECT * FROM view_itens_encomenda vie WHERE vie.id_enc = encomenda_id) b;

    RETURN result_json;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_importar_json(
	IN importar_componentes json)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	nome_componentes text;
	desc_componentes text;
BEGIN
	nome_componentes := importar_componentes->>'nome_componentes';
    desc_componentes := importar_componentes->>'desc_componentes';
	
    INSERT INTO componentes (nome_comp, desc_comp)
    VALUES (nome_componentes, desc_componentes);
    
END;
$BODY$;