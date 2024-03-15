#!/usr/bin/env python3


import urllib.request #from python.docs.org --> https://docs.python.org/3/library/urllib.request.html#module-urllib.request
import boto3

with urllib.request.urlopen("https://www.thevintagenews.com/wp-content/uploads/sites/65/2016/09/Crystall-640x515.jpg") as resp:
        monkeytux = resp.read()

s3 = boto3.client('s3', region_name='us-east-1') #client

resp = s3.put_object(Body = monkeytux, Bucket = 'ds2002-kbv4nd', Key = 'monkeytux') #puts in bucket

pre_url = s3.generate_presigned_url("get_object", Params={'Bucket': "ds2002-kbv4nd", 'Key': "monkeytux"}, ExpiresIn = 604800)

print(pre_url)


