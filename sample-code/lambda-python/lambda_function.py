def lambda_handler(event, context):
    print("This is a sample Lambda function provided by Techie-In-You")
    print('EVENT: \n{}'.format(event))  
    return(context.log_stream_name)    