SELECT 
    DATE(imovel.desativado_em) AS desativado_em,
    status.nome AS status,
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
        JOIN
    status ON status.id = imovel.status_id
WHERE
    DATE_FORMAT(imovel.desativado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
GROUP BY DATE(imovel.desativado_em) , status.id , cidade.id , bairro.id
ORDER BY imovel.desativado_em
LIMIT 50000