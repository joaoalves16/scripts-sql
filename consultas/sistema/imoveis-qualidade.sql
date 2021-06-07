SELECT 
    imovel.id,
    imovel.qualidade_imagens,
    preco / preco_avaliacao AS CM,
    imovel.preco_avaliacao,
    imovel.preco,
    bairro.nome AS bairro
FROM
    imovel
        JOIN
    bairro ON imovel.bairro_id = bairro.id
WHERE
    imovel.status_id = 3