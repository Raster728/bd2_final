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

