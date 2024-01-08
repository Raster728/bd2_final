CREATE FUNCTION id_armazem()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE armazem 
		SET id_armazem = id_armazem + 1
		WHERE id_armazem = NEW.id_armazem;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE armazem 
		SET id_armazem = id_armazem - 1
		WHERE id_armazem = OLD.id_armazem;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_armazem
	AFTER INSERT OR DELETE ON armazem
	FOR EACH ROW
	EXECUTE FUNCTION id_armazem();
	
CREATE FUNCTION id_cliente()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE clientes
		SET id_cliente = id_cliente + 1
		WHERE id_cliente = NEW.id_cliente;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE clientes 
		SET id_cliente = id_cliente - 1
		WHERE id_cliente = OLD.id_cliente;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_cliente
	AFTER INSERT OR DELETE ON clientes
	FOR EACH ROW
	EXECUTE FUNCTION id_cliente();
	
CREATE FUNCTION id_componente()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE componentes
		SET id_componente = id_componente + 1
		WHERE id_componente = NEW.id_componente;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE componentes 
		SET id_componente = id_componente - 1
		WHERE id_componente = OLD.id_componente;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_componente
	AFTER INSERT OR DELETE ON componentes
	FOR EACH ROW
	EXECUTE FUNCTION id_componente();
	
CREATE FUNCTION id_comp_prod()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE componentes_producao
		SET id_comp_prod = id_comp_prod + 1
		WHERE id_comp_prod = NEW.id_comp_prod;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE componentes 
		SET id_comp_prod = id_comp_prod - 1
		WHERE id_comp_prod = OLD.id_comp_prod;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_comp_prod
	AFTER INSERT OR DELETE ON componentes_producao
	FOR EACH ROW
	EXECUTE FUNCTION id_comp_prod();
	
CREATE FUNCTION id_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE encomenda
		SET id_enc = id_enc + 1
		WHERE id_enc = NEW.id_enc;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE encomenda 
		SET id_enc = id_enc - 1
		WHERE id_enc = OLD.id_enc;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_encomenda
	AFTER INSERT OR DELETE ON encomenda
	FOR EACH ROW
	EXECUTE FUNCTION id_encomenda();
	
CREATE FUNCTION id_equipamento()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE equipamentos
		SET id_equipamento = id_equipamento + 1
		WHERE id_equipamento = NEW.id_equipamento;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE equipamentos 
		SET id_equipamento = id_equipamento - 1
		WHERE id_equipamento = OLD.id_equipamento;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_equipamento
	AFTER INSERT OR DELETE ON equipamentos
	FOR EACH ROW
	EXECUTE FUNCTION id_equipamento();
	
CREATE FUNCTION id_equipamentos_armazenados()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE equipamnetos_arm
		SET id_eq_arm = id_eq_arm + 1
		WHERE id_eq_arm = NEW.id_eq_arm;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE equipamnetos_arm
		SET id_eq_arm = id_eq_arm - 1
		WHERE id_eq_arm = OLD.id_eq_arm;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_equipamentos_armazenados
	AFTER INSERT OR DELETE ON equipamnetos_arm
	FOR EACH ROW
	EXECUTE FUNCTION id_equipamentos_armazenados();
	
CREATE FUNCTION id_fatura_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE fatura_encomenda
		SET id_fatura_enc = id_fatura_enc + 1
		WHERE id_fatura_enc = NEW.id_fatura_enc;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE fatura_encomenda
		SET id_fatura_enc = id_fatura_enc - 1
		WHERE id_fatura_enc = OLD.id_fatura_enc;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_fatura_encomenda
	AFTER INSERT OR DELETE ON fatura_encomenda
	FOR EACH ROW
	EXECUTE FUNCTION id_fatura_encomenda();
	
CREATE FUNCTION id_fatura_venda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE fatura_venda
		SET id_fatura_venda = id_fatura_venda + 1
		WHERE id_fatura_venda = NEW.id_fatura_venda;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE fatura_venda
		SET id_fatura_venda = id_fatura_venda - 1
		WHERE id_fatura_venda = OLD.id_fatura_venda;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_fatura_venda
	AFTER INSERT OR DELETE ON fatura_venda
	FOR EACH ROW
	EXECUTE FUNCTION id_fatura_venda();
	
