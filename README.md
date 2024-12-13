# Advent of Code

## Day 1

### Data Input
Advent of code provided a static data set of two columns seperated by 3 spaces. I added column headers, this was a good opportunity to learn that you can customize the .csv seperator in the dbt_project.yml or a .yml file in the seeds directory. I therefore specified that the delimeter was three spaces.

### Transform
The day 1 challenge was fairly straightforward - I split the input into two CTEs each consisting of one of the columns of the inputs added a row number ordered by the value in the column that could be used in a join term to join on record position and then compute the absolute difference between the two columns in each row. As the next step was an aggregation that impacted the granularity of the data, I split the final sum() of the absolute differences into their own model. I then inputed my aggregated value into the site to pick up my first gold star.

## Day 2

### Data Input
Another static file that could be seeded, I added column headers, and used my `properties.yml` in the seed directory to specify that the delimeter in this instance was a single space.

The provided data is a row for each record with varying amounts of values in them so some columns are nulled. It probably makes sense to unpivot this data maintaining a record_id and removing NULL values. I can then use a combination of window functions and LAG to satisfy the requirement and count the number of records that have values that either ascend or descend in one direction only throughout AND the difference between two sequential values within the records is at least 1 and 3 at most. 

### Transform

First I split the data into two paths as the logic required to check differences between rows was different (setting the default start value) depending on if the record was ascending or descending. Once classified I unpivotted both streams. I then brought the two streams back together with a union but filtering the rows to where the difference between current row and previous row met the conditions of the challenge for the entire record. Finally I counted the rows to get the answer.
