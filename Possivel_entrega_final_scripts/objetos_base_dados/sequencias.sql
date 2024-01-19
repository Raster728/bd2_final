CREATE SEQUENCE IF NOT EXISTS public.cliente_id_sequence
    INCREMENT 1
    START 4
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	

CREATE SEQUENCE IF NOT EXISTS public.equipamentos_id_sequence
    INCREMENT 1
    START 5
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.fornecedor_id_sequence
    INCREMENT 1
    START 5
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.encomenda_id_sequence
    INCREMENT 1
    START 5
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	

CREATE SEQUENCE IF NOT EXISTS public.guia_remessa_id_sequence
    INCREMENT 1
    START 5
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.item_enc_sequence
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS public.item_remessa_id_sequence
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.mo_usada_id_sequence
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.ficha_producao_id_sequence
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.comp_prod_id_sequence
    INCREMENT 1
    START 7
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.armazem_id_sequence
	INCREMENT 1
	START 2
	MINVALUE 1
	MAXVALUE 9223372036854775807
	CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.componentes_id_sequence
    INCREMENT 1
    START 9
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS public.equipamentos_arm_id_sequence
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.fatura_encomenda_id_sequence
    INCREMENT 1
    START 4
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.itens_fatura_venda_id_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.item_fatura_enc_id_sequence
    INCREMENT 1
    START 7
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.mao_obra_id_sequence
    INCREMENT 1
    START 3
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS public.fatura_venda_id_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;