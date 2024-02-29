#!/bin/bash


aws s3 cp americanflag.jpg s3://ds2002-kbv4nd/

aws s3 presign --expires-in 604800 s3://ds2002-kbv4nd/americanflag.jpg

# Presigned URL: 
https://ds2002-kbv4nd.s3.us-east-1.amazonaws.com/americanflag.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAZQ3DQB5YP2LOI4II%2F20240229%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240229T192625Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Security-Token=FwoGZXIvYXdzEDMaDPWKaVEQA%2BD5xrr7%2FCLEAXcx9p1NGpYqnz4%2FE%2FCo7SDSgOfSLz6gSlnOJ9Ce6IwrZPNDldt9JuxFGoXMQvGE5l2PTtHBw1dD99%2Fn7yCU2XfN73d78hwfnW1UkWLbVh9tthy23tuXkJ%2FwNcCbPonBZE%2FUEjQPqyZRO2Sx3nJab5XWAvmj0sPXcwCNUUATms4JSyUpKWcxWKpDwQLuQ7VYceFmTiRlOLtyJgTLAy8zUoffiVMxOADlLB%2BeQ%2FJV3IAZLrfMIVkIyew3Jsf5fHDCwDPDFkAo6%2F%2BCrwYyLYAQ8CQ0hvJoX31SFK1PU6d656ufQKqYGhOQnU4e6JV4PwfPpr13GbkC424eaw%3D%3D&X-Amz-Signature=9b4815f296f1a188f564cee7bb86725e0f5e53b230ea638fed51ba9d177eb7eb

# Note: I had that same issue with the Presigned URL that you mentioned in the email sent out Thursday morning.
#       That is the correct one, but for some reason it stops working!
