INSERT INTO public.fornecedores(id_forn, nome_forn)
	VALUES (1, 'Asus'),
	(2, 'Acer'),
	(3, 'Omen'),
	(4, 'Hp'),
	(5, 'Gigabyte');
	
INSERT INTO public.encomenda(id_enc, id_forn, notas_enc, data_enc)
	VALUES (1, 2, 'Notas A', '2023-05-16 13:00:00'),
	(2, 5,'notas B', '2023-05-16 13:30:00'),
	(3, 4,'notas B', '2023-05-16 13:30:00'),
	(4, 2,'notas B', '2023-05-16 13:30:00'),
	(5, 1,'notas B', '2023-05-16 13:30:00');
	
INSERT INTO public.componentes(id_componente, nome_comp, desc_comp)
	VALUES (1, '8Gb RAM G-Skillz', 'desc A'),
	(2, '16Gb RAM Ripjaws', 'desc B'),
	(3, 'RTX 3060 MSI', 'desc C'),
	(4, 'RTX 3060 Ti ASUS', 'desc D'),
	(5, 'RTX 3070 Gigabyte', 'desc E'),
	(6, 'Intel processor I7 12790k', 'desc E'),
	(7, 'Intel processor I5 12590k', 'desc E'),
	(8, 'AMD Ryzen 5 5600', 'desc E'),
	(9, 'AMD Ryzen 7 7700', 'desc E');
	
INSERT INTO public.item_enc(id_item_enc, id_enc, id_componente, quantidade_enc)
	VALUES (1, 1, 3, 10),
	(2, 1, 1, 15),
	(3, 2, 2, 20),
	(4, 3, 3, 50),
	(5, 4, 4, 40),
	(6, 5, 5, 25);

INSERT INTO public.guia_remessa(id_guia_remessa, data_chegada)
	VALUES (1, '2023-05-16 13:00:00'),
	(2, '2023-05-17 13:00:00'),
	(3, '2023-05-18 13:00:00'),
	(4, '2023-05-19 13:00:00'),
	(5, '2023-05-20 13:00:00');
	
INSERT INTO public.armazem(id_armazem,  nome_arm, setor, notas)
	VALUES (1, 'Armazem A', 'Setor A', 'Notas A'),
	(2, 'Armazem B', 'Setor B', 'Notas B');
	
	
INSERT INTO public.itens_remessa(id_item_remessa, id_armazem, id_item_enc, id_guia_remessa, quantidade_remessa)
	VALUES (1, 1, 1, 1, 2),
	(2, 1, 1, 1, 5),
	(3, 2, 2, 3, 7),
	(4, 2, 3, 2, 8),
	(5, 1, 4, 4, 9);
	
INSERT INTO public.fatura_encomenda(id_fatura_enc, preco_total_enc)
	VALUES (1, 290),
	(2, 1270),
	(3, 140),
	(4, 150);
	
INSERT INTO public.item_fatura_enc(id_item_fatura, id_fatura_enc, id_item_remessa, preco_item_fatura)
	VALUES (1, 1, 1, 140),
	(2, 1, 2, 150),
	(3, 2, 3, 1000),
	(4, 3, 4, 140),
	(5, 4, 5, 150),
	(6, 2, 5, 170);
	
INSERT INTO public.equipamentos(id_equipamento, nome_equipamento, tipo)
	VALUES (1, 'equipamento A', 'Gaming'),
	(2, 'equipamento B', 'Gaming'),
	(3, 'equipamento C', 'Office'),
	(4, 'equipamento D', 'Office'),
	(5, 'equipamento E', 'Office');

INSERT INTO public.ficha_producao(
	id_ficha_prod, id_equipamento, custo_producao)
	VALUES (1, 1, 0),
	(2, 2, 0),
	(3, 3, 0),
	(4, 4, 0),
	(5, 5, 0);
	
	
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
	id_eq_arm, id_armazem, id_ficha_prod, estado)
	VALUES (1, 1, 1, 'nao'),
	(2, 1, 2, 'nao'),
	(3, 2, 2,  'nao'),
	(4, 2, 3,  'nao'),
	(5, 1, 4,  'nao');
	
INSERT INTO public.clientes(
	id_cliente, nome_cliente, nif)
	VALUES (1, 'antonio', '1234567'),
	(2, 'antonieta', '1234568'),
	(3, 'ambrosio', '1234569'),
	(4, 'manel', '1234560');

