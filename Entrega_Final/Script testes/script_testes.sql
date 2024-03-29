--------------------------------- Scripts de teste -------------------------------

--------------------------------- EDITAR -----------------------------------------

CALL public.proc_editar_clients(1, 'antonio', '122234');

CALL public.proc_editar_componentes(1, 'as', 'es');

CALL public.proc_editar_eq_arm(1);

CALL public.proc_editar_fornecedores(1, 'Eu');

------------------------------ EXIBIR -----------------------------------

SELECT * from public.componentes_em_stock();

SELECT * from public.componentes_em_stock_por_comp(1);

SELECT * from public.exibir_armazem();

SELECT * from public.exibir_clients();

SELECT * from public.exibir_componentes();

SELECT * from public.exibir_componentes_por_fp();

SELECT * from public.exibir_encomenda();

SELECT * from public.exibir_equipamentos();

SELECT * from public.exibir_equipamentos_armazenados();

SELECT * from public.exibir_fatura_and_items();

SELECT * from public.exibir_fatura_encomenda();

SELECT * from public.exibir_fornecedores();

SELECT * from public.exibir_guia_remessa();

SELECT * from public.exibir_itens_encomenda();

SELECT * from public.exibir_itens_remessa();

SELECT * from public.exibir_mao_obra_por_fp();

SELECT * from public.exibir_mo();

SELECT * from public.export_to_json(1);

SELECT * from public.func_armazem_id(1);

SELECT * from public.func_cliente_id(1);

SELECT * from public.func_cliente_nif('1234');

SELECT * from public.func_comp_ficha_id_com_id(1);

SELECT * from public.func_componente_nome(1);

SELECT * from public.func_equipamento_nome(1);

SELECT * from public.func_fatura_id(1);

SELECT * from public.func_fornecedores_id(1);

SELECT * from public.func_itens_enc_id(1);

SELECT * from public.func_itens_enc_id_com_id(1);

SELECT * from public.func_itens_remessa_id_com_id(1);

SELECT * from public.func_mo_id(1);

SELECT * from public.preco_equipamento(1);

------------------------------ ELIMINAR -----------------------------------

CALL public.proc_eliminar_cliente(1);

CALL public.proc_eliminar_equipamentos_armazenados(1);

CALL public.proc_eliminar_fornecedores(1);

CALL public.proc_eliminar_item_encomenda(1);

------------------------------ INSERIR -------------------------------

CALL public.proc_inserir_cliente('nome novo', 'n');

CALL public.proc_inserir_componentes('componente novo', 'descrição nova');

CALL public.proc_inserir_componentes_producao(1, 1, 4);

CALL public.proc_inserir_encomenda(1, 'notas nova', '22-08-2024', 1);

CALL public.proc_inserir_equipamento('nome novo', 'novo tipo');

CALL public.proc_inserir_equipamento_armazenado(1, 1);

CALL public.proc_inserir_factura_enc(1);

CALL public.proc_inserir_fatura_venda(1, 1);

CALL public.proc_inserir_ficha_producao(1, 1);

CALL public.proc_inserir_fornecedor('novo nome');

CALL public.proc_inserir_guia_remessa('22-12-2024', 1);

CALL public.proc_inserir_item_fatura(1, 1, '20');

CALL public.proc_inserir_itens_encomenda('1', '9', '20');

CALL public.proc_inserir_itens_fatura_venda(1, '2', '35');

CALL public.proc_inserir_mo_usada(1, 1, '02-02-2024', '04-02-2024');


------------------------------ TRIGGER -------------------------------

SELECT * FROM ficha_producao WHERE id_ficha_prod = 1;
CALL public.proc_inserir_componentes_producao(1, 1, 4);
SELECT * FROM ficha_producao WHERE id_ficha_prod = 1;

SELECT * FROM fatura_venda WHERE id_fatura_venda = 1;
CALL public.proc_inserir_itens_fatura_venda(1, '2', '35');
SELECT * FROM fatura_venda WHERE id_fatura_venda = 1;

SELECT * FROM fatura_encomenda WHERE id_fatura_enc = 1;
CALL public.proc_inserir_item_fatura(1, 1, '20');
SELECT * FROM fatura_encomenda WHERE id_fatura_enc = 1;