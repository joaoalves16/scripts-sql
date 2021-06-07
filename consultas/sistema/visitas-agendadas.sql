SELECT 
    visita.cliente_id,
    visita.validacao,
    contato_midia.nome AS midia,
    contato_origem.nome AS origem,
    contato.automatizado,
    DATE(visita.criado_em) AS criado_em,
    DATE(visita.visita_em) AS visita_em,
    visita.imovel_id,
    visita.virtual,
    (SELECT 
            CONCAT(lider_hub.nome,
                        ' (',
                        lider_hub.email,
                        ')')
        FROM
            usuario lider_hub
        WHERE
            lider_hub.id = gerente.gerente_id) AS lider_hub,
    CONCAT(gerente.nome, '(', gerente.email, ')') AS gerente,
    CONCAT(corretor.nome, '(', corretor.email, ')') AS corretor,
    bairro.nome AS bairro,
    cidade.nome AS cidade
FROM
    visita
        JOIN
    usuario corretor ON visita.usuario_id = corretor.id
        JOIN
    usuario gerente ON corretor.gerente_id = gerente.id
        JOIN
    contato ON visita.cliente_id = contato.cliente_id
        JOIN
    contato_origem ON contato.origem_id = contato_origem.id
        JOIN
    contato_midia ON contato.midia_id = contato_midia.id
        JOIN
    imovel ON visita.imovel_id = imovel.id
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    cidade ON cidade.id = bairro.cidade_id
WHERE
    DATE_FORMAT(visita.criado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
        AND contato.id IN (SELECT 
            c.id
        FROM
            contato c
        GROUP BY c.cliente_id
        HAVING MIN(c.id))
        AND imovel.codigo_quintoandar IS NOT NULL
LIMIT 50000