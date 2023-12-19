select * from view_fornecedores --vista para todos os fornecedores

select * from view_clients -- """"""""""" os clientes

select * from view_componentes

select * from view_mo

select * from view_armazem

select * from view_encomenda

select * from view_itens_encomenda

select * from view_guia_remessa

select * from view_itens_remessa 

select * from view_fatura_encomenda

select * from view_fatura_and_items

select * from view_equipamentos

select * from view_mao_obra_por_fp

select * from view_componentes_por_fp

select * from view_equipamentos_armazenados
























SELECT fe.id_fatura_enc, ir.id_item_remessa, c.nome_comp,ir.quantidade_remessa, ife.preco_item_fatura, fe.preco_total_enc
   FROM encomenda e
     LEFT JOIN fornecedores f ON e.id_forn = f.id_forn
	 RIGHT JOIN item_enc ie ON e.id_enc = ie.id_enc
     left JOIN componentes c ON c.id_componente = ie.id_componente 
	 right join itens_remessa ir on ir.id_item_enc = ie.id_item_enc
	 left join  item_fatura_enc ife on ir.id_item_remessa = ife.id_item_remessa
	 left join fatura_encomenda fe on ife.id_fatura_enc  = fe.id_fatura_enc




