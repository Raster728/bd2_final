CREATE OR REPLACE FUNCTION public.exibir_armazem(
	)
    RETURNS TABLE(id_armazem integer, nome_arm text, setor text, notas text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_armazem;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_clients(
	)
    RETURNS TABLE(id_cliente integer, nome_cliente text, nif text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_clients;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_componentes(
	)
    RETURNS TABLE(id_componente integer, nome_comp text, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_componentes;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_componentes_por_fp(
	)
    RETURNS TABLE(id_ficha_prod integer, nome_equipamento text, nome_comp text, quantidade_usada integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_componentes_por_fp;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_encomenda(
	)
    RETURNS TABLE(id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_encomenda;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_equipamentos(
	)
    RETURNS TABLE(id_equipamento integer, nome_equipamento text, tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_equipamentos;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_equipamentos_armazenados(
	)
    RETURNS TABLE(id_eq_arm integer, nome_arm text, setor text, id_ficha_prod integer, nome_equipamento text, custo_producao money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_equipamentos_armazenados;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_fatura_and_items(
	)
    RETURNS TABLE(id_fatura_enc integer, id_item_remessa integer, nome_comp text, quantidade_remessa integer, preco_item_fatura money, preco_total_enc money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_fatura_and_items;
end;
$BODY$;



CREATE OR REPLACE FUNCTION public.exibir_fatura_encomenda(
	)
    RETURNS TABLE(id_fatura_enc integer, preco_total_enc money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_fatura_encomenda;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_fornecedores(
	)
    RETURNS TABLE(id_forn integer, nome_forn text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_fornecedores;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_guia_remessa(
	)
    RETURNS TABLE(id_guia_remessa integer, data_chegada timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_guia_remessa;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_itens_encomenda(
	)
    RETURNS TABLE(id_enc integer, nome_forn text, notas_enc text, data_enc timestamp without time zone, nome_comp text, quantidade_enc integer, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_itens_encomenda;
end;
$BODY$;


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


CREATE OR REPLACE FUNCTION public.exibir_itens_remessa(
	)
    RETURNS TABLE(id_item_remessa integer, nome_comp text, quantidade_remessa integer, nome_arm text, setor text, data_chegada timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_itens_remessa;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_mao_obra_por_fp(
	)
    RETURNS TABLE(id_ficha_prod integer, nome_equipamento text, nome_mo text, hora_inicio timestamp without time zone, hora_fim timestamp without time zone, custo_mo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_mao_obra_por_fp;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.exibir_mo(
	)
    RETURNS TABLE(id_mao_obra integer, nome_mo text, custo_mo text, tipo_mo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_mo;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.componentes_em_stock_por_comp(
	id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	quantidade integer;
begin
	select quantidade_stock into quantidade from view_componentes_em_stock vces
	where vces.id_componente = id;
	return quantidade;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.componentes_em_stock(
	)
    RETURNS TABLE(id_componente integer, quantidade_stock bigint, nome_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_componentes_em_stock;
end;
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



CREATE OR REPLACE FUNCTION public.exibir_fp(
	)
    RETURNS TABLE(id_ficha_prod integer, nome_equipamento text, tipo text, custo_producao money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_fp;
end;
$BODY$;





CREATE OR REPLACE FUNCTION public.exibir_faturas_venda(
	)
    RETURNS TABLE(id_fatura_venda integer, nome_cliente text, preco_total money, data_fatura timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query select * from view_faturas_venda;
end;
$BODY$;