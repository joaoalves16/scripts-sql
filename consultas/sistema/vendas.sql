SELECT 
    venda.vendido_em,
    venda.imovel_id,
    venda.preco_negociado,
    venda.comissao_negociada
FROM
    venda
LIMIT 50000