create or replace function editar_equipamentos(equipamento_id int, nome_equipamento_novo text, tipo_novo text)
returns table (id_equipamento int, nome_equipamento text, tipo text)
as $$
begin
	UPDATE equipamentos
    SET 
        nome_equipamento = nome_equipamento_novo,
        tipo = tipo_novo
    WHERE equipamentos.id_equipamento = equipamento_id;	
	return query select * from view_equipamentos;
end;
$$ language plpgsql;

create or replace function editar_armazem(armazem_id int, nome_arm_novo text, setor_novo text, notas_novo text)
returns table (id_armazem int, nome_arm text, setor text, notas text)
as $$
begin
	UPDATE armazem
    SET 
        nome_arm = nome_arm_novo,
        setor = setor_novo,
		notas = notas_novo
    WHERE armazem.id_armazem = armazem_id;	
	return query select * from view_armazem;
end;
$$ language plpgsql;

create or replace function editar_clients(cliente_id int, nome_cliente_novo text)
returns table (id_cliente int, nome_cliente text)
as $$
begin
	UPDATE clientes
    SET 
        nome_cliente = nome_cliente_novo
    WHERE clientes.id_cliente = cliente_id;
	return query select * from view_clients;
end;
$$ language plpgsql;

create or replace function editar_componentes(componente_id int, nome_componente_novo text, desc_comp_novo text)
returns table (id_componente int, nome_comp text, desc_comp text)
as $$
begin
	UPDATE componentes
    SET 
        nome_comp = nome_componente_novo,
		desc_comp = desc_comp_novo
    WHERE componentes.id_componente = componente_id;
	return query select * from view_componentes;
end;
$$ language plpgsql;

create or replace function editar_ficha_producao(ficha_producao_id int, equipamento_id int, custo_producao_novo money)
returns table (id_ficha_prod int, id_equipamento int, custo_producao money)
as $$
begin
	UPDATE ficha_producao
    SET 
        custo_producao = custo_producao_novo
    WHERE ficha_producao.id_ficha_prod = ficha_producao_id AND ficha_producao.id_equipamento = equipamento_id;
	return query select * from view_ficha_producao;
end;
$$ language plpgsql;

create or replace function editar_componentes_producao(comp_prod_id int, componente_id int, ficha_prod_id int, quantidade_usada_nova int)
returns table (id_com_prod int, id_componente int, id_ficha_prod int, quantidade_usada int)
as $$
begin
	UPDATE componentes_producao
    SET 
        quantidade_usada = quantidade_usada_nova
    WHERE  componentes_producao.id_com_prod = comp_prod_id AND componentes_producao.id_ficha_prod = ficha_prod_id AND componentes_producao.id_componente = componente_id ;
	return query select * from view_componentes_producao;
end;
$$ language plpgsql;

create or replace function editar_fornecedores(forn_id int, nome_forn_novo text)
returns table (id_forn int, nome_forn text)
as $$
begin
	UPDATE fornecedores
    SET 
        nome_forn = nome_forn_novo
    WHERE  fornecedores.id_forn = forn_id
	return query select * from view_fornecedores;
end;
$$ language plpgsql;


create or replace function editar_encomenda(enc_id int, forn_id int, notas_enc_novo text)
returns table (id_enc int, id_forn int, notas_enc text)
as $$
begin
	UPDATE encomenda
    SET 
        notas_enc = notas_enc_novo
    WHERE  encomenda.id_enc = enc_id AND encomenda.id_forn = forn_id;
	return query select * from view_encomenda;
end;
$$ language plpgsql;


create or replace function editar_fatura_encomenda(fatuca_enc_id int, preco_total_enc_novo money)
returns table (id_fatura_enc int, preco_total_enc money)
as $$
begin
	UPDATE fatura_encomenda
    SET 
        preco_total_enc = preco_total_enc_novo
    WHERE  fatura_encomenda.id_fatura_enc = fatuca_enc_id;
	return query select * from view_fatura_encomenda;
end;
$$ language plpgsql;

create or replace function editar_fatura_venda(fatura_venda_id int, eq_arm_id int, cliente_id int, preco_venda_novo money, quantidade_venda_nova int)
returns table (id_fatura_venda int, id_eq_arm int, id_cliente int, preco_venda money, quantidade_venda int)
as $$
begin
	UPDATE fatura_venda
    SET 
        quantidade_venda = quantidade_venda_nova,
		preco_venda = preco_venda_novo
    WHERE  fatura_venda.id_fatura_venda = fatura_venda_id AND fatura_venda.id_eq_arm = eq_arm_id AND fatura_venda.id_cliente = cliente_id;
	return query select * from view_fatura_venda;
end;
$$ language plpgsql;

create or replace function editar_item_enc(item_enc_id int, enc_id int, componente_id int, quantidade_enc_nova int)
returns table (id_item_enc int, id_enc int, id_componente int, quantidade_enc int)
as $$
begin
	UPDATE item_enc
    SET 
        quantidade_enc = quantidade_enc_nova
    WHERE  item_enc.id_item_enc = item_enc_id AND item_enc.id_enc = enc_id AND item_enc.id_componente = componente_id;
	return query select * from view_item_enc;
end;
$$ language plpgsql;

create or replace function editar_itens_remessa(item_remessa_id int, armazem_id int, item_enc_id int, guia_remessa_id int, quantidade_remessa_nova int)
returns table (id_item_remessa int, id_armazem int, id_item_enc int, id_guia_remessa int, quantidade_remessa int)
as $$
begin
	UPDATE itens_remessa
    SET 
        quantidade_remessa = quantidade_remessa_nova
    WHERE  itens_remessa.id_item_remessa = item_remessa_id AND itens_remessa.id_armazem = armazem_id AND itens_remessa.id_item_enc = item_enc_id AND itens_remessa.id_guia_remessa = guia_remessa_id;
	return query select * from view_itens_remessa;
end;
$$ language plpgsql;

create or replace function editar_item_fatura_enc(item_fatura_id int, fatura_enc_id int, item_remessa_id int, preco_item_fatura_novo money)
returns table (id_item_fatura int, id_fatura_enc int, id_item_remessa int, preco_item_fatura money)
as $$
begin
	UPDATE item_fatura_enc
    SET 
        quantidade_remessa = preco_item_fatura_novo
    WHERE  item_fatura_enc.id_item_fatura = item_fatura_id AND item_fatura_enc.id_fatura_enc = fatura_enc_id AND item_fatura_enc.id_item_remessa = item_remessa_id;
	return query select * from view_itens_item_fatura_enc;
end;
$$ language plpgsql;

create or replace function editar_mao_obra(mao_obra_id int, nome_mo_novo text, custo_mo_novo text, tipo_mo_novo text)
returns table (id_mao_obra int, nome_mo text, custo_mo text, tipo_mo text)
as $$
begin
	UPDATE mao_obra
    SET 
        nome_mo = nome_mo_novo,
		custo_mo = custo_mo_novo,
		tipo_mo = tipo_mo_novo
    WHERE  mao_obra.id_mao_obra = mao_obra_id,
	return query select * from view_mao_obra;
end;
$$ language plpgsql;


--TIMESTAMPS
--EQUIPAMENTOS_ARM??
--GUIA_REMESSA??
--MO_USADA??
