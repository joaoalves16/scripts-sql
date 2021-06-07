SELECT 
    imovel.id AS imovel_id,
    imovel.codigo_quintoandar,
    visita.criado_em AS agendado_em,
    usuario.nome AS criado_por,
    usuario.email AS criado_por_email,
    visita.validado_em,
    usuario_c.nome AS validado_por,
    usuario_c.email AS validado_por_email
FROM
    imovel
        JOIN
    visita ON imovel.id = visita.imovel_id
        JOIN
    usuario ON usuario.id = visita.criado_por
        JOIN
    usuario usuario_c ON usuario_c.id = visita.usuario_validacao_id
WHERE
    imovel.codigo_quintoandar IS NOT NULL
        AND visita.validacao = 'confirmado'
LIMIT 500000