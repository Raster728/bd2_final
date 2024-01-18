CREATE OR REPLACE PROCEDURE public.proc_eliminar_equipamentos_armazenados(
	IN eq_arm integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	DELETE FROM equipamnetos_arm 
	WHERE id_eq_arm = eq_arm;
END;
$BODY$;