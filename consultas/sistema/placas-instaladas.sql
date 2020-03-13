SELECT 
    imovel_placa.criado_em AS Data,
    imovel.id AS Codigo,
    imovel.chave_proprietario,
    imovel.chave_escritorio,
    usuario.nome AS Nome,
    imovel_placa.tipo,
    bairro.nome as Bairro,
    imovel_placa.manutencao,
    imovel_placa.local_instalacao,
    imovel_placa.forma_entrada,
    REPLACE(REPLACE(REPLACE(imovel_placa.observacao, '\t', ' '), '\r', ' '), '\n', ' ') as observacao
FROM
    imovel_placa
        JOIN
    imovel ON imovel_placa.imovel_id = imovel.id
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    usuario ON imovel_placa.usuario_agendamento_id = usuario.id
WHERE

DATE_FORMAT(imovel_placa.criado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')

ORDER BY imovel_placa.criado_em ASC
LIMIT 5000