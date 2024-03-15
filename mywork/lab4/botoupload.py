#!/usr/bin/env python3


import urllib.request #from python.docs.org --> https://docs.python.org/3/library/urllib.request.html#module-urllib.request
import boto3

with urllib.request.urlopen("https://www.thevintagenews.com/wp-content/uploads/sites/65/2016/09/Crystall-640x515.jpg") as resp:
        monkeytux = resp.read()

s3 = boto3.client('s3', region_name='us-east-1') #client

resp = s3.put_object(Body = monkeytux, Bucket = 'ds2002-kbv4nd', Key = 'monkeytux') #puts in bucket

pre_url = s3.generate_presigned_url("get_object", Params={'Bucket': "ds2002-kbv4nd", 'Key': "monkeytux"}, ExpiresIn = 604800)

print(pre_url)

# Presigned URL: https://ds2002-kbv4nd.s3.amazonaws.com/monkeytux?AWSAccessKeyId=ASIAZQ3DQB5YOR7QTHCA&Signature=bcWhm%2Bbm1W0APorGjPA4nKVhP5g%3D&x-amz-security-token=FwoGZXIvYXdzEJ%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDGPbDPuY3kxvuDvysiLEAabKFprbWNwbN2p%2BOPeWOHJKXrUB0hrTg%2FUrvXyx%2FxslJQyiJjoobV72sbEzw%2FFy6Yj0%2FR7u2LV8maGicmJJgiVO53y%2BngvXZiUCTetgu3vIqprMbqdlXUlUs4jvPNayPMlsVRsboGRrqFW7GPgogbFiMqzyG5%2BQAbjdTmMGiVlFqyG5ak48rYTAY3OYo7g5W71rL1GNuqQw%2Bz7%2Bb%2FTCqVG7TTxSOLwrZZeHQSUytFbJe0ruGIn2%2FcOpO1enzMhgyBLziAwo%2FYDTrwYyLdBkYAd%2Bqjb3HDJrq9KPa%2BCqT3QhxvMKD7waBvh2Yarppl8%2BOTnUOpfa1ZBpig%3D%3D&Expires=1711144281
