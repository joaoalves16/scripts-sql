SELECT 
    GROUP_CONCAT(IF(usuario_comissao_imovel.principal,
            CONCAT(usuario.nome, ' (', usuario.email, ')'),
            '')
        SEPARATOR '') AS captador_principal,
    GROUP_CONCAT(IF(usuario_comissao_imovel.principal = 0,
            CONCAT(usuario.nome, ' (', usuario.email, '), '),
            '')
        SEPARATOR '') AS captadores_secundarios,
    imovel.publicado_em,
    imovel.desativado_em,
    imovel.id AS codigo,
    CASE imovel.status
        WHEN '3' THEN 'Publicado'
        WHEN '4' THEN 'Negociado'
        WHEN '6' THEN 'Negociado Fora'
        WHEN '7' THEN 'Fora de negociação'
        WHEN '8' THEN 'Reservado'
    END AS status,
    tipo.nome AS tipo,
    imovel.endereco,
    imovel.numero,
    imovel.complemento,
    bairro.nome AS bairro,
    imovel.proprietario_nome,
    imovel.proprietario_telefone,
    imovel.proprietario_email,
    imovel.nomeEdificio,
    preco / preco_avaliacao AS CM,
    imovel.criado_em,
    imovel.publicacao_solicitada_em,
    imovel.republicado_em
FROM
    imovel
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    tipo ON imovel.tipo_id = tipo.id
        LEFT JOIN
    usuario_comissao_imovel ON usuario_comissao_imovel.imovel_id = imovel.id
        LEFT JOIN
    usuario ON usuario_comissao_imovel.usuario_id = usuario.id
WHERE
    usuario_comissao_imovel.deletado_em IS NULL and
    imovel.finalidade ='venda'
GROUP BY imovel.id
ORDER BY imovel.id ASC
LIMIT 500000 