![divvy](https://user-images.githubusercontent.com/49973760/76811158-8cdbb680-6816-11ea-8835-43f1e635ccda.jpg)

# Explore US Bikeshare Data
In this project, I made use of Python to explore data related to bike share systems for three major cities in the United States—Chicago, New York City, and Washington. Written code to import the data and answer interesting questions about it by computing descriptive statistics. Also wrote a script that takes in raw input to create an interactive experience in the terminal to present these statistics.

## Project overview:
Over the past decade, bicycle-sharing systems have been growing in number and popularity in cities across the world. Bicycle-sharing systems allow users to rent bicycles on a very short-term basis for a price. This allows people to borrow a bike from point A and return it at point B, though they can also return it to the same location if they'd like to just go for a ride. Regardless, each bike can serve several users per day.

Thanks to the rise in information technologies, it is easy for a user of the system to access a dock within the system to unlock or return bicycles. These technologies also provide a wealth of data that can be used to explore how these bike-sharing systems are used.

In this project, you will use data provided by [Motivate](https://www.motivateco.com/), a bike share system provider for many major cities in the United States, to uncover bike share usage patterns. You will compare the system usage between three large cities: Chicago, New York City, and Washington, DC.

## The Datasets:
All three of the data files contain the same core six (6) columns:
* Start Time (e.g., 2017-01-01 00:07:57)
* End Time (e.g., 2017-01-01 00:20:53)
* Trip Duration (in seconds - e.g., 776)
* Start Station (e.g., Broadway & Barry Ave)
* End Station (e.g., Sedgwick St & North Ave)
* User Type (Subscriber or Customer)

The Chicago and New York City files also have the following two columns:
* Gender
* Birth Year

## Statistics Computed:
Analyzed the data related to bike share use in Chicago, New York City, and Washington by computing a variety of descriptive statistics. In this project, written code to provide the following information:

##### 1. Popular times of travel (i.e., occurs most often in the start time):
* most common month
* most common day of week
* most common hour of day

##### 2. Popular stations and trip:
* most common start station
* most common end station
* most common trip from start to end (i.e., most frequent combination of start station and end station)

##### 3. Trip duration:
* total travel time
* average travel time

##### 4. User info:
* counts of each user type
* counts of each gender (only available for NYC and Chicago)
* earliest, most recent, most common year of birth (only available for NYC and Chicago)


## Technologies Used:
+ **Python**
    > Used Python programming language to explore data related to bikeshare.

+ **Numpy and Pandas**
    > Used to explore and manipulate DataFrames and performed statistical analysis.

+ **Visual Studio Code**
    > Used to make exploratory analysis and write appropriate SQL queries to answer the posed questions.

+ **Git Version Control**
    > Used to control and record the project files. Shared the work on GitHub profile.


### Project Rubric

The project must meet all the requirements mentioned in the rubric for the submission to pass.

#### **Code Quality**

| CRITERIA | MEETS SPECIFICATIONS |
| ------ | ------ |
| Functionality of code | All code cells can be run without error. |
| Choice of data types and structures | Appropriate data types (e.g. strings, floats) and data structures (e.g. lists, dictionaries) are chosen to carry out the required analysis tasks. |
| Use of loops and conditional statements | Loops and conditional statements are used to process the data correctly. |
| Use of packages | Packages are used to carry out advanced tasks. |
| Use of functions | Functions are used to reduce repetitive code. |
| Use of good coding practices | Docstrings, comments, and variable names enable readability of the code. |

#### **Script and Questions**

| CRITERIA | MEETS SPECIFICATIONS |
| ------ | ------ |
| Solicit and handle raw user input | Raw input is solicited and handled correctly to guide the interactive question-answering experience; no errors are thrown when unexpected input is entered. |
| Use descriptive statistics to answer questions about the data. Raw data is displayed upon request by the user. | Descriptive statistics are correctly computed and used to answer the questions posed about the data. Raw data is displayed upon request by the user in this manner: Script should prompt the user if they want to see 5 lines of raw data, display that data if the answer is 'yes', and continue these prompts and displays until the user says 'no'. |

#### **Suggestions to Make the Project Stand Out!**

| Submission Phase, Reviewer Tips | 
| ------------ |
| Change the structure of bikeshare.py to make the code more efficient or in better style. | |
| Ask and answer additional questions about the data beyond the questions already provided. |  |
| Make the interactive experience wow-worthy! Add images, make it into a web app, etc. (If you do create a web app, make sure to include clear directions how to execute it.) Make it your own! |  |


## Standouts:

```The script is structured well and passed the pycodestyle```


## Software requirements:
To complete this project, the following software requirements apply:
* You should have Python 3, NumPy, and pandas installed using Anaconda
* A text editor, like Sublime or Atom.
* A terminal application (Terminal on Mac and Linux or Cygwin on Windows).


## Acknowledgement:
Thanks to the [Udacity](https://www.udacity.com/) platform for providing the [Programming for Data Science with Python Nanodegree](https://www.udacity.com/course/programming-for-data-science-nanodegree--nd104) program.
