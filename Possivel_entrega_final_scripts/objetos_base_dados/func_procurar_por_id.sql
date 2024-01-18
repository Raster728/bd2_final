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


CREATE OR REPLACE FUNCTION public.func_cliente_id(
	id integer)
    RETURNS TABLE(id_cliente integer, nome_cliente text, nif text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vc.id_cliente, vc.nome_cliente, vc.nif
    FROM public.view_clients vc
    WHERE vc.id_cliente = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_cliente_nif(
	n text)
    RETURNS TABLE(id_cliente integer, nome_cliente text, nif text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vc.id_cliente, vc.nome_cliente, vc.nif
    FROM public.view_clients vc
    WHERE vc.nif = n;
END;
$BODY$;

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

CREATE OR REPLACE FUNCTION public.func_equipamento_armazenado_id(
	id integer)
    RETURNS TABLE(id_eq_arm integer, nome_arm text, setor text, id_ficha_prod integer, nome_equipamento text, id_quant_eq_arm integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vea.id_eq_arm, vea.nome_arm, vea.setor, vea.id_ficha_prod, vea.nome_equipamento, vea.id_quant_eq_arm
    FROM public.view_equipamentos_armazenados vea
    WHERE vea.id_eq_arm = id;
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


CREATE OR REPLACE FUNCTION public.func_fatura_id(
	id integer)
    RETURNS TABLE(id_fatura_enc integer, preco_total_enc money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vfe.id_fatura_enc, vfe.preco_total_enc
    FROM public.view_fatura_encomenda vfe
    WHERE vfe.id_fatura_enc = id;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.func_fornecedores_id(
	id integer)
    RETURNS TABLE(id_forn integer, nome_forn text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vf.id_forn, vf.nome_forn
    FROM public.view_fornecedores vf
    WHERE vf.id_forn = id;
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


CREATE OR REPLACE FUNCTION public.func_itens_remessa_id_com_id(
	id integer)
    RETURNS TABLE(id_guia_remessa integer, id_item_remessa integer, nome_comp text, quantidade_remessa integer, nome_arm text, setor text, data_chegada timestamp without time zone, preco_item_fatura money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vir.id_guia_remessa, vir.id_item_remessa, vir.nome_comp, vir.quantidade_remessa, vir.nome_arm, vir.setor, vir.data_chegada, vir.preco_item_fatura
    FROM public.view_itens_remessa_guia_preco_por_item vir
    WHERE vir.id_guia_remessa = id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.func_mo_id(
	id integer)
    RETURNS TABLE(id_mao_obra integer, nome_mo text, custo_mo text, tipo_mo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT vmo.id_mao_obra, vmo.nome_mo, vmo.custo_mo, vmo.tipo_mo
    FROM public.view_mo vmo
    WHERE vmo.id_mao_obra = id;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.preco_equipamento(
	id integer)
    RETURNS money
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	preco_eq numeric;
	preco_mo numeric;
	preco_total numeric;
BEGIN
    
    SELECT custo_producao::numeric, custo_mo::numeric INTO preco_eq, preco_mo
	FROM equipamnetos_arm er 
		LEFT JOIN ficha_producao fp 
			ON er.id_ficha_prod = fp.id_ficha_prod
		LEFT JOIN mo_usada mu
			ON fp.id_ficha_prod = mu.id_ficha_prod
		LEFT JOIN mao_obra mo
			ON mu.id_mao_obra = mo.id_mao_obra
	WHERE er.id_eq_arm = id;
	
	preco_total = preco_eq + preco_mo;
	preco_total = preco_total * 1.15;
	
	RETURN preco_total::money;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_fatura_venda( id integer)
    RETURNS TABLE(id_fatura_venda integer, nome_cliente text, preco_total money, data_fatura timestamp without time zone, nome_equipamento text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_fatura_venda
	where view_fatura_venda.id_fatura_venda = id;
end;
$BODY$;