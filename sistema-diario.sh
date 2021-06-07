#!/bin/bash
ssh -i /home/joaoalves/.ssh/id_rsa_cm_script -f -o ExitOnForwardFailure=yes -N -L 1234:sistema.cehhbd9xyiuz.us-east-1.rds.amazonaws.com:3306 ubuntu@ec2-3-220-162-0.casamineira 
pid=$(pgrep -f '1234:')
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
for consulta in $RAIZ/consultas/sistema/*.sql
do
    hoje=$(date +"%d-%m-%Y")
    arquivo=$(echo $consulta | grep -Eo '([a-z0-9-]+).sql$' | cut -d. -f1)
    nome=$arquivo'_('$hoje')'
    cat $consulta | mysql -P 1234 -i -u joao.alves -h 127.0.0.1 --password='yp9%rd@Pmh5wnbr8' casamineira > $RAIZ/relatorios/sistema/$arquivo/$nome.csv
    if [ -s $RAIZ/relatorios/sistema/$arquivo/$nome.csv ]
    then
        echo $nome
    else
        rm $RAIZ/relatorios/sistema/$arquivo/$nome.csv
        echo $nome - 'ARQUIVO VAZIO'
    fi
done
kill $pid
