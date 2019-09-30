SELECT 
    DATE_FORMAT(venda_cliente_visita.visita_em,
            '%d/%m/%Y') AS Visita_em,
    COUNT(venda_cliente_visita.imovel_id) Quantidade_Visita,
    venda_cliente.nome AS Cliente,
    venda_cliente.telefone,
    u1.nome AS Corretor,
    u1.email AS Email_corretor,
    g.nome AS Gerente,
    uc.nome AS Secretario
FROM
    venda_cliente_visita
        JOIN
    venda_cliente ON venda_cliente_visita.cliente_id = venda_cliente.id
        JOIN
    usuario u1 ON venda_cliente_visita.usuario_id = u1.id
        LEFT JOIN
    usuario g ON g.id = u1.idGerente
        JOIN
    usuario uc ON venda_cliente_visita.criado_por = uc.id
WHERE
    venda_cliente_visita.validacao = 'confirmado'
        AND venda_cliente_visita.visita_em >= '2019-09-01 00:00:00' 
GROUP BY DATE_FORMAT(venda_cliente_visita.visita_em,
        '%d/%m/%Y') , venda_cliente.nome , venda_cliente.telefone , u1.nome , g.nome
ORDER BY venda_cliente_visita.visita_em ASC
LIMIT 5000