CREATE FUNCTION id_ficha_producao()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE ficha_producao
		SET id_ficha_prod = id_ficha_prod + 1
		WHERE id_ficha_prod = NEW.id_ficha_prod;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE ficha_producao
		SET id_ficha_prod = id_ficha_prod - 1
		WHERE id_ficha_prod = OLD.id_ficha_prod;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_ficha_producao
	AFTER INSERT OR DELETE ON ficha_producao
	FOR EACH ROW
	EXECUTE FUNCTION id_ficha_producao();
	
CREATE FUNCTION id_fornecedores()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE fornecedores
		SET id_forn = id_forn + 1
		WHERE id_forn = NEW.id_forn;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE fornecedores
		SET id_forn = id_forn - 1
		WHERE id_forn = OLD.id_forn;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_fornecedores
	AFTER INSERT OR DELETE ON fornecedores
	FOR EACH ROW
	EXECUTE FUNCTION id_fornecedores();
	
CREATE FUNCTION id_guia_remessa()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE guia_remessa
		SET id_guia_remessa = id_guia_remessa + 1
		WHERE id_guia_remessa = NEW.id_guia_remessa;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE guia_remessa
		SET id_guia_remessa = id_guia_remessa - 1
		WHERE id_guia_remessa = OLD.id_guia_remessa;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_guia_remessa
	AFTER INSERT OR DELETE ON guia_remessa
	FOR EACH ROW
	EXECUTE FUNCTION id_guia_remessa();
	
CREATE FUNCTION id_item_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE item_enc
		SET id_item_enc = id_item_enc + 1
		WHERE id_item_enc = NEW.id_item_enc;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE item_enc
		SET id_item_enc = id_item_enc - 1
		WHERE id_item_enc = OLD.id_item_enc;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_item_encomenda
	AFTER INSERT OR DELETE ON item_enc
	FOR EACH ROW
	EXECUTE FUNCTION id_item_encomenda();
	
CREATE FUNCTION id_item_fatura_encomenda()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE item_fatura_enc
		SET id_item_fatura = id_item_fatura + 1
		WHERE id_item_fatura = NEW.id_item_fatura;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE item_fatura_enc
		SET id_item_fatura = id_item_fatura - 1
		WHERE id_item_fatura = OLD.id_item_fatura;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_item_fatura_encomenda
	AFTER INSERT OR DELETE ON item_fatura_enc
	FOR EACH ROW
	EXECUTE FUNCTION id_item_fatura_encomenda();

CREATE FUNCTION id_itens_remessa()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE itens_remessa
		SET id_item_remessa = id_item_remessa + 1
		WHERE id_item_remessa = NEW.id_item_remessa;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE itens_remessa
		SET id_item_remessa = id_item_remessa - 1
		WHERE id_item_remessa = OLD.id_item_remessa;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_itens_remessa
	AFTER INSERT OR DELETE ON itens_remessa
	FOR EACH ROW
	EXECUTE FUNCTION id_itens_remessa();
	
CREATE FUNCTION id_mao_obra()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE mao_obra
		SET id_mao_obra = id_mao_obra + 1
		WHERE id_mao_obra = NEW.id_mao_obra;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE mao_obra
		SET id_mao_obra = id_mao_obra - 1
		WHERE id_mao_obra = OLD.id_mao_obra;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_mao_obra
	AFTER INSERT OR DELETE ON mao_obra
	FOR EACH ROW
	EXECUTE FUNCTION id_mao_obra();
	
CREATE FUNCTION id_mao_obra_usada()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE mo_usada
		SET id_mo_usada = id_mo_usada + 1
		WHERE id_mo_usada = NEW.id_mo_usada;
	END IF;
	IF TG_OP = 'DELETE' THEN
		UPDATE mo_usada
		SET id_mo_usada = id_mo_usada - 1
		WHERE id_mo_usada = OLD.id_mo_usada;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER gestao_id_mao_obra_usada
	AFTER INSERT OR DELETE ON mo_usada
	FOR EACH ROW
	EXECUTE FUNCTION id_mao_obra_usada();