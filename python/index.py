def lambda_handler(event, context):
    
    print("Hello from 7s-lb-checker!")
    


#create rule variable ACTION
#example 'Actions': [{'Type': 'redirect', 'Order': 1, 'RedirectConfig': {'Protocol': 'HTTPS', 'Port': '443', 'Host': '#{host}', 'Path': '/#{path}', 'Query': '#{query}', 'StatusCode': 'HTTP_301'}}]

    actions = [{
        'Type': 'redirect',
        'Order': 1,
        'RedirectConfig': {
                'Protocol': 'HTTPS',
                'Port': '443',
                'Host': '#{host}',
                'Path': '/#{path}',
                'Query': '#{query}',
                'StatusCode': 'HTTP_301'
            }
    }]
    
    
    import boto3

    client = boto3.client('elbv2')
    
    
    response = client.describe_load_balancers()

    #complete load_balancers description if necessary for debug
    #print(response)

    for loadbalancers in response['LoadBalancers']:
       if "LoadBalancerName" in loadbalancers:
           print("--------------LOAD-BALANCER----------------------")
           print("-------------------------------------------------")
           lbarn = loadbalancers['LoadBalancerArn']
           print(lbarn + '\t' + loadbalancers['DNSName'])
           print("--------------describe_listeners----------------------")
           health = client.describe_listeners(LoadBalancerArn=lbarn)
           print(health)
           print("-------------------------------------------------")
           for listrs in health['Listeners']:
             print(listrs['Port'])
             if 80 == listrs['Port']:
                 print("--------------------- rule -------------------")
                 rules = client.describe_rules(ListenerArn=listrs['ListenerArn'])
                 print(rules)
                 for rule in rules['Rules']:
                    print("--------------------- create rule -------------------")
                    client.create_rule(ListenerArn=listrs['ListenerArn'], Conditions=[{'Field': 'path-pattern', 'PathPatternConfig': {'Values': ['/']}}],Priority=10, Actions=actions)
                 
           print("-------------------------------------------------")
           
            
            
    print("Task completed.")

    return event
