# Lab 7 - Structured Query Language (SQL)

## Setup

To work with MySQL you have three options:

1. Use the Amazon RDS instance you created before spring break.
2. Use the instructor's RDS instance. Endpoint and credentials can be found [here]().
3. For more advanced users who want a challenge, use a MySQL Docker container. Instructions are below:

A. As we did in class, run MySQL in a container on your laptop using the following command.
    ```
    docker run -e MYSQL_ROOT_PASSWORD=abc123 -d mysql
    ```
    To connect to the container, find the ID of the running container:
    ```
    docker ps
    ```
    Connect to that container interactively by referring to its ID, and calling up the `bash` shell like this:
    ```
    docker exec -it b7c5d3 bash
    ```

B. Open a connection to the MysQL database by using the `mysql` command and using the root password you used when creating the container.
    ```
    mysql -u root -p
    ```
    You will be prompted for the root password, which you passed in as an `ENV` variable when you issued the `docker run` command.

## Create a new database and table

This project will create a simple database to track inventory and progress on processing datasets. Imagine there are 100 data files that must go through a multi-stage process and this DB is designed to keep a clear inventory of each file and where each one stands in the process.

First, create a database in a `create` statement. Name it the same as your UVA computind ID:
```
create database mst3k;
```

Next, select your database by name in a `use` statement:
```
use mst3k;
```
Then create a table:
```
CREATE TABLE `tracking` (`id` INT NOT NULL AUTO_INCREMENT , `file` VARCHAR(50) NULL , `owner` VARCHAR(30) NULL , `updated` DATE NULL , `step` INT NULL , `source` VARCHAR(30) NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
```
Run the `describe tracking;` command to see the schema for this table:

```
+---------+-------------+------+-----+---------+----------------+
| Field   | Type        | Null | Key | Default | Extra          |
+---------+-------------+------+-----+---------+----------------+
| id      | int         | NO   | PRI | NULL    | auto_increment |
| file    | varchar(50) | YES  |     | NULL    |                |
| owner   | varchar(30) | YES  |     | NULL    |                |
| updated | date        | YES  |     | NULL    |                |
| step    | int         | YES  |     | NULL    |                |
| source  | varchar(30) | YES  |     | NULL    |                |
+---------+-------------+------+-----+---------+----------------+
```
For purposes of inserting mock data, here are some suggestions:

- `file` - A simple file name. Imagine these are `.csv` files.
- `owner` - The user ID of the researcher who is working with the data.
- `updated` - A date for when the last step occurred with this data. This takes `YYYY-MM-DD` format.
- `step` - An integer indicating which step of the workflow was completed most recently (e.g. 1-7).
- `source` - The name of the data source.

## Insert data

Add data to your new table. Here is a sample entry you can use:

```
INSERT INTO `tracking` (`id`, `file`, `owner`, `updated`, `step`, `source`) VALUES (NULL, 'BkJrynaRf4gu.csv', 'mst3k', '2024-02-08', '4', 'NSF');
```
**Repeat this process and create at least 20 entries in your table.** Be sure to vary your `owner` field to use 3-4 different owners, a few different sources, and a few different dates.

Here's an example of data:

