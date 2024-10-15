import os
import json
import boto3

sqs = boto3.client("sqs")
dynamodb = boto3.resource("dynamodb")

QUEUE_PREPARACAO = os.getenv("SQS_EM_PREPARACAO")
QUEUE_PRONTO = os.getenv("SQS_PRONTO")
DYNAMODB_TABLE = os.getenv("DYNAMODB_TABLE")

def send_to_sqs(event, context):
    for record in event["Records"]:
        key = record["s3"]["object"]["key"]
        bucket = record["s3"]["bucket"]["name"]

        if key.startswith("em-preparacao/"):
            queue_url = QUEUE_PREPARACAO
        elif key.startswith("pronto/"):
            queue_url = QUEUE_PRONTO
        else:
            print(f"Arquivo {key} não pertence a uma pasta válida.")
            return None

        message = {"bucket": bucket, "key": key}
        sqs.send_message(QueueUrl=queue_url, MessageBody=json.dumps(message))
        print(f"Mensagem enviada para {queue_url}: {message}")


def insert_into_dynamodb(event, context):
    table = dynamodb.Table(DYNAMODB_TABLE)

    for record in event['Records']:
        body = json.loads(record['body'])

        item = {
            'pedido': body['key'].split('/')[-1],
            'datetime': record['attributes']['SentTimestamp'],
        }

        table.put_item(Item=item)
        print(f"Item inserido no DynamoDB: {item}")