#!/bin/bash
ssh -f -o ExitOnForwardFailure=yes -N -L 1234:app.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@3.220.162.0 
pid=$(pgrep -f '1234:')
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
for consulta in $RAIZ/consultas/sistema/*.sql
do
    hoje=$(date +"%d-%m-%Y")
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    nome=$arquivo'_('$hoje')'
    cat $consulta | mysql -P 1234 -u casamineiraimoveis_leitura -h 127.0.0.1 --password='ie9#NnXL343^7M7*' casamineira > $RAIZ/relatorios/sistema/$arquivo/$nome.csv
    echo $nome
done
kill $pid