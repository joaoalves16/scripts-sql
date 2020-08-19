#!/bin/bash
ssh -f -o ExitOnForwardFailure=yes -N -L 4321:portal.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@3.219.235.103
pid=$(pgrep -f '4321:')
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
for consulta in $RAIZ/consultas/portal/*.sql
do
    hoje=$(date +"%d-%m-%Y")
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    nome=$arquivo'_('$hoje')'
    cat $consulta | mysql -P 4321 -u casamineira_leitura -h 127.0.0.1 --password='PJx7&4i$DYb&ZEpf' casamineira_portal > $RAIZ/relatorios/portal//$arquivo/$nome.csv
done
kill $pid