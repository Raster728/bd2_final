CREATE OR REPLACE PROCEDURE public.proc_eliminar_equipamentos_armazenados(
	IN eq_arm integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM equipamnetos_arm 
	WHERE id_eq_arm = eq_arm;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_eliminar_cliente(
	IN id_c integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM clientes 
	WHERE id_cliente=id_c;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_eliminar_fornecedores(
	IN id_f integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM fornecedores 
	WHERE id_forn=id_f;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.proc_eliminar_item_encomenda(
	IN id_i_e integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM item_enc
	WHERE id_item_enc=id_i_e;
END;
$BODY$;