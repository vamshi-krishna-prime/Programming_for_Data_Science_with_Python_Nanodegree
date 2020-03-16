import time
import pandas as pd
import numpy as np

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york city': 'new_york_city.csv',
              'washington': 'washington.csv' }


def main():
    while True:
        city, month, day = get_filters()


if __name__ == "__main__":
	main()
