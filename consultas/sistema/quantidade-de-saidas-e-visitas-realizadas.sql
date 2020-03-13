SELECT 
    DATE_FORMAT(venda_cliente_visita.visita_em,
            '%d/%m/%Y') AS Visita_em,
    COUNT(venda_cliente_visita.imovel_id) Quantidade_Visita,
    venda_cliente.nome AS Cliente,
    venda_cliente.telefone,
    usuario.nome AS Corretor,
    usuario.email AS Email_corretor,
    gerente.nome AS Gerente,
    usuariocriador.nome AS Secretario
FROM
    venda_cliente_visita
        JOIN
    venda_cliente ON venda_cliente_visita.cliente_id = venda_cliente.id
        JOIN
    usuario ON venda_cliente_visita.usuario_id = usuario.id
        LEFT JOIN
    usuario gerente ON gerente.id = usuario.gerente_id
        JOIN
    usuario usuariocriador ON venda_cliente_visita.criado_por = usuariocriador.id
WHERE
    venda_cliente_visita.validacao = 'confirmado'
        AND DATE_FORMAT(venda_cliente_visita.visita_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
GROUP BY DATE_FORMAT(venda_cliente_visita.visita_em,
        '%d/%m/%Y') , venda_cliente.nome , venda_cliente.telefone , usuario.nome , gerente.nome
ORDER BY venda_cliente_visita.visita_em ASC
LIMIT 50000
