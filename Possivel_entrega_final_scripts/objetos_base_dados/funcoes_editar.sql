CREATE OR REPLACE FUNCTION public.editar_armazem(
	armazem_id integer,
	nome_arm_novo text,
	setor_novo text,
	notas_novo text)
    RETURNS TABLE(id_armazem integer, nome_arm text, setor text, notas text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE armazem
    SET 
        nome_arm = nome_arm_novo,
        setor = setor_novo,
		notas = notas_novo
    WHERE armazem.id_armazem = armazem_id;	
	return query select * from view_armazem;
end;
$BODY$;



CREATE OR REPLACE FUNCTION public.editar_clients(
	cliente_id integer,
	nome_cliente_novo text)
    RETURNS TABLE(id_cliente integer, nome_cliente text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE clientes
    SET 
        nome_cliente = nome_cliente_novo
    WHERE clientes.id_cliente = cliente_id;
	return query select * from view_clients;
end;
$BODY$;



CREATE OR REPLACE FUNCTION public.editar_componentes(
	componente_id integer,
	nome_componente_novo text,
	desc_comp_novo text)
    RETURNS TABLE(id_componente integer, nome_comp text, desc_comp text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE componentes
    SET 
        nome_comp = nome_componente_novo,
		desc_comp = desc_comp_novo
    WHERE componentes.id_componente = componente_id;
	return query select * from view_componentes;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_componentes_producao(
	comp_prod_id integer,
	componente_id integer,
	ficha_prod_id integer,
	quantidade_usada_nova integer)
    RETURNS TABLE(id_com_prod integer, id_componente integer, id_ficha_prod integer, quantidade_usada integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE componentes_producao
    SET 
        quantidade_usada = quantidade_usada_nova
    WHERE  componentes_producao.id_com_prod = comp_prod_id AND componentes_producao.id_ficha_prod = ficha_prod_id AND componentes_producao.id_componente = componente_id ;
	return query select * from view_componentes_producao;
end;
$BODY$;



CREATE OR REPLACE FUNCTION public.editar_encomenda(
	enc_id integer,
	forn_id integer,
	notas_enc_novo text)
    RETURNS TABLE(id_enc integer, id_forn integer, notas_enc text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE encomenda
    SET 
        notas_enc = notas_enc_novo
    WHERE  encomenda.id_enc = enc_id AND encomenda.id_forn = forn_id;
	return query select * from view_encomenda;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_equipamentos(
	equipamento_id integer,
	nome_equipamento_novo text,
	tipo_novo text)
    RETURNS TABLE(id_equipamento integer, nome_equipamento text, tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE equipamentos
    SET 
        nome_equipamento = nome_equipamento_novo,
        tipo = tipo_novo
    WHERE equipamentos.id_equipamento = equipamento_id;	
	return query select * from view_equipamentos;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_fatura_encomenda(
	fatuca_enc_id integer,
	preco_total_enc_novo money)
    RETURNS TABLE(id_fatura_enc integer, preco_total_enc money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE fatura_encomenda
    SET 
        preco_total_enc = preco_total_enc_novo
    WHERE  fatura_encomenda.id_fatura_enc = fatuca_enc_id;
	return query select * from view_fatura_encomenda;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_fatura_venda(
	fatura_venda_id integer,
	eq_arm_id integer,
	cliente_id integer,
	preco_venda_novo money,
	quantidade_venda_nova integer)
    RETURNS TABLE(id_fatura_venda integer, id_eq_arm integer, id_cliente integer, preco_venda money, quantidade_venda integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE fatura_venda
    SET 
        quantidade_venda = quantidade_venda_nova,
		preco_venda = preco_venda_novo
    WHERE  fatura_venda.id_fatura_venda = fatura_venda_id AND fatura_venda.id_eq_arm = eq_arm_id AND fatura_venda.id_cliente = cliente_id;
	return query select * from view_fatura_venda;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_ficha_producao(
	ficha_producao_id integer,
	equipamento_id integer,
	custo_producao_novo money)
    RETURNS TABLE(id_ficha_prod integer, id_equipamento integer, custo_producao money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE ficha_producao
    SET 
        custo_producao = custo_producao_novo
    WHERE ficha_producao.id_ficha_prod = ficha_producao_id AND ficha_producao.id_equipamento = equipamento_id;
	return query select * from view_ficha_producao;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_fornecedores(
	forn_id integer,
	nome_forn_novo text)
    RETURNS TABLE(id_forn integer, nome_forn text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE fornecedores
    SET 
        nome_forn = nome_forn_novo
    WHERE  fornecedores.id_forn = forn_id;
	return query select * from view_fornecedores;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_item_enc(
	item_enc_id integer,
	enc_id integer,
	componente_id integer,
	quantidade_enc_nova integer)
    RETURNS TABLE(id_item_enc integer, id_enc integer, id_componente integer, quantidade_enc integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE item_enc
    SET 
        quantidade_enc = quantidade_enc_nova
    WHERE  item_enc.id_item_enc = item_enc_id AND item_enc.id_enc = enc_id AND item_enc.id_componente = componente_id;
	return query select * from view_item_enc;
end;
$BODY$;



CREATE OR REPLACE FUNCTION public.editar_item_fatura_enc(
	item_fatura_id integer,
	fatura_enc_id integer,
	item_remessa_id integer,
	preco_item_fatura_novo money)
    RETURNS TABLE(id_item_fatura integer, id_fatura_enc integer, id_item_remessa integer, preco_item_fatura money) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE item_fatura_enc
    SET 
        quantidade_remessa = preco_item_fatura_novo
    WHERE  item_fatura_enc.id_item_fatura = item_fatura_id AND item_fatura_enc.id_fatura_enc = fatura_enc_id AND item_fatura_enc.id_item_remessa = item_remessa_id;
	return query select * from view_itens_item_fatura_enc;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_itens_remessa(
	item_remessa_id integer,
	armazem_id integer,
	item_enc_id integer,
	guia_remessa_id integer,
	quantidade_remessa_nova integer)
    RETURNS TABLE(id_item_remessa integer, id_armazem integer, id_item_enc integer, id_guia_remessa integer, quantidade_remessa integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE itens_remessa
    SET 
        quantidade_remessa = quantidade_remessa_nova
    WHERE  itens_remessa.id_item_remessa = item_remessa_id AND itens_remessa.id_armazem = armazem_id AND itens_remessa.id_item_enc = item_enc_id AND itens_remessa.id_guia_remessa = guia_remessa_id;
	return query select * from view_itens_remessa;
end;
$BODY$;


CREATE OR REPLACE FUNCTION public.editar_mao_obra(
	mao_obra_id integer,
	nome_mo_novo text,
	custo_mo_novo text,
	tipo_mo_novo text)
    RETURNS TABLE(id_mao_obra integer, nome_mo text, custo_mo text, tipo_mo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	UPDATE mao_obra
    SET 
        nome_mo = nome_mo_novo,
		custo_mo = custo_mo_novo,
		tipo_mo = tipo_mo_novo
    WHERE  mao_obra.id_mao_obra = mao_obra_id;
	return query select * from view_mao_obra;
end;
$BODY$;