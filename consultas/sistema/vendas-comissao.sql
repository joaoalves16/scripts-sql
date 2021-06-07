SELECT 
    venda.cliente_id,
    DATE(venda.vendido_em) AS data,
    (SELECT 
            CONCAT(lider_hub.nome,
                        ' (',
                        lider_hub.email,
                        ')')
        FROM
            usuario gerente
                JOIN
            usuario lider_hub ON lider_hub.id = gerente.gerente_id
        WHERE
            gerente.id = corretor.gerente_id) AS lider_hub,
    (SELECT 
            unidade.nome
        FROM
            usuario gerente
                JOIN
            usuario lider_hub ON lider_hub.id = gerente.gerente_id
                JOIN
            unidade ON unidade.id = lider_hub.unidade_id
        WHERE
            gerente.id = corretor.gerente_id) AS unidade_lider_hub,
    (SELECT 
            CONCAT(gerente.nome, ' (', gerente.email, ')')
        FROM
            usuario gerente
        WHERE
            gerente.id = corretor.gerente_id) AS gerente,
    (SELECT 
            unidade.nome
        FROM
            usuario gerente
                JOIN
            unidade ON unidade.id = gerente.unidade_id
        WHERE
            gerente.id = corretor.gerente_id) AS unidade_gerente,
    CONCAT(corretor.nome, ' (', corretor.email, ')') AS corretor,
    (SELECT 
            unidade.nome
        FROM
            unidade
        WHERE
            unidade.id = corretor.unidade_id) AS unidade_corretor,
    bairro.nome AS bairro,
    cidade.nome AS cidade,
    uf.sigla AS uf,
    SUM(venda.preco_negociado) AS sales,
    SUM(venda.comissao_negociada) AS comissao
FROM
    venda
        JOIN
    venda_comissao ON venda.id = venda_comissao.venda_id
        JOIN
    usuario corretor ON corretor.id = venda_comissao.usuario_id
        JOIN
    imovel ON imovel.id = venda.imovel_id
        JOIN
    bairro ON bairro.id = imovel.bairro_id
        JOIN
    cidade ON cidade.id = bairro.cidade_id
        JOIN
    uf ON uf.id = cidade.uf_id
WHERE
    DATE_FORMAT(venda.vendido_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
        AND venda_comissao.tipo = 'corretor'
GROUP BY data , corretor.email , imovel.id , cidade.nome , uf.sigla
ORDER BY data
LIMIT 9000