```
+----+------------------------+-------+------------+------+--------+
| id | file                   | owner | updated    | step | source |
+----+------------------------+-------+------------+------+--------+
|  1 | BkJrynaRf4gu.csv       | nem2p | 2024-02-08 |    4 | NSF    |
|  2 | 6gN5rc9z4YVx.csv       | mst3k | 2022-08-31 |    7 | NIH    |
|  3 | tc1pZ6EPPsxgtc1pZ6.csv | mst3k | 2023-03-13 |    6 | NSF    |
|  4 | 4vCTppoBU.csv          | nem2p | 2024-01-30 |    4 | NOAA   |
|  5 | sofowror23542.csv      | nem2p | 2024-03-28 |    1 | USGS   |
|  6 | 1a2b3c4d5e.csv         | nem2p | 2024-03-28 |    1 | USGS   |
|  7 | 2b3c4d5e6f.csv         | nem2p | 2024-03-28 |    1 | USGS   |
|  8 | 3c4d5e6f7g.csv         | nem2p | 2024-03-24 |    2 | USGS   |
|  9 | aa3c4d5e6f7g.csv       | jaj   | 2024-03-21 |    2 | NSF    |
| 10 | zz3c4d5e6f7g.csv       | jaj   | 2024-03-04 |    3 | NSF    |
| 11 | qq3c4d5e6f7g.csv       | jaj   | 2024-03-14 |    2 | NSF    |
| 12 | wrelktjyl3k45j.csv     | jaj   | 2024-01-12 |    5 | NSF    |
| 13 | 634yl3k45j.csv         | nem2p | 2024-01-12 |    5 | NSF    |
| 14 | th634bbyla3k4.csv      | nem2p | 2024-01-12 |    4 | USGS   |
| 15 | 1824absdfs.csv         | nem2p | 2022-09-13 |    6 | NIH    |
| 16 | 23942fweorif.csv       | nem2p | 2022-09-13 |    6 | NIH    |
| 17 | alfkwerljweflksd.csv   | nem2p | 2022-09-13 |    5 | NIH    |
| 18 | 41bafa.csv             | nem2p | 2021-09-11 |    5 | NSF    |
| 19 | 1j9flwer.csv           | mst3k | 2021-09-11 |    5 | NSF    |
| 20 | 2345lkjwlfkjwsfl.csv   | mst3k | 2023-10-14 |    5 | NIH    |
+----+------------------------+-------+------------+------+--------+
```

## Query your table

Now practice some SQL queries:

Select all records but put them in date order:
```
SELECT * FROM tracking ORDER BY updated ASC;
```

Select all columns and records for a specific owner:
```
SELECT * FROM tracking WHERE owner = 'jaj';
```

Select just `id` and `file` for a specific year:
```
SELECT id, file FROM tracking WHERE updated LIKE '2021%';
```

Select all columns for a range of values and order by the owner and then the updated date:
```
SELECT * FROM tracking WHERE id < 12 AND id > 7 ORDER BY owner, updated;
```

Select just the first 5 records of a query:
```
SELECT * FROM tracking LIMIT 5;
```

Update a record. Let's change the owner of a specific row, using the `id` to specify which row. This `SET`s the new value, based on a `WHERE` condition:

```
UPDATE tracking SET owner='jaj' WHERE id=4;
```
Delete a record. Let's delete a record based on a specific row `id`:

```
DELETE FROM tracking WHERE id=19;
```

Take some time to practice more SELECT, INSERT, DELETE, and UPDATE queries.

## Create a second table and add data

Since you are using unique user IDs for the `owner` field, you already have a key you can use to relate to a second table. Create a new table named `owners` using this query:

```
CREATE TABLE `owners` (`owner` VARCHAR(8) NULL , `name` VARCHAR(30) NULL , `joined` DATE NULL , `training` BOOLEAN NULL ) ENGINE = InnoDB;
```
Run this command and then `describe` the new table:

```
mysql> describe owners;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| owner    | varchar(8)  | YES  |     | NULL    |       |
| name     | varchar(30) | YES  |     | NULL    |       |
| joined   | date        | YES  |     | NULL    |       |
| training | tinyint(1)  | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
```

Here are the fields:

- `owner` - is the computing ID of the owner, which you have been using in the `tracking` table.
- `name` - is their real name, first and last.
- `joined` - is a date for when the owner joined the research group.
- `training` - is a boolean for whether they have completed required training. Values should be 0 (no) or 1 (yes).

Now insert a new record into `owners` for each of the fictitious owners you added to the `tracking` table. To retrieve a list of all the unique owners in your `tracking` table, there is a SQL query for that!

```
SELECT DISTINCT owner FROM tracking;
```

Using those values, insert a record into `owners` for each:

