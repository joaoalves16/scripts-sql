SELECT 
    DATE_FORMAT(visita.visita_em,
            '%d/%m/%Y') AS Visita_em,
    COUNT(visita.imovel_id) Quantidade_Visita,
    cliente.nome AS Cliente,
    cliente.telefone,
    usuario.nome AS Corretor,
    usuario.email AS Email_corretor,
    gerente.nome AS Gerente,
    usuariocriador.nome AS Secretario
FROM
    visita
        JOIN
    cliente ON visita.cliente_id = cliente.id
        JOIN
    usuario ON visita.usuario_id = usuario.id
        LEFT JOIN
    usuario gerente ON gerente.id = usuario.gerente_id
        JOIN
    usuario usuariocriador ON visita.criado_por = usuariocriador.id
WHERE
    visita.validacao = 'confirmado'
        AND DATE_FORMAT(visita.visita_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
GROUP BY DATE_FORMAT(visita.visita_em,
        '%d/%m/%Y') , cliente.nome , cliente.telefone , usuario.nome , gerente.nome
ORDER BY visita.visita_em ASC
LIMIT 50000
