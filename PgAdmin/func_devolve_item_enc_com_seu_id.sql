CREATE OR REPLACE FUNCTION public.exibir_itens_encomenda_com_id_item(
	)
    RETURNS TABLE(id_item_enc integer, id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone, nome_comp text, quantidade_enc integer, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_itens_encomenda;
end;
$BODY$;