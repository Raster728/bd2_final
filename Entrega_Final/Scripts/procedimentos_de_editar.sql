CREATE OR REPLACE PROCEDURE public.proc_editar_clients(
	IN id_c integer,
	IN nome_cliente_novo text,
	IN nif_novo text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	UPDATE clientes
    SET 
        nome_cliente = nome_cliente_novo,
		nif = nif_novo
    WHERE clientes.id_cliente = id_c;
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_editar_componentes(
	IN componente_id integer,
	IN nome_componente_novo text,
	IN desc_comp_novo text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	UPDATE componentes
    SET 
        nome_comp = nome_componente_novo,
		desc_comp = desc_comp_novo
    WHERE componentes.id_componente = componente_id;
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.proc_editar_eq_arm(
	IN id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	UPDATE equipamnetos_arm
    SET 
        estado = 'venda'
    WHERE equipamnetos_arm.id_eq_arm = id;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.proc_editar_fornecedores(
	IN id integer,
	IN nome text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	UPDATE fornecedores
    SET 
        nome_forn = nome
    WHERE  fornecedores.id_forn = id;
END;
$BODY$;