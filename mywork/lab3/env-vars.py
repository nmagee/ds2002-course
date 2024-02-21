#!/usr/bin/python3


import os

# Prompting input from the user
FAV_INSTRUMENT = input('What is your favorite instrument to play? ')
FAV_ARTIST = input('Who is your favorite artist? ')
YEARS_PLAY = input('How many years have you played the instrument for? ' )

# Setting the variables
os.environ["FAV_INSTRUMENT"] = FAV_INSTRUMENT
os.environ["FAV_ARTIST"] = FAV_ARTIST
os.environ["YEARS_PLAY"] = YEARS_PLAY

# Fetching and Printing
print(os.getenv("FAV_INSTRUMENT"))
print(os.getenv("FAV_ARTIST"))
print(os.getenv("YEARS_PLAY"))
