SELECT 
    imovel.id AS codigo,
    imovel.logradouro,
    imovel.numero,
    imovel.complemento,
    bairro.nome AS bairro,
    cidade.nome AS cidade
FROM
    imovel
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    cidade ON bairro.cidade_id = cidade.id
WHERE
    status_id = 3 AND imovel.preco < 300000
    limit 50000