SELECT 
    usuario.nome AS usuario,
    cliente.nome AS cliente_nome,
    cliente.telefone AS cliente_telefone,
    cliente.email AS cliente_email,
    cliente_lembrete.lembrete,
    cliente_lembrete.criado_em,
    cliente_lembrete.lembrete_em
FROM
    cliente_lembrete
        JOIN
    cliente ON cliente_lembrete.cliente_id = cliente.id
        JOIN
    usuario ON cliente_lembrete.criado_por = usuario.id
WHERE
    DATE_FORMAT(cliente_lembrete.criado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
LIMIT 50000
