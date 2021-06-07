SELECT 
    imovel.id,
    tipo.nome AS tipo,
    bairro.nome AS bairro,
    cidade.nome AS cidade,
    uf.nome AS estado,
    imovel.publicado_em,
    usuario.nome,
    usuario.email,
    usuario_grupo.nome AS grupo,
    usuario_comissao_imovel.comissao as comissao
FROM
    imovel
        JOIN
    bairro ON imovel.bairro_id = bairro.id
        JOIN
    cidade ON bairro.cidade_id = cidade.id
        JOIN
    uf ON cidade.uf_id = uf.id
        JOIN
    tipo ON imovel.tipo_id = tipo.id
        JOIN
    usuario_comissao_imovel ON usuario_comissao_imovel.imovel_id = imovel.id
        JOIN
    usuario ON usuario_comissao_imovel.usuario_id = usuario.id
        JOIN
    usuario_grupo ON usuario.grupo_id = usuario_grupo.id
WHERE
    usuario_comissao_imovel.deletado_em IS NULL
        AND DATE_FORMAT(imovel.publicado_em, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')
ORDER BY imovel.publicado_em
LIMIT 500000