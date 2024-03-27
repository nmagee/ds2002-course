# Data Project 1: Build a Data-driven API

In this Data Project you will build on your FastAPI code by providing data dynamically to your API.

- The database will be a MySQL RDS instance running in AWS.
- The API will be your FastAPI instance running in a container.
- The container will be running in Amazon EC2.
- Finally, a simple web page will display your API data visually.

## 1. Setup

This data project assumes you have successfully completed **Lab 6** and that pushes to your `fastapi-demo` repository build container images successfully. If you have not completed this step, you must before you can continue.

You may either develop/test your code locally or using Gitpod. There is no preference, though more advanced students who want the challenge may choose to develop locally.

### Set Environment Variables

1. Follow the instructions found at this page in Canvas and set your `DBHOST`, `DBUSER`, and `DBPASS` environment variables.
2. You will need to inject these same variables into your container when you run it in Amazon EC2 near the end of this project.

These `ENV` variables provide a server, username, and password for your code to communicate with the MySQL service.

### Python Installation

At the end of your `requirements.txt` file you should add an entry:
```
mysqlclient
```
And then in your environment (local computer or Gitpod) run this command:
```
python3 -m pip install mysqlclient
```

This installation allows you to import the `MySQLdb` package for database communications.

If you are developing locally and run into installation problems with this package, you'll need to Google around for a working solution.

## Update your `Dockerfile`

The `Dockerfile` in your project needs a few more pieces of software for database communications. Add the second line below so that your entire `Dockerfile` looks like this:

```
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-alpine3.14
RUN apk add musl-dev mariadb-connector-c-dev gcc
COPY ./app /app
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt
```

### Python Imports

Add the following entries to the top of your `app/main.py` file:

```
import json   # if not already present
import os
import MySQLdb
from fastapi.staticfiles import StaticFiles
```
These imports let you use environment variables within your code, communicate with the MySQL database service, and will enable FastAPI to display a simple HTML page (see below).

Next, below your instantiation of the `app = FastAPI()` object, enter these lines:

```
app.mount("/static", StaticFiles(directory="static"), name="static")

HOST = os.environ.get('DBHOST')
USER = os.environ.get('DBUSER')
PASS = os.environ.get('DBPASS')
```
These lines configure FastAPI to display static pages and populate three new variables with the `ENV` variables you set above.


### Static Files

Within the `app/` directory of your FastAPI, create a new subdirectory named `static`. Inside of it, copy these three files:

- [`index.html`](static/index.html) - A simple framework to display your API data for humans.
- [`script.js`](static/script.js) - The logic of the page that communicates with your API.
- [`styles.css`](static/styles.css) - A stylesheet for decorating the HTML file.

These files will dynamically communicate with your API to fetch data and display it in a human-readable page.

Take the time to read through the code and see what you can understand.

The static page configuration now means that your FastAPI deployment has an additional endpoint: `/static/index.html` appended to your API's URL will display this page.

## 2. Database Prep

1. Run a PhpMyAdmin container either locally or in Gitpod using these instructions. Connect to the RDS instance using these credentials. This will give you a GUI for interacting with your database.

2. Following the instructions from class, create a new database (if you haven't already) with your UVA user ID as the name (i.e. `nem2p` or `mst3k` etc.)

3. Click into your database on the left. Using the "Create new table" field on the page, create a table named `albums` with 5 columns.

4. Click on the "SQL" tab at the top of the screen. You will be given a large text box to run SQL queries against your database. 
Copy this script and paste **BUT EDIT** the name of the database before `albums` (where it says `mst3k` below replace it with your DB name) and then press GO.

    ```
    CREATE TABLE `mst3k`.`albums` (`id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(30) NULL , `artist` VARCHAR(30) NULL , `genre` VARCHAR(15) NULL , `year` INT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
    ```

5. The command should execute quickly and you will see your `albums` table appear on the left. Click into that. Note that it is empty, i.e. it has no records.

6. Click on the INSERT tab at the top of the screen. Using the top form entry, add a favorite album of yours to the database. Leave the ID entry empty, but add an album NAME, ARTIST, GENRE, and YEAR. Then press GO to save it.

7. Next let's add more entries using direct SQL. Click into the SQL tab again. Copy the code below and modify it for another entry. The `id` should have the value of `NULL` (no quotes) and the `year` should have a 4-digit integer value (no quotes):

    ```
    INSERT INTO `albums`(
        `id`, 
        `name`, 
        `artist`, 
        `genre`, 
        `year`
    ) VALUES (
        NULL,
        '<ALBUM-NAME>',
        '<ALBUM-ARTIST>',
        '<ALBUM-GENRE>',
        '<ALBUM-YEAR>'
    )
    ```

    Here's an example entry:

    ```
    INSERT INTO `albums`(
        `id`, 
        `name`, 
        `artist`, 
        `genre`, 
        `year`
    ) VALUES (
        NULL,
        'Wincing the Night Away',
        'The Shins',
        'indie',
        2007
    )

8. Repeat this process until you have 10 entries in your database.

## 3. Connect FastAPI to the Database

You have now installed the necessary libraries and software for FastAPI to communicate with a database, you have updated your `Dockerfile` to match those changes, and you have created a data table with data in it.

Now let's write a new API endpoint that will retrieve your table data and return it in JSON.

1. Create a new FastAPI endpoint decorator `("/albums)` using the **GET** method. Add a new function below it with a unique name. It does not require a parameter.

    ```
    @app.get("/albums")
    def get_albums():
    ```

2. Next, as part of your function, set up a database connection. This will be a `MySQLdb.connection` object, which means you can reuse the connection and all of its available methods. Use the connection string below but **update** your `db` name.

    ```
        db = MySQLdb.connect(host=HOST, user=USER, passwd=PASS, db="mst3k")
    ```
3. Next we will create a cursor, which is what executes SQL against the database service. The cursor will then execute some SQL and fetch the results. Copy this code and paste it below your DB connection string:

    ```
    c = db.cursor(MySQLdb.cursors.DictCursor)
    c.execute("""SELECT * FROM albums ORDER BY name""")
    results = c.fetchall()
    ```

    Notice the SQL here selects all rows from your `albums` table and orders them alphabetically by album name. It is wrapped in triple quotes as a visual cue to developers (but regular quotes are fine)

4. At this point you can test your results by adding a final line:

    ```
    return results
    ```
    And then run `./preview.sh` in either Gitpod or locally. Using either the Gitpod URL or your local `http://127.0.0.1:8000/` address, add `/albums` to the URL and check for your albums to be returned. The server will display your data in JSON format. This is because your cursor was declared as a `DictCursor` and therefor returned data arrays as dictionaries, which Python can easily convert into JSON.

    ![API image rendering](https://s3.amazonaws.com/ds2002-resources/images/albums-json.png)

5. However, if you were to add more entries to your DB table at this point and refresh the API page, you would not see any new values. This is because the database connection has been opened and the query executed, but the connection was not closed, so no new fetch will occur.

    To close the connection, add this line before your `return`:

    ```
    db.close()
    return results
    ```

    Closing connections after each request is a healthy practice for all data scientists and developers. Connections left open take up possible connections used elsewhere, and remain open until they time out.

6. Now test your API by adding another album entry to the database and see if your endpoint returns the new results.

7. View the results of a simple JavaScript web page pointed to this API. Add the following endpoint to the end of your Gitpod or local URL:

    ```
    /static/index.html
    ```

    You will see something like this:
    ![API image rendering](https://s3.amazonaws.com/ds2002-resources/images/api-results.png)