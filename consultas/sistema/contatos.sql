SELECT 
    DATE(contato.atendimento_em) AS data,
    imovel.id AS imovel_id,
    contato_origem.nome AS origem,
    contato_midia.nome AS midia,
    imovel.codigo_quintoandar,
    contato.cliente_id,
    bairro.nome AS bairro,
    cidade.nome AS cidade,
    uf.sigla AS sigla
FROM
    contato
        LEFT JOIN
    imovel ON imovel.id = contato.imovel_id
        LEFT JOIN
    bairro ON bairro.id = imovel.bairro_id
        LEFT JOIN
    cidade ON cidade.id = bairro.cidade_id
        LEFT JOIN
    uf ON uf.id = cidade.uf_id
        JOIN
    contato_origem ON contato.origem_id = contato_origem.id
        JOIN
    contato_midia ON contato_midia.id = contato.midia_id
WHERE
    contato.id IN (SELECT 
            c.id
        FROM
            contato c
        GROUP BY c.cliente_id
        HAVING MIN(c.id))
        AND DATE_FORMAT(contato.atendimento_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
ORDER BY data
LIMIT 50000