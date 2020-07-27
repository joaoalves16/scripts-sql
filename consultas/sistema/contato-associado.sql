SELECT 
    contato.atendimento_em AS 'Data de Atendimento ',
    contato.criado_em AS 'Data de Criação',
    contato.nome AS 'Nome do cliente',
    contato.email AS 'Email do cliente',
    contato.telefone AS 'Telefone Cliente',
    contato_origem.nome AS 'Origem de acesso',
    imovel.preco AS 'Preço do imovel',
    usuario.nome AS 'Nome do(a) secretário(a)',
    usuario.email,
    bairro.nome AS 'Nome do bairro'
FROM
    contato
        JOIN
    contato_origem ON contato.origem_id = contato_origem.id
        JOIN
    usuario ON contato.usuario_atendimento_id = usuario.id
        LEFT JOIN
    imovel ON imovel.id = contato.imovel_id
        LEFT JOIN
    bairro ON imovel.bairro_id = bairro.id
WHERE
    DATE_FORMAT(contato.atendimento_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
ORDER BY contato.atendimento_em
LIMIT 50000
