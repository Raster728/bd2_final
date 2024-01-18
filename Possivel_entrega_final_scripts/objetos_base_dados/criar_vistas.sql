CREATE OR REPLACE VIEW public.view_armazem
 AS
 SELECT armazem.id_armazem,
    armazem.nome_arm,
    armazem.setor,
    armazem.notas
   FROM armazem;
   
CREATE OR REPLACE VIEW public.view_clients
 AS
 SELECT clientes.id_cliente,
    clientes.nome_cliente,
	clientes.nif
   FROM clientes;
   
CREATE OR REPLACE VIEW public.view_componentes
 AS
 SELECT componentes.id_componente,
    componentes.nome_comp,
    componentes.desc_comp
   FROM componentes;
   
   
CREATE OR REPLACE VIEW public.view_componentes_prod
 AS
 SELECT componentes_producao.id_componente,
    sum(componentes_producao.quantidade_usada) AS quantidade_usada
   FROM componentes_producao
  GROUP BY componentes_producao.id_componente; 
   
   
CREATE OR REPLACE VIEW public.view_quant_remessa
 AS
 SELECT c.id_componente,
    COALESCE(sum(ir.quantidade_remessa), 0::bigint) AS quant_remessa
   FROM componentes c
     LEFT JOIN item_enc ie ON c.id_componente = ie.id_componente
     LEFT JOIN itens_remessa ir ON ir.id_item_enc = ie.id_item_enc
  GROUP BY c.id_componente;
  
   
CREATE OR REPLACE VIEW public.view_componentes_em_stock
 AS
 SELECT c.id_componente,
    vqr.quant_remessa - COALESCE(vcp.quantidade_usada, 0::bigint) AS quantidade_stock,
    c.nome_comp
   FROM componentes c
     LEFT JOIN view_componentes_prod vcp ON c.id_componente = vcp.id_componente
     LEFT JOIN view_quant_remessa vqr ON c.id_componente = vqr.id_componente
  WHERE (vqr.quant_remessa - COALESCE(vcp.quantidade_usada, 0::bigint)) > 0;
 
 
   
CREATE OR REPLACE VIEW public.view_componentes_por_fp
 AS
 SELECT fp.id_ficha_prod,
    e.nome_equipamento,
    c.nome_comp,
    cp.quantidade_usada
   FROM ficha_producao fp
     LEFT JOIN equipamentos e ON fp.id_equipamento = e.id_equipamento
     LEFT JOIN componentes_producao cp ON fp.id_ficha_prod = cp.id_ficha_prod
     LEFT JOIN componentes c ON c.id_componente = cp.id_componente;
	 
	 
	 
CREATE OR REPLACE VIEW public.view_encomenda
 AS
 SELECT e.id_enc,
    f.nome_forn,
    e.notas_enc,
    e.data_enc
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn;
	 
CREATE OR REPLACE VIEW public.view_equipamentos
 AS
 SELECT equipamentos.id_equipamento,
    equipamentos.nome_equipamento,
    equipamentos.tipo
   FROM equipamentos;
   
CREATE OR REPLACE VIEW public.view_equipamentos_armazenados
 AS
 SELECT ea.id_eq_arm,
    a.nome_arm,
    a.setor,
    fp.id_ficha_prod,
    e.nome_equipamento,
    fp.custo_producao
   FROM equipamnetos_arm ea
     LEFT JOIN armazem a ON a.id_armazem = ea.id_armazem
     LEFT JOIN ficha_producao fp ON ea.id_ficha_prod = fp.id_ficha_prod
     LEFT JOIN equipamentos e ON fp.id_equipamento = e.id_equipamento
	 WHERE ea.id_eq_arm NOT IN (SELECT id_eq_arm FROM itens_fatura_venda);
	 
CREATE OR REPLACE VIEW public.view_fatura_and_items
 AS
 SELECT fe.id_fatura_enc,
    ir.id_item_remessa,
    c.nome_comp,
    ir.quantidade_remessa,
    ife.preco_item_fatura,
    fe.preco_total_enc
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn
     RIGHT JOIN item_enc ie ON e.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente
     RIGHT JOIN itens_remessa ir ON ir.id_item_enc = ie.id_item_enc
     LEFT JOIN item_fatura_enc ife ON ir.id_item_remessa = ife.id_item_remessa
     LEFT JOIN fatura_encomenda fe ON ife.id_fatura_enc = fe.id_fatura_enc;
	 
CREATE OR REPLACE VIEW public.view_fatura_encomenda
 AS
 SELECT fatura_encomenda.id_fatura_enc,
    fatura_encomenda.preco_total_enc
   FROM fatura_encomenda;
   
