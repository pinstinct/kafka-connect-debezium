## 소개

[카프카(Kafka) 커넥트 Debezium 튜토리얼](https://debezium.io/documentation/reference/3.4/tutorial.html)을 따라 실습한 내용을 정리한다.

## 실행 방법

프로젝트를 다운받은 후, 다음 명령어를 실행한다.

```sh
docker compose up 
```

카프카, MySQL DB, 카프카 커넥터 컨테이너를 생성한 후 init-connet 컨테이너가 커넥터에 DB를 모니터하도록 등록한다.

모든 컨테이너가 실행되고 나면 watcher 컨테이너를 통해 변경 사항을 확인할 수 있다. 


### 이벤트 변경 확인

DB에 변경 사항이 생기면, 카프카 커넥터가 감지해 이벤트를 생성한다.

```sql
-- update
UPDATE customers SET first_name='Anne Marie' WHERE id=1004;

-- delete
DELETE FROM customers WHERE id=1004;
```

## 카프카 클러스터 구성 예시

[docker-compose-kafka-cluster.yaml
](https://github.com/debezium/debezium-examples/blob/main/tutorial/docker-compose-kafka-cluster.yaml)
