SELECT 
    bairro.nome as bairro,
    cidade.nome as cidade,
    (SELECT 
            COUNT(DISTINCT contato.cliente_id)
        FROM
            contato
                JOIN
            imovel ON contato.imovel_id = imovel.id
        WHERE
            DATE(contato.atendimento_em) = CURDATE()
                AND imovel.bairro_id = bairro.id) AS contatos_unicos_dia,
    (SELECT 
            COUNT(*)
        FROM
            contato
                JOIN
            imovel ON contato.imovel_id = imovel.id
        WHERE
            DATE(contato.atendimento_em) = CURDATE()
                AND contato.id IN (SELECT 
                    c.id
                FROM
                    contato c
                GROUP BY c.cliente_id
                HAVING MIN(c.id))
                AND imovel.bairro_id = bairro.id) AS contatos_unicos_vida
FROM
    bairro
        JOIN
    cidade ON bairro.cidade_id = cidade.id
WHERE
    uf_id = 1
GROUP BY bairro.id , cidade.id
HAVING contatos_unicos_dia > 0
LIMIT 2000