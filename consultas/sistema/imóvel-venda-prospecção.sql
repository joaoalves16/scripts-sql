SELECT 
    imovel.id,
    bairro.nome AS bairro,
    tipo.nome AS tipo,
    imovel.preco,
    status.nome AS status,
    venda.vendido_em,
    venda_comissao.comissao_bruta,
    captador_participante.nome AS captador_participante,
    corretor.nome AS corretor,
    gerente.nome AS gerente
FROM
    venda
        JOIN
    venda_comissao ON venda_comissao.venda_id = venda.id
        JOIN
    imovel ON venda.imovel_id = imovel.id
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    tipo ON imovel.tipo_id = tipo.id
        JOIN
    status ON imovel.status_id = status.id
        JOIN
   imovel_captacao_participante ON imovel_captacao_participante.imovel_id = imovel.id
        JOIN
    usuario AS captador_participante ON imovel_captacao_participante.usuario_id = captador_participante.id
        JOIN
    usuario AS corretor ON venda_comissao.usuario_id = corretor.id
        LEFT JOIN
    usuario gerente ON gerente.id = corretor.gerente_id
WHERE
    captador_participante.grupo_id = 39
ORDER BY venda.id DESC