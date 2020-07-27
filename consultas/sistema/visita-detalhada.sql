SELECT 
    cliente.nome AS cliente,
    cliente.telefone AS cliente_telefone,
    cliente.email AS cliente_email,
    visita.visita_em,
    visita.imovel_id,
    visita.validacao,
    CONCAT(criado_por.nome,
            '(',
            criado_por.email,
            ')') AS criado_por,
    CONCAT(corretor.nome, '(', corretor.email, ')') AS corretor
FROM
    visita
        JOIN
    cliente ON visita.cliente_id = cliente.id
        JOIN
    usuario criado_por ON visita.criado_por = criado_por.id
        JOIN
    usuario corretor ON visita.usuario_id = corretor.id
WHERE
    DATE_FORMAT(visita.visita_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
    limit 50000