```
INSERT INTO `owners` (`owner`, `name`, `joined`, `training`) VALUES ('jaj', 'Jim Jokl', '1991-12-01', '1');
```

Complete one entry per owner, so that you have a completed `owners` table. Be sure some of your researchers have completed the training and some have not:
```
mysql> select * from owners;
+-------+-----------------+------------+----------+
| owner | name            | joined     | training |
+-------+-----------------+------------+----------+
| nem2p | Neal Magee      | 2016-12-01 |        1 |
| jaj   | Jim Jokl        | 1991-12-01 |        1 |
| mst3k | Mystery Science | 2021-04-13 |        0 |
+-------+-----------------+------------+----------+
```

## Query using JOIN statements

Finally, let's write a JOIN statement that relates both the `tracking` and `owners` tables. Imagine we simply want a list of data files, with the real name of the owner for each.

To get a full `JOIN` of both tables joined, this is a first step:
```
SELECT * FROM tracking JOIN owners ON tracking.owner=owners.owner;
```

But the results are repetitive with regard to the `owners` data on the right-hand side:
```
mysql> SELECT * FROM tracking JOIN owners ON tracking.owner=owners.owner;
+----+------------------------+-------+------------+------+--------+-------+-----------------+------------+----------+
| id | file                   | owner | updated    | step | source | owner | name            | joined     | training |
+----+------------------------+-------+------------+------+--------+-------+-----------------+------------+----------+
|  1 | BkJrynaRf4gu.csv       | nem2p | 2024-02-08 |    4 | NSF    | nem2p | Neal Magee      | 2016-12-01 |        1 |
|  2 | 6gN5rc9z4YVx.csv       | mst3k | 2022-08-31 |    7 | NIH    | mst3k | Mystery Science | 2021-04-13 |        0 |
|  3 | tc1pZ6EPPsxgtc1pZ6.csv | mst3k | 2023-03-13 |    6 | NSF    | mst3k | Mystery Science | 2021-04-13 |        0 |
|  4 | 4vCTppoBU.csv          | jaj   | 2024-01-30 |    4 | NOAA   | jaj   | Jim Jokl        | 1991-12-01 |        1 |
|  5 | sofowror23542.csv      | nem2p | 2024-03-28 |    1 | USGS   | nem2p | Neal Magee      | 2016-12-01 |        1 |
|  6 | 1a2b3c4d5e.csv         | nem2p | 2024-03-28 |    1 | USGS   | nem2p | Neal Magee      | 2016-12-01 |        1 |
|  7 | 2b3c4d5e6f.csv         | nem2p | 2024-03-28 |    1 | USGS   | nem2p | Neal Magee      | 2016-12-01 |        1 |
|  8 | 3c4d5e6f7g.csv         | nem2p | 2024-03-24 |    2 | USGS   | nem2p | Neal Magee      | 2016-12-01 |        1 |
. . .
```

But we want to narrow our results by selecting fewer columns. To do this we need a special join called a `LEFT JOIN`. The best way to visualize this is to think of your "primary" table (which would be `tracking` in this case) on the left, and your `owners` reference list on the right.

Here is the query broken into multiple lines with line numbers:
```
1    SELECT 
2      tracking.file, owners.name
3    FROM tracking 
4    LEFT JOIN owners
5      ON tracking.owner=owners.owner;
```

Some notes:

- Line 2 - select specific columns from each of your two tables with `table_name.column_name`
- Line 3 - you still select `FROM` a primary table, but then follow it with 
- Line 4 - a join of the secondary table, which will serve as a resource to populate the query.
- Line 5 - finally, you must map the "relation", i.e. the column from one table that matches up with a value in the other table.

Notice in your output that the `name` field is populated with a real name, not a user ID.

### Your Turn

Now write a query that lists the `file`, `step`, and owner `name` for researchers who have NOT yet completed the training. Order the results by ascending order from the `updated` column.

Run the query to test or debug your results.

## Submit your work

Save your query as a GitHub gist https://gist.github.com/ and submit the URL to your gist in the field within Canvas.
