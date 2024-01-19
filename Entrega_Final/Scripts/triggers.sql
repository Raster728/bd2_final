CREATE OR REPLACE FUNCTION public.preco_total_fatura_venda()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	
	UPDATE fatura_venda
	SET preco_total = preco_total + NEW.preco_venda
	WHERE id_fatura_venda = NEW.id_fatura_venda;
	 RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE TRIGGER preco_total_fatura_venda
    AFTER INSERT
    ON public.itens_fatura_venda
    FOR EACH ROW
    EXECUTE FUNCTION public.preco_total_fatura_venda();
	
	
CREATE OR REPLACE FUNCTION public.preco_total_fatura()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	quant_remessa integer;
BEGIN
	SELECT (quantidade_remessa) INTO quant_remessa
	FROM itens_remessa
	WHERE id_item_remessa = NEW.id_item_remessa;
	
	UPDATE fatura_encomenda
	SET preco_total_enc = preco_total_enc + (NEW.preco_item_fatura * quant_remessa)
	WHERE id_fatura_enc = NEW.id_fatura_enc;
	 RETURN NEW;
END;
$BODY$;


CREATE OR REPLACE TRIGGER preco_total_fatura
    AFTER INSERT
    ON public.item_fatura_enc
    FOR EACH ROW
    EXECUTE FUNCTION public.preco_total_fatura();
	
	
	
CREATE OR REPLACE FUNCTION public.preco_total_producao()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	id integer;
	custo money;
BEGIN
	
	SELECT id_componente, preco_item_fatura INTO id, custo
	FROM item_enc ie LEFT JOIN itens_remessa ir ON ie.id_item_enc = ir.id_item_enc
	LEFT JOIN item_fatura_enc ife ON ir.id_item_remessa = ife.id_item_remessa
	where id_componente = NEW.id_componente;
	
	
	UPDATE ficha_producao
	SET custo_producao = custo_producao + custo
	WHERE id_ficha_prod = NEW.id_ficha_prod;
	 RETURN NEW;
END;
$BODY$;



CREATE OR REPLACE TRIGGER trig_preco_prod
    AFTER INSERT
    ON public.componentes_producao
    FOR EACH ROW
    EXECUTE FUNCTION public.preco_total_producao();