CREATE OR REPLACE VIEW public.view_fornecedores
 AS
 SELECT fornecedores.id_forn,
    fornecedores.nome_forn
   FROM fornecedores;
   
CREATE OR REPLACE VIEW public.view_guia_remessa
 AS
 SELECT guia_remessa.id_guia_remessa,
    guia_remessa.data_chegada
   FROM guia_remessa;
   
   
CREATE OR REPLACE VIEW public.view_itens_encomenda
 AS
 SELECT ve.id_enc,
    ve.nome_forn,
    ve.notas_enc,
    ve.data_enc,
    c.nome_comp,
    ie.quantidade_enc,
    c.desc_comp
   FROM view_encomenda ve
     RIGHT JOIN item_enc ie ON ve.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente;
	 
CREATE OR REPLACE VIEW public.view_itens_remessa
 AS
 SELECT ir.id_item_remessa,
    c.nome_comp,
    ir.quantidade_remessa,
    a.nome_arm,
    a.setor,
    gr.data_chegada
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn
     RIGHT JOIN item_enc ie ON e.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente
     RIGHT JOIN itens_remessa ir ON ir.id_item_enc = ie.id_item_enc
     LEFT JOIN guia_remessa gr ON gr.id_guia_remessa = ir.id_guia_remessa
     LEFT JOIN armazem a ON a.id_armazem = ir.id_armazem;
	 
	 

CREATE OR REPLACE VIEW public.view_itens_remessa_guia
 AS
 SELECT gr.id_guia_remessa,
    ir.id_item_remessa,
    c.nome_comp,
    ir.quantidade_remessa,
    a.nome_arm,
    a.setor,
    gr.data_chegada
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn
     RIGHT JOIN item_enc ie ON e.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente
     RIGHT JOIN itens_remessa ir ON ir.id_item_enc = ie.id_item_enc
     LEFT JOIN guia_remessa gr ON gr.id_guia_remessa = ir.id_guia_remessa
     LEFT JOIN armazem a ON a.id_armazem = ir.id_armazem;
	 
	
CREATE OR REPLACE VIEW public.view_itens_remessa_guia_preco_por_item
 AS
 SELECT gr.id_guia_remessa,
    ir.id_item_remessa,
    c.nome_comp,
    ir.quantidade_remessa,
    a.nome_arm,
    a.setor,
    gr.data_chegada,
    ife.preco_item_fatura
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn
     RIGHT JOIN item_enc ie ON e.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente
     RIGHT JOIN itens_remessa ir ON ir.id_item_enc = ie.id_item_enc
     LEFT JOIN guia_remessa gr ON gr.id_guia_remessa = ir.id_guia_remessa
     LEFT JOIN armazem a ON a.id_armazem = ir.id_armazem
     LEFT JOIN item_fatura_enc ife ON ife.id_item_remessa = ir.id_item_remessa;
	 
	 
CREATE OR REPLACE VIEW public.view_mao_obra_por_fp
 AS
 SELECT fp.id_ficha_prod,
    e.nome_equipamento,
    mo.nome_mo,
    mou.hora_inicio,
    mou.hora_fim,
    mo.custo_mo
   FROM ficha_producao fp
     LEFT JOIN equipamentos e ON fp.id_equipamento = e.id_equipamento
     LEFT JOIN mo_usada mou ON mou.id_ficha_prod = fp.id_ficha_prod
     LEFT JOIN mao_obra mo ON mo.id_mao_obra = mou.id_mao_obra;
	 
CREATE OR REPLACE VIEW public.view_mo
 AS
 SELECT mao_obra.id_mao_obra,
    mao_obra.nome_mo,
    mao_obra.custo_mo,
    mao_obra.tipo_mo
   FROM mao_obra;
   
CREATE OR REPLACE VIEW public.view_itens_com_id
 AS
 SELECT ie.id_item_enc,
    ve.id_enc,
    ve.nome_forn,
    ve.notas_enc,
    ve.data_enc,
    c.nome_comp,
    ie.quantidade_enc,
    c.desc_comp
   FROM view_encomenda ve
     RIGHT JOIN item_enc ie ON ve.id_enc = ie.id_enc
     LEFT JOIN componentes c ON c.id_componente = ie.id_componente;
	 
CREATE OR REPLACE VIEW public.view_fp
 AS
 SELECT fp.id_ficha_prod, nome_equipamento, tipo, custo_producao FROM ficha_producao fp
 LEFT JOIN equipamentos e ON fp.id_equipamento = e.id_equipamento