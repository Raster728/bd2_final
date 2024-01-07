CREATE OR REPLACE PROCEDURE public.proc_eliminar_cliente(id_c INT)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM clientes 
	WHERE id_cliente=id_c;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_eliminar_fornecedores(id_f INT)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM fornecedores 
	WHERE id_forn=id_f;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_eliminar_item_encomenda(id_i_e INT)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM item_enc
	WHERE id_item_enc=id_i_e;
END;
$BODY$;

