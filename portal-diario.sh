#!/bin/bash
ssh -f -o ExitOnForwardFailure=yes -N -L 4321:portal.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@3.219.235.103
pid=$(pgrep -f '4321:')
for consulta in "consultas/portal/*.sql"
do
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    cat $consulta | mysql -P 4321 -u casamineira_leitura -h 127.0.0.1 --password='m6!3rdH#7SK@Lwef' casamineira_portal > relatorios/portal/$arquivo.csv
done
kill $pid