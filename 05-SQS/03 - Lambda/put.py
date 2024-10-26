from sqsHandler import SqsHandler
import boto3

def get_account_id():
    sts_client = boto3.client('sts')
    account_id = sts_client.get_caller_identity()["Account"]
    return account_id

account_id = get_account_id()   

mensagens = []
for num in range(3000):
    mensagens.append({'Id':str(num), 'MessageBody': str(num)})

splitMsg = [mensagens[x:x+10] for x in range(0, len(mensagens), 10)]
sqs = SqsHandler(f'https://sqs.us-east-1.amazonaws.com/{account_id}/demoqueue')
for lista in splitMsg:    
    print(type(lista))
    print(str(lista))
    sqs.sendBatch(lista)