def lambda_handler(event, context):
    
    print("Hello from 7s-lb-checker!")
    
    import boto3

    client = boto3.client('elbv2')
    
    response = client.describe_load_balancers()

    print(response)
    
    print("Task completed.")

    return event
