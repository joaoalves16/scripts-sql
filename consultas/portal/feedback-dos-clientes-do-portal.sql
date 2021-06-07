SELECT 
    imobiliaria.nome,
    imovel.codigo,
    contato.nome,
    contato.email,
    contato.telefone,
    contato.criado_em,
    contato_satisfacao.nota,
    contato_satisfacao.comentario,
    contato_satisfacao.criado_em,
    contato_satisfacao.respondido_em
FROM
    contato_satisfacao
        JOIN
    contato ON contato.id = contato_satisfacao.contato_id
        JOIN
    imovel ON imovel.id = contato.imovel_id
        JOIN
    imobiliaria ON imobiliaria.id = imovel.imobiliaria_id
WHERE
    contato_satisfacao.nota IS NOT NULL
        AND DATE_FORMAT(contato_satisfacao.criado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')