import boto3
import random


bucket_name = 'lab-conf-111'
folder_names = ['em-preparacao', 'pronto']
users = ['rafael','pedro','teresa','natalia', 'eduardo']
peeker = random.SystemRandom()

def upload_random_file_to_s3():
    s3_client = boto3.client('s3')
    file = f"{random.randint(1, 1000)}-{peeker.choice(users)}"
    
    for folder in folder_names:
        file_name = f"{folder}/{file}"
        file_content = f"This is a test content for {file_name}"
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=file_content)
        print(f"File {file_name} uploaded successfully to {bucket_name}")

for i in range(10):
    upload_random_file_to_s3()