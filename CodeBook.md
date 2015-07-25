# CodeBook for Course Project New Tidy Dataset
Daniel Ang  
July 25, 2015  

This document is a code book for the data set contained in "newtidydataset.txt", which was generated using script "run_analysis.R".

The dataset contains 79 columns and 180 rows. Each row corresponds to a specific combination of the activity type and the experimental subject. Since there are 6 different activity types and 30 people who took part in the experiment, this results in 180 rows. 

The variable names (or column names) are the same as the `maindata` object generated in the script, which was taken from the original data set contained in the folder "UCI HAR Dataset". This is because each of the values in the columns (apart from the first two columns, `ActName` and `SubjectID` which describe the activity type and experimental subject) are averages of all cells in `maindata` which correspond to that particular combination of `ActName` and `SubjectID` (generated using the `aggregate()` and `mean` function, as explained in the README.md file).

All of the data was collected using the acclerometer and gyroscope on the Samsung Galaxy S smartphone on each of the test subjects.

We shall now describe each of the columns:

* Column 1: Activity  type. There are 6 possibilities: WALKING, WALKING_UPSTAIRS, etc.
* Column 2: Subject ID. There are 30 different subjects.
* Columns 3-8: averages of the means and standard deviations of the body linear acceleration of the subject as measured by the accelerometer on the smartphone in the X, Y, and Z directions. To prevent unnecessary clutter, we shall henceforth assume that all data is taken by the same kind of smartphone on the subject.
* Columns 9-14: averages of the means and standard deviations of measured gravitational acceleration in the X, Y, and Z directions
* Columns 15-20: averages of the means and standard deviations of the body acceleration derived in time to obtain a "jerk" signal in the X, Y, and Z directions
* Columns 21-26: averages of the means and standard deviations of the body detected using the gyroscope on the smartphone in the X, Y, and Z directions
* Columns 27-32: averages of the means and standard deviations of the gyroscope, derived in time to obtain a "jerk" signal in the X, Y, and Z direcitons
* Columns 33-34: averages of the means and standard deviations of the measured magnitude of the body acceleration.
* Columns 35-36: averages of the means and standard deviations of the measured magnitude of the gravitational acceleration.
* Columns 37-38: averages of the means and standard deviations of the measured magnitude of the "jerk" body acceleration.
* Columns 39-40: averages of the means and standard deviations of the measured magnitude of the gyroscope signal.
* Columns 40-41: averages of the means and standard deviations of the measured magnitude of the "jerk" gyroscope signal.
* Columns 43-48: similar to columns 3-8 (body acceleration), but the averages were calculated from signals that had a Fast Fourier Transform (FFT) applied to it.
* Columns 49-51: averages of the weighted average of the frequency components of the linear body acceleration in the X, Y, and Z directions to obtain a mean frequency.
* Columns 52-57: similar to columns 15-20 ("jerk" body acceleration), but the averages were calculated from signals that had a Fast Fourier Transform (FFT) applied to it.
* Columns 58-60: averages of the weighted average of the frequency components of the "jerk" body acceleration in the X, Y, and Z directions to obtain a mean frequency.
* Columns 61-66: similar to columns 21-26 (gyroscope signal), but the averages were calculated from signals that had a Fast Fourier Transform (FFT) applied to it.
* Columns 67-69: averages of the weighted average of the frequency components of the gyroscope signal in the X, Y, and Z directions to obtain a mean frequency.
* Columns 70-71: similar to columns 33-34 (magnitude of the body acceleration), but with FFT applied.
* Column 72: average of the weighted averages of the frequency components of the magnitude of the body acceleration
* Column 73-74: similar to columns 37-38 (magnitude of "jerk" body acceleration), but with FFT applied.
* Column 75: average of the weighted averages of the frequency components of the magnitude of the "jerk" body acceleration
* Columns 76-77: similar to columns 39-40 (magnitude of gyroscope signal), but with FFT applied.
* Column 78: average of the weighted averages of the frequency components of the magnitude of the gyroscope signal
* Columns 79-80: similar to columns 40-41 (magnitude of "jerk" gyroscope signal), but with FFT applied.
* Column 81: average of the weighted averages of the frequency components of the magnitude of the "jerk" gyroscope signal
