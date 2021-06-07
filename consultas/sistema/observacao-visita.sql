SELECT 
    imovel.id AS codigo,
    imovel.logradouro,
    imovel.numero,
    imovel.complemento,
    GROUP_CONCAT(IF(usuario_comissao_imovel.principal = 1,
            CONCAT(usuario.nome, ' (', usuario.email, ')'),
            '')
        SEPARATOR ' ') AS captador_principal,
    visita.observacao
FROM
    imovel
        JOIN
    visita ON imovel.id = visita.imovel_id
        LEFT JOIN
    usuario_comissao_imovel ON usuario_comissao_imovel.imovel_id = imovel.id
        LEFT JOIN
    usuario ON usuario_comissao_imovel.usuario_id = usuario.id
WHERE
    usuario_comissao_imovel.deletado_em IS NULL
        AND imovel.status_id = 3
GROUP BY imovel.id
ORDER BY imovel.id ASC
LIMIT 500000