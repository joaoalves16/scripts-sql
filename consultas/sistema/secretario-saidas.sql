SELECT 
    DATE(visita.visita_em) AS data,
    usuario.nome,
    COUNT(DISTINCT visita.cliente_id) AS quantidade
    
FROM
    visita visita_cliente
        JOIN
    visita ON visita.cliente_id = visita_cliente.cliente_id
        JOIN
    usuario ON visita_cliente.criado_por = usuario.id
WHERE
    DATE(visita.visita_em) >= DATE(visita_cliente.visita_em)
        AND DATE_FORMAT(visita.visita_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
        AND visita.validacao = 'confirmado'
        AND usuario.grupo_id = 12
GROUP BY usuario.nome , DATE(visita.visita_em)
ORDER BY DATE(visita.visita_em)
