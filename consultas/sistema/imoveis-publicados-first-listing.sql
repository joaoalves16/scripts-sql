SELECT 
    DATE(imovel.publicado_em) AS publicado_em,
    bairro.nome AS bairro,
    cidade.nome AS cidade,
    uf.sigla AS uf,
    COUNT(*) AS imoveis
FROM
    imovel
        JOIN
    bairro ON bairro.id = imovel.bairro_id
        JOIN
    cidade ON cidade.id = bairro.cidade_id
        JOIN
    uf ON cidade.uf_id = uf.id
        JOIN
    tipo ON tipo.id = imovel.tipo_id
WHERE
    DATE_FORMAT(imovel.publicado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
GROUP BY DATE(imovel.publicado_em) , cidade.id , bairro.id
ORDER BY imovel.publicado_em
LIMIT 50000