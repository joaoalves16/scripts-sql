SELECT 
    usuario.nome AS secretario,
    usuario.email,
    imovel.id,
    imovel.preco,
    CONCAT(imovel.logradouro,
            ', ',
            imovel.numero,
            '/',
            imovel.complemento) as endereço,
    bairro.nome AS bairro,
    DATE(imovel.publicado_em) AS data
FROM
    imovel
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    imovel_captacao_participante ON imovel_captacao_participante.imovel_id = imovel.id
        JOIN
    usuario ON imovel_captacao_participante.usuario_id = usuario.id
WHERE
    DATE_FORMAT(imovel.publicado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
        AND imovel_captacao_participante.deletado_em IS NULL
        AND usuario.grupo_id = 12
LIMIT 5000
