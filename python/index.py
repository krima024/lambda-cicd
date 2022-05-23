import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!.........')
    }
  
# def lambda_handler(event, context):
#    message = 'Hello {} !'.format(event['key1'])
#    return {
#        'message' : message
#    }
# import json
# def lambda_handler(event, context):

# #Path parameter passed to Lambda function
#  servername = event["params"]["path"]["servername"]

# #Query string parameter passed to Lambda function

#  Email_id = event['params']['querystring']['emailid']
#  return {

# "Path Parameter" : servername,

# "Query string Parameter" : Email_id

# }
