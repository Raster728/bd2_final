INSERT INTO public.fornecedores(
	id_forn, nome_forn)
	VALUES (1, 'asus'),
	(2,'acer'),
	(3,'omen'),
	(4,'hp'),
	(5,'gigabyte');
	
INSERT INTO public.encomenda(
	id_enc, id_forn, notas_enc, data_enc)
	VALUES (1, 2, 'notas A', '2023-05-16 13:00:00'),
	(2,5,'notas B', '2023-05-16 13:30:00'),
	(3,4,'notas B', '2023-05-16 13:30:00'),
	(4,2,'notas B', '2023-05-16 13:30:00'),
	(5,1,'notas B', '2023-05-16 13:30:00');
	
INSERT INTO public.componentes(
	id_componente, nome_comp, desc_comp)
	VALUES (1, 'Ram', 'desc A'),
	(2, 'CPU', 'desc B'),
	(3, 'GPU', 'desc C'),
	(4, 'PSU', 'desc D'),
	(5, 'MOBO', 'desc E');
	
INSERT INTO public.item_enc(
	id_item_enc, id_enc, id_componente, quantidade_enc)
	VALUES (1, 1, 3, 10),
	(2, 1, 1, 15),
	(3, 2, 2, 20),
	(4, 3, 3, 50),
	(5, 4, 4, 40),
	(6, 5, 5, 25);

INSERT INTO public.guia_remessa(
	id_guia_remessa, data_chegada)
	VALUES (1, '2023-05-16 13:00:00'),
	(2, '2023-05-17 13:00:00'),
	(3, '2023-05-18 13:00:00'),
	(4, '2023-05-19 13:00:00'),
	(5, '2023-05-20 13:00:00');
	
INSERT INTO public.armazem(
	id_armazem, nome_arm, setor, notas)
	VALUES (1, 'Armazem A', 'Setor A', 'Notas A'),
	(2, 'Armazem B', 'Setor B', 'Notas B');
	
	
INSERT INTO public.itens_remessa(
	id_item_remessa, id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
	VALUES (1, 1, 1, 1, 2),
	(2, 1, 1, 1, 5),
	(3, 2, 2, 3, 7),
	(4, 2, 3, 2, 8),
	(5, 1, 4, 4, 9);
	
INSERT INTO public.fatura_encomenda(
	id_fatura_enc, preco_total_enc)
	VALUES (1, 1000),
	(2,2000),
	(3,3000),
	(4,4000);
	
INSERT INTO public.item_fatura_enc(
	id_item_fatura, id_fatura_enc, id_item_remessa, preco_item_fatura)
	VALUES (1, 1, 1, 140),
	(2, 1, 2, 150),
	(3, 2, 3, 1000),
	(4, 3, 4, 140),
	(5, 4, 5, 150),
	(6, 2, 5, 170);
	
INSERT INTO public.equipamentos(
	id_equipamento, nome_equipamento, tipo)
	VALUES (1, 'equipamento A', 'Tipo A'),
	(2, 'equipamento B', 'Tipo B'),
	(3, 'equipamento C', 'Tipo C'),
	(4, 'equipamento D', 'Tipo D'),
	(5, 'equipamento E', 'Tipo E');

INSERT INTO public.ficha_producao(
	id_ficha_prod, id_equipamento, custo_producao)
	VALUES (1, 1, 1000),
	(2, 2, 2000),
	(3, 3, 3000),
	(4, 4, 4000),
	(5, 5, 5000);
	
	
INSERT INTO public.componentes_producao(
	id_comp_prod, id_componente, id_ficha_prod, quantidade_usada)
	VALUES (1, 1, 1, 2),
	(2, 3, 1, 3),
	(3, 5, 2, 4),
	(4, 4, 3, 5),
	(5, 3, 4, 1);
	
INSERT INTO public.mao_obra(
	id_mao_obra, nome_mo, custo_mo, tipo_mo)
	VALUES (1, 'MO A', 12, 'TIPO A'),
	(2, 'MO B', 13, 'TIPO B'),
	(3, 'MO C', 14, 'TIPO C');
	
INSERT INTO public.mo_usada(
	id_mo_usada, id_ficha_prod, id_mao_obra, hora_inicio, hora_fim)
	VALUES (1, 1, 1, '2023-05-16 13:00:00', '2023-05-16 15:00:00'),
	(2, 1, 1, '2023-05-16 13:00:00', '2023-05-16 15:00:00'),
	(3, 2, 2, '2023-05-16 13:00:00', '2023-05-16 15:00:00'),
	(4, 3, 3, '2023-05-16 13:00:00', '2023-05-16 15:00:00'),
	(5, 4, 2, '2023-05-16 13:00:00', '2023-05-16 15:00:00'),
	(6, 5, 1, '2023-05-16 13:00:00', '2023-05-16 15:00:00');
	
INSERT INTO public.equipamnetos_arm(
	id_eq_arm, id_armazem, id_ficha_prod, id_quant_eq_arm)
	VALUES (1, 1, 1, 2),
	(2, 1, 2, 3),
	(3, 2, 2, 3),
	(4, 2, 3, 5),
	(5, 1, 4, 1);
	
INSERT INTO public.clientes(
	id_cliente, nome_cliente)
	VALUES (1, 'antonio'),
	(2, 'antonieta'),
	(3, 'ambrosio'),
	(4, 'manel');
	
INSERT INTO public.fatura_venda(
	id_fatura_venda, id_eq_arm, id_cliente, preco_venda, quantidae_venda, data_fatura)
	VALUES (1, 1, 1, 1200, 1, '2023-05-16 19:00:00'),
	(2, 2, 2, 1250, 2, '2023-05-16 19:00:00'),
	(3, 3, 2, 1300, 1, '2023-05-17 19:00:00'),
	(4, 4, 3, 1400, 1, '2023-05-18 19:00:00');
