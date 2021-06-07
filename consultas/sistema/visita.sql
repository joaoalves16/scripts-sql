SELECT 
    DATE_FORMAT(data.data, '%m-%d-%Y') AS data,
    (SELECT 
            CONCAT(lider_hub.nome,
                        ' (',
                        lider_hub.email,
                        ')')
        FROM
            usuario gerente
                JOIN
            usuario lider_hub ON lider_hub.id = gerente.gerente_id
        WHERE
            gerente.id = usuario.gerente_id) AS lider_hub,
    (SELECT 
            CONCAT(gerente.nome, ' (', gerente.email, ')')
        FROM
            usuario gerente
        WHERE
            gerente.id = usuario.gerente_id) AS gerente,
    CONCAT(usuario.nome, ' (', usuario.email, ')') AS corretor,
    (SELECT 
            COUNT(DISTINCT visita.cliente_id)
        FROM
            visita
        WHERE
            visita.usuario_id = usuario.id
                AND YEAR(visita.visita_em) = data.ano
                AND MONTH(visita.visita_em) = data.mes
                AND DAY(visita.visita_em) = data.dia
                AND visita.validacao = 'confirmado'
                AND visita.id IN (SELECT 
                    v.id
                FROM
                    visita v
                GROUP BY v.cliente_id
                HAVING MIN(v.id))) AS clientes_unicos,
    (SELECT 
            COUNT(*)
        FROM
            visita
        WHERE
            visita.usuario_id = usuario.id
                AND YEAR(visita.criado_em) = data.ano
                AND MONTH(visita.criado_em) = data.mes
                AND DAY(visita.criado_em) = data.dia) AS visitas_agendadas,
    (SELECT 
            COUNT(*)
        FROM
            visita
        WHERE
            visita.usuario_id = usuario.id
                AND YEAR(visita.visita_em) = data.ano
                AND MONTH(visita.visita_em) = data.mes
                AND DAY(visita.visita_em) = data.dia
                AND visita.validacao = 'confirmado') AS visitas_confirmadas,
    (SELECT 
            COUNT(*)
        FROM
            visita
        WHERE
            visita.usuario_id = usuario.id
                AND YEAR(visita.visita_em) = data.ano
                AND MONTH(visita.visita_em) = data.mes
                AND DAY(visita.visita_em) = data.dia
                AND visita.validacao = 'cancelado') AS visitas_canceladas,
    (SELECT 
            COUNT(DISTINCT DATE(visita.visita_em),
                    visita.cliente_id)
        FROM
            visita
        WHERE
            visita.usuario_id = usuario.id
                AND YEAR(visita.visita_em) = data.ano
                AND MONTH(visita.visita_em) = data.mes
                AND DAY(visita.visita_em) = data.dia
                AND visita.validacao = 'confirmado') AS saidas,
    (SELECT 
            COUNT(DISTINCT visita.imovel_id)
        FROM
            visita
        WHERE
            YEAR(visita.visita_em) = data.ano
                AND MONTH(visita.visita_em) = data.mes
                AND DAY(visita.visita_em) = data.dia
                AND visita.validacao = 'confirmado'
                AND visita.usuario_id = usuario.id) AS imoveis_mostrados
FROM
    usuario
        JOIN
    (SELECT DISTINCT
        data.ano, data.mes, data.dia, data.data
    FROM
        data
    WHERE
		DATE_FORMAT(data.data, '%m/%Y') = DATE_FORMAT(NOW(), '%m/%Y')) AS data
WHERE
    usuario.grupo_id = 2
        AND usuario.interno = 1
        AND usuario.deletado_em IS NULL
HAVING clientes_unicos > 0
    OR visitas_agendadas > 0
    OR visitas_canceladas > 0
    OR saidas > 0
LIMIT 50000