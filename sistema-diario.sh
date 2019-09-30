#!/bin/bash
ssh -f -o ExitOnForwardFailure=yes -N -L 1234:app.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@3.220.162.0 
pid=$(pgrep -f '1234:')
for consulta in consultas/sistema/*.sql
do
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    cat $consulta | mysql -P 1234 -u casamineira_leitura -h 127.0.0.1 --password='m6!3rdH#7SK@Lwef' casamineira > relatorios/sistema/$arquivo.csv
    echo $consulta
done
kill $pid