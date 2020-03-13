#!/bin/bash
ssh -f -o ExitOnForwardFailure=yes -N -L 1234:app.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@3.220.162.0 
pid=$(pgrep -f '1234:')
for consulta in /home/joaoalves/Projetos/scripts-sql/consultas/sistema/*.sql
do
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    cat $consulta | mysql -P 1234 -u casamineiraimoveis_leitura -h 127.0.0.1 --password='ie9#NnXL343^7M7*' casamineira > /home/joaoalves/Projetos/scripts-sql/relatorios/sistema/$arquivo.csv
    echo $consulta
done
kill $pid