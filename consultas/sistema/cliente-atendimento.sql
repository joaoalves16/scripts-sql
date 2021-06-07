SELECT 
    usuario.nome AS criado_por,
    cliente.nome AS cliente,
    cliente.telefone,
    cliente_atendimento.tipo,
    cliente_atendimento.descricao,
    cliente_atendimento.atendimento_em,
    cliente_atendimento.criado_em
FROM
    cliente_atendimento
        JOIN
    usuario ON cliente_atendimento.criado_por = usuario.id
        JOIN
    cliente ON cliente_atendimento.cliente_id = cliente.id
WHERE
    DATE_FORMAT(cliente_atendimento.atendimento_em,
            '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
LIMIT 50000
