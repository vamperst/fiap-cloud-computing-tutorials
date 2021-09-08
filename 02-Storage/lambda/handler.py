import boto3
import json

client = boto3.client('s3')


def handler(event, context):
    print(json.dumps(event))
    print(type(event))
    print(event.keys())
    

    bucket=event["bucket"]
    chave=event["key"]

    print(bucket)
    print(chave)
    
    response = client.get_object(
        Bucket=bucket,
        Key=chave,
    )
    print(response)

    return response['ResponseMetadata']['HTTPStatusCode']