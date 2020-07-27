SELECT 
    usuario.nome AS criado_por,
    cliente.id AS codigo_cliente,
    cliente.nome AS nome_cliente,
    cliente.telefone as telefone_cliente,
    cliente_observacao.observacao,
    cliente_observacao.criado_em
FROM
    cliente_observacao
        JOIN
    usuario ON cliente_observacao.criado_por = usuario.id
        JOIN
    cliente ON cliente.id = cliente_observacao.cliente_id
WHERE
    DATE_FORMAT(cliente_observacao.criado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
LIMIT 50000
