	
CREATE FUNCTION id_cliente()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_cliente) INTO last_id FROM clientes;
        PERFORM SETVAL('cliente_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_cliente
	AFTER DELETE ON clientes
	FOR EACH ROW
	EXECUTE FUNCTION id_cliente();
	
	

CREATE FUNCTION id_armazem()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_armazem) INTO last_id FROM armazem;
        PERFORM SETVAL('armazem_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_armazem
	AFTER DELETE ON armazem
	FOR EACH ROW
	EXECUTE FUNCTION id_armazem();





CREATE FUNCTION id_componente()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_componente) INTO last_id FROM componentes;
        PERFORM SETVAL('componentes_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_componente
	AFTER DELETE ON componentes
	FOR EACH ROW
	EXECUTE FUNCTION id_componente();
	
	




CREATE FUNCTION id_comp_prod()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_comp_prod) INTO last_id FROM componentes_producao;
        PERFORM SETVAL('comp_prod_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_comp_prod
	AFTER DELETE ON componentes_producao
	FOR EACH ROW
	EXECUTE FUNCTION id_comp_prod();





CREATE FUNCTION id_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_enc) INTO last_id FROM encomenda;
        PERFORM SETVAL('encomenda_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_encomenda
	AFTER DELETE ON encomenda
	FOR EACH ROW
	EXECUTE FUNCTION id_encomenda();






CREATE FUNCTION id_equipamento()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_equipamento) INTO last_id FROM equipamentos;
        PERFORM SETVAL('equipamentos_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_equipamento
	AFTER DELETE ON equipamentos
	FOR EACH ROW
	EXECUTE FUNCTION id_equipamento();




CREATE FUNCTION id_equipamentos_armazenados()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_eq_arm) INTO last_id FROM equipamnetos_arm;
        PERFORM SETVAL('equipamentos_arm_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_equipamentos_armazenados
	AFTER DELETE ON equipamnetos_arm
	FOR EACH ROW
	EXECUTE FUNCTION id_equipamentos_armazenados();
	




CREATE FUNCTION id_fatura_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_fatura_enc) INTO last_id FROM fatura_encomenda;
        PERFORM SETVAL('fatura_encomenda_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_fatura_encomenda
	AFTER DELETE ON fatura_encomenda
	FOR EACH ROW
	EXECUTE FUNCTION id_fatura_encomenda();
	
	
	



CREATE FUNCTION id_fatura_venda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_fatura_venda) INTO last_id FROM fatura_venda;
        PERFORM SETVAL('fatura_venda_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_fatura_venda
	AFTER DELETE ON fatura_venda
	FOR EACH ROW
	EXECUTE FUNCTION id_fatura_venda();
	






	
CREATE FUNCTION id_ficha_producao()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_ficha_prod) INTO last_id FROM ficha_producao;
        PERFORM SETVAL('ficha_producao_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_ficha_producao
	AFTER DELETE ON ficha_producao
	FOR EACH ROW
	EXECUTE FUNCTION id_ficha_producao();
	





CREATE FUNCTION id_fornecedores()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_forn) INTO last_id FROM fornecedores;
        PERFORM SETVAL('fornecedor_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_fornecedores
	AFTER DELETE ON fornecedores
	FOR EACH ROW
	EXECUTE FUNCTION id_fornecedores();
	
	
	
	
	
CREATE FUNCTION id_guia_remessa()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_guia_remessa) INTO last_id FROM guia_remessa;
        PERFORM SETVAL('guia_remessa_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_guia_remessa
	AFTER DELETE ON guia_remessa
	FOR EACH ROW
	EXECUTE FUNCTION id_guia_remessa();





CREATE FUNCTION id_item_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_item_enc) INTO last_id FROM item_enc;
        PERFORM SETVAL('item_enc_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_item_encomenda
	AFTER DELETE ON item_enc
	FOR EACH ROW
	EXECUTE FUNCTION id_item_encomenda();
	
	




CREATE FUNCTION id_item_fatura_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_item_fatura) INTO last_id FROM item_fatura_enc;
        PERFORM SETVAL('item_fatura_enc_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_item_fatura_encomenda
	AFTER DELETE ON item_fatura_enc
	FOR EACH ROW
	EXECUTE FUNCTION id_item_fatura_encomenda();
	




CREATE FUNCTION id_itens_fatura_venda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_item_venda) INTO last_id FROM itens_fatura_venda;
        PERFORM SETVAL('itens_fatura_venda_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_itens_fatura_venda
	AFTER DELETE ON itens_fatura_venda
	FOR EACH ROW
	EXECUTE FUNCTION id_itens_fatura_venda();






CREATE FUNCTION id_itens_remessa()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_item_remessa) INTO last_id FROM itens_remessa;
        PERFORM SETVAL('item_remessa_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_itens_remessa
	AFTER DELETE ON itens_remessa
	FOR EACH ROW
	EXECUTE FUNCTION id_itens_remessa();








CREATE FUNCTION id_mao_obra()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_mao_obra) INTO last_id FROM mao_obra;
        PERFORM SETVAL('mao_obra_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_mao_obra
	AFTER DELETE ON mao_obra
	FOR EACH ROW
	EXECUTE FUNCTION id_mao_obra();






CREATE FUNCTION id_mao_obra_usada()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    last_id INTEGER;
BEGIN
	IF TG_OP = 'DELETE' THEN
     
        SELECT MAX(id_mo_usada) INTO last_id FROM mo_usada;
        PERFORM SETVAL('mo_usada_id_sequence', COALESCE(last_id, 1));
    END IF;
	RETURN OLD;
END;
$$;

CREATE TRIGGER gestao_id_mao_obra_usada
	AFTER DELETE ON mo_usada
	FOR EACH ROW
	EXECUTE FUNCTION id_mao_obra_usada();




