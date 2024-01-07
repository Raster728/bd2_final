CREATE OR REPLACE FUNCTION public.func_comp_ficha_id_com_id(
	id integer)
    RETURNS TABLE(id_ficha_prod integer, nome_equipamento text, nome_comp text, quantidade_usada integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vcf.id_ficha_prod, vcf.nome_equipamento, vcf.nome_comp, vcf.quantidade_usada
    FROM public.view_componentes_por_fp vcf
    WHERE vcf.id_ficha_prod = id;
END;
$BODY$;