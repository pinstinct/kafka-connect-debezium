#!/bin/sh
set -e

CONNECT_URL="http://connect:8083"
CONNECTOR_DIR="/connectors"

echo ${CONNECT_URL}
echo "Waiting for Kafka Connect..."
until curl -sf ${CONNECT_URL}${CONNECTOR_DIR} >/dev/null; do
    sleep 3
done

echo "Kafka Connect is ready"

for file in ${CONNECTOR_DIR}/*.json; do
    NAME=$(jq -r '.name' "$file")
    echo "Processing connector: ${NAME}"

    if curl -sf ${CONNECT_URL}${CONNECTOR_DIR}/${NAME} >/dev/null; then
        echo "  -> already exists, skip"
        continue
    fi

    echo "  -> creating"
    # ${inventory} 데이터베이스 모니터링을 위한 커넥터 등록 
    curl -s -X POST -H "Accept:application/json" -H "Content-Type: application/json" ${CONNECT_URL}${CONNECTOR_DIR} --data @"$file"
done

echo "All connectors processed"
