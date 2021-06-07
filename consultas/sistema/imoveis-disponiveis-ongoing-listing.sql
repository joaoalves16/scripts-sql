SELECT 
    CURDATE() AS imovel_disponivel_em,
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
    imovel.status_id = 3
        AND DATE_FORMAT(imovel.publicado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
GROUP BY cidade.id , bairro.id
LIMIT 50000