import boto3
import json

client = boto3.client('secretsmanager')
response = client.get_secret_value(SecretId='aurora-db-credentials')
secret = json.loads(response['SecretString'])

username = secret['username']
password = secret['password']

print(f"Username: {username}")
print(f"Password: {password}")