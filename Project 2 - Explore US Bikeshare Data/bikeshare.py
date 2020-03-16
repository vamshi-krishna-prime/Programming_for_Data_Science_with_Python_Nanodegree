import time
import pandas as pd
import numpy as np
import json

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york': 'new_york_city.csv',
              'washington': 'washington.csv' }


class text():
    def spin(self, string, num):
        self.clear = "\b"*(8 + len(string))
        for _ in range(num):
            for ch in '-\\|/':
                print('__' + '('+ ch + ')' + string + '(' + ch + ')' + '_', end='', flush=True)
                time.sleep(0.1)
                print(self.clear, end='', flush=True)


def print_spin(message, num):
    fido = text()
    fido.spin(message, num)


def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    
    print('\n')
    print_spin('Bikeshare', 8)
    print('_(/)Bikeshare(/)______________________________')
    print(' Hello! Let\'s explore some US bikeshare data! '.center(78, '='))
    # get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    city = None
    city_filter = ['chicago', 'new york', 'washington']
    while city not in city_filter:
        city = input("\nFilter data by city\n[ Chicago, New York or Washington ] : ").lower()

    # get user input for month (all, january, february, ... , june)
    month = None
    month_filter = ['all', 'january', 'february', 'march', 'april', 'may', 'june']
    while month not in month_filter:
        month = input("\nFilter data by month\n[ all, january, february, march, april, may, or june ] : ").lower()

    # get user input for day of week (all, monday, tuesday, ... sunday)
    day = None
    day_filter = ['all', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    while day not in day_filter:
        day = input("\nFilter data by day of the week\n['all', 'sunday', 'monday', ...., 'saturday'] : ").lower()


    print('-'*78, '\n')
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """
    print()
    print(' Filters applied : [ {}, {}, {}] '.format(city, month, day).center(78, '*'))
    print()

    # load data file into a dataframe
    df = pd.read_csv(CITY_DATA[city])

    # convert the Start Time column to datetime
    df['Start Time'] = pd.to_datetime(df['Start Time'])

    # extract month and day of week from Start Time to create new columns
    df['month'] = df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.day_name()

    # filter by month if applicable
    if month != 'all':
        # use the index of the months list to get the corresponding int
        months = ['january', 'february', 'march', 'april', 'may', 'june']
        month = months.index(month) + 1

        # filter by month to create the new dataframe
        df = df[df['month'] == month]

    # filter by day of week if applicable
    if day != 'all':
        # filter by day of week to create the new dataframe
        df = df[df['day_of_week'] == day.title()]

    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    if 'Start Time' in df.columns:
        print()
        print(' Calculating The Most Frequent Times of Travel '.center(78, '='))
        start_time = time.time()
        # convert the Start Time column to datetime
        df['Start Time'] = pd.to_datetime(df['Start Time'])

        
        # display the most common month
        # -------------------START--------------------------
        # extract month from the Start Time column to create an month column
        df['month'] = df['Start Time'].dt.month

        # find the most most common month
        popular_month = df['month'].mode()[0]
        print('Most common Month'.ljust(40, '.'), popular_month)
        # --------------------END---------------------------

        
        # display the most common day of week
        # -------------------START--------------------------
        # extract day from the Start Time column to create an day_of_week column
        df['day_of_week'] = df['Start Time'].dt.day_name()

        # find the most common day of week
        popular_day = df['day_of_week'].mode()[0]
        print('Most common day of the week'.ljust(40, '.'), popular_day)
        # --------------------END---------------------------


        # find the most common start hour
        # -------------------START--------------------------
        # extract hour from the Start Time column to create an hour column
        df['hour'] = df['Start Time'].dt.hour

        # display the most common start hour
        popular_hour = df['hour'].mode()[0]
        print('Most common Start Hour'.ljust(40, '.'), popular_hour)
        # --------------------END---------------------------


        print("\nThis took %s seconds." % (time.time() - start_time))
        print('-'*78, '\n')


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""
    
    print()
    print(' Calculating The Most Popular Stations and Trip '.center(78, '='))
    start_time = time.time()
    print(' Station Stats '.center(78, '-'))

    # display most commonly used start station
    if 'Start Station' in df.columns:
        # -------------------START--------------------------
        print('Most commonly used Start station '.ljust(40, '.'), df['Start Station'].mode()[0])
        # --------------------END---------------------------


    # display most commonly used end station
    if 'End Station' in df.columns:
        # -------------------START--------------------------
        print('Most commonly used End station '.ljust(40, '.'), df['End Station'].mode()[0])
        # --------------------END---------------------------


    # display most frequent combination of start station and end station trip
    if 'Start Station' in df.columns and 'End Station' in df.columns:
        # -------------------START--------------------------
        df['route'] = df['Start Station'] + ' -> ' + df['End Station']
        print('Most frequent route '.ljust(40, '.'), df['route'].mode()[0])
        # --------------------END---------------------------


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*78, '\n')


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""
    
    print()
    if 'Trip Duration' in df.columns:
        print(' Calculating Trip Duration '.center(78, '='))
        start_time = time.time()

        # Trip Duration stats:
        # -------------------START--------------------------
        print(' Trip Duration stats '.center(78, '-'))
        print('Max Travel Time '.ljust(40, '.'), df['Trip Duration'].max())
        print('Min Travel Time '.ljust(40, '.'), df['Trip Duration'].min())
        # display mean travel time
        print('Avg Travel Time '.ljust(40, '.'), df['Trip Duration'].mean())
        print('Most Travel Time '.ljust(40, '.'), df['Trip Duration'].mode()[0])
        # display total travel time
        print('Total Travel Time '.ljust(40, '.'), df['Trip Duration'].sum())
        # --------------------END---------------------------

        print("\nThis took %s seconds." % (time.time() - start_time))
        print('-'*78, '\n')


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print()
    print(' Calculating User Stats '.center(78, '='))
    start_time = time.time()


    # Display user stats
    # -------------------START--------------------------
    # Display counts of user types
    if 'User Type' in df.columns:
        print(' User type stats '.center(78, '-'))
        print(df['User Type'].value_counts())
        # print()
    # Display counts of gender
    if 'Gender' in df.columns:
        print(' Gender stats '.center(78, '-'))
        df['Gender'].replace(np.nan, 'not disclosed', inplace=True)
        print(df['Gender'].value_counts(dropna=False))
        # print()
    # Display earliest, most recent, and most common year of birth
    if 'Birth Year' in df.columns:
        print(' Age stats '.center(78, '-'))
        print('Earliest Birth Year '.ljust(40, '.'), int(df['Birth Year'].min()))
        print('Most recent Birth Year '.ljust(40, '.'), int(df['Birth Year'].max()))
        print('Most common Birth Year '.ljust(40, '.'), int(df['Birth Year'].mode()[0]))
    # --------------------END---------------------------


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*78, '\n')


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)

        # Display raw_data
        row = 5
        raw_data = input('Would you like to see raw data? Enter (yes / no) : ').lower()
        df['Start Time'] = df['Start Time'].dt.strftime('%Y-%m-%d %H:%M:%S')
        # print(df.info()) for testing
        while raw_data == 'yes':
            # print(df.head(5).to_dict('index')) displays first 5 rows as dictionary
            print(json.dumps(df.head(row).to_dict('index'), indent = 1))
            raw_data = input('Would you like to see more raw data? Enter (yes / no) : ').lower()
            row += 5
        
        restart = input('\nWould you like to restart? Enter (yes / no) : ').lower()
        if restart.lower() != 'yes':
            print()
            print(' Python Script Terminated '.center(78, '*'))
            print()
            break


if __name__ == "__main__":
	main()
