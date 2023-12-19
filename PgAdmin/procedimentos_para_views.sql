create or replace function exibir_armazem()
returns table (id_armazem int, nome_arm text, setor text, notas text)
as $$
begin
	return query select * from view_armazem;
end;
$$ language plpgsql;

create or replace function exibir_clients()
returns table (id_cliente int, nome_cliente text)
as $$
begin
	return query select * from view_clients;
end;
$$ language plpgsql;

create or replace function exibir_componentes()
returns table (id_componente int, nome_comp text, desc_comp text)
as $$
begin
	return query select * from view_componentes;
end;
$$ language plpgsql;

create or replace function exibir_componentes_por_fp()
returns table (id_ficha_prod int, nome_equipamento text, nome_comp text, quantidade_usada int)
as $$
begin
	return query select * from view_componentes_por_fp;
end;
$$ language plpgsql;

create or replace function exibir_encomenda()
returns table (id_enc int, nome_forn text, notas_enc text, data_enc timestamp)
as $$
begin
	return query select * from view_encomenda;
end;
$$ language plpgsql;

create or replace function exibir_equipamentos()
returns table (id_equipamento int, nome_equipamento text, tipo text)
as $$
begin
	return query select * from view_equipamentos;
end;
$$ language plpgsql;

create or replace function exibir_equipamentos_armazenados()
returns table (id_eq_arm int, nome_arm text, setor text, id_ficha_prod int, nome_equipamento text, id_quant_eq_arm int)
as $$
begin
	return query select * from view_equipamentos_armazenados;
end;
$$ language plpgsql;

create or replace function exibir_fatura_and_items()
returns table (id_fatura_enc int, id_item_remessa int, nome_comp text, quantidade_remessa int, preco_item_fatura money, preco_total_enc money)
as $$
begin
	return query select * from view_fatura_and_items;
end;
$$ language plpgsql;

create or replace function exibir_fatura_encomenda()
returns table (id_fatura_enc int, preco_total_enc money)
as $$
begin
	return query select * from view_fatura_encomenda;
end;
$$ language plpgsql;

create or replace function exibir_fornecedores()
returns table (id_forn int, nome_forn text)
as $$
begin
	return query select * from view_fornecedores;
end;
$$ language plpgsql;

create or replace function exibir_guia_remessa()
returns table (id_guia_remessa int, data_chegada timestamp)
as $$
begin
	return query select * from view_guia_remessa;
end;
$$ language plpgsql;

create or replace function exibir_itens_encomenda()
returns table (id_enc int, nome_forn text, notas_enc text, data_enc timestamp, nome_comp text, quantidade_enc int, desc_comp text)
as $$
begin
	return query select * from view_itens_encomenda;
end;
$$ language plpgsql;

create or replace function exibir_itens_remessa()
returns table (id_item_remessa int, nome_comp text, quantidade_remessa int, nome_arm text, setor text, data_chegada timestamp)
as $$
begin
	return query select * from view_itens_remessa;
end;
$$ language plpgsql;

create or replace function exibir_mao_obra_por_fp()
returns table (id_ficha_prod int, nome_equipamento text, nome_mo text, hora_inicio timestamp, hora_fim timestamp, custo_mo text)
as $$
begin
	return query select * from view_mao_obra_por_fp;
end;
$$ language plpgsql;

create or replace function exibir_mo()
returns table (id_mao_obra int, nome_mo text, custo_mo text, tipo_mo text)
as $$
begin
	return query select * from view_mo;
end;
$$ language plpgsql;

