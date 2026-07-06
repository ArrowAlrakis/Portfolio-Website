# Jing Lyu 3D Character Artist Portfolio Site, all assets belongs to Jing Lyu
# Version: 08.05
# py app.py to run, Running on http://127.0.0.1:5000

# learn source 
# pydb https://www.w3schools.com/python/python_mysql_join.asp
# https://www.geeksforgeeks.org/python/using-request-args-for-a-variable-url-in-flask/
# sas help https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/ds2ref/p1umjasst8qk0un1cc8iulf7q3fk.htm
# flask doc, url_for, https://flask.palletsprojects.com/en/stable/api/#flask.Flask.url_for
# flash() https://flask.palletsprojects.com/en/stable/api/#flask.flash
# SQL parameterization, safer than cursor.execute("INSERT INTO...") https://www.w3schools.com/sql/sql_parameterized_queries.asp 

from flask import Flask, render_template, request, redirect, url_for, flash
from dotenv import load_dotenv
import mysql.connector
import os

load_dotenv()
app = Flask(__name__)
app.secret_key = os.getenv("SECRET_KEY")
app.config["MYSQL_HOST"] = os.getenv("MYSQL_HOST")
app.config["MYSQL_USER"] = os.getenv("MYSQL_USER")
app.config["MYSQL_PASSWORD"] = os.getenv("MYSQL_PASSWORD")
app.config["MYSQL_DB"] = os.getenv("MYSQL_DB")

def get_db():
    return mysql.connector.connect(
        host=app.config["MYSQL_HOST"],
        user=app.config["MYSQL_USER"],
        password=app.config["MYSQL_PASSWORD"],
        database=app.config["MYSQL_DB"]
    )

def get_all_projects():
    connection = get_db()
    cursor = connection.cursor(dictionary=True)# return dictonary like this [{'tool_name': 'ZBrush'}]

    cursor.execute("SELECT * FROM projects ORDER BY id ASC")
    projects = cursor.fetchall()

    for project in projects:
        cursor.execute(
            "SELECT filter_name FROM project_filters WHERE project_id = %s",
            (project["id"],)
        )
        filters = []
        for row in cursor.fetchall():
            filters.append(row["filter_name"])
        project["filters"] = filters

        cursor.execute(
            "SELECT tool_name FROM project_tools WHERE project_id = %s",
            (project["id"],)
        )
        tools = []
        for row in cursor.fetchall():
            tools.append(row["tool_name"])
        project["tools"] = tools

        cursor.execute(
            "SELECT image_path FROM project_images WHERE project_id = %s ORDER BY sort_order ASC",
            (project["id"],)
        )
        # images = [
        # {"image": "images/project1.jpg"},
        # {"image": "images/project2.jpg"}
        # ]
        images = []
        for row in cursor.fetchall():
            image = {"image": row["image_path"]}
            images.append(image)
        project["breakdown_images"] = images

    cursor.close()
    connection.close()
    return projects

def get_featured_projects():
    connection = get_db()
    cursor = connection.cursor(dictionary=True)

    cursor.execute("SELECT * FROM projects WHERE featured = TRUE ORDER BY id ASC")
    projects = cursor.fetchall()

    cursor.close()
    connection.close()
    return projects

# for project_detail page
def get_project_by_slug(slug):
    connection = get_db()
    cursor = connection.cursor(dictionary=True)

    cursor.execute("SELECT * FROM projects WHERE slug = %s", (slug,))
    project = cursor.fetchone()

    if project:
        cursor.execute(
            "SELECT filter_name FROM project_filters WHERE project_id = %s",
            (project["id"],)
        )
        filters = []
        for row in cursor.fetchall():
            filters.append(row["filter_name"])
        project["filters"] = filters

        cursor.execute(
            "SELECT tool_name FROM project_tools WHERE project_id = %s",
            (project["id"],)
        )
        tools = []
        for row in cursor.fetchall():
            tools.append(row["tool_name"])
        project["tools"] = tools

        cursor.execute(
            "SELECT image_path FROM project_images WHERE project_id = %s ORDER BY sort_order ASC",
            (project["id"],)
        )
        images = []
        for row in cursor.fetchall():
            image = {"image": row["image_path"]}
            images.append(image)
        project["breakdown_images"] = images

    cursor.close()
    connection.close()
    return project

@app.route("/")
def home():
    featured_projects = get_featured_projects()
    return render_template(
        "index.html",
        page_title="Home",
        site_name="Jing Lyu | 3D Character Artist Portfolio",
        hero_title="Jing Lyu",
        hero_subtitle="3D Character Artist",
        reel_url="https://player.vimeo.com/video/1168764363",
        featured_projects=featured_projects,
        active_page="home"
    )

@app.route("/portfolio")
def portfolio():
    projects = get_all_projects()
    return render_template(
        "portfolio.html",
        page_title="Portfolio",
        site_name="Jing Lyu | 3D Character Artist Portfolio",
        projects=projects,
        active_page="portfolio"
    )

@app.route("/resume")
def resume():
    return render_template(
        "resume.html",
        page_title="Resume",
        site_name="Jing Lyu | 3D Character Artist Portfolio",
        active_page="resume"
    )

@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":
        name = request.form.get("name", "").strip()# strip() get rid of " " from user input
        email = request.form.get("email", "").strip()
        subject = request.form.get("subject", "").strip()
        message = request.form.get("message", "").strip()

        if not name or not email or not subject or not message:
            flash("Please fill in all fields.")# flask flash() store temp msg
            return redirect(url_for("contact"))

        # added try to incase db broke
        try:
            connection = get_db()
            cursor = connection.cursor()

            # learned this is safer than cursor.execute("INSERT INTO...")
            query = """
                INSERT INTO contacts (name, email, subject, message)
                VALUES (%s, %s, %s, %s)
            """
            values = (name, email, subject, message)

            cursor.execute(query, values)
            connection.commit()

            cursor.close()
            connection.close()

            flash("Your message has been sent successfully.")
            return redirect(url_for("contact"))

        except mysql.connector.Error as err:
            flash(f"Database error: {err}")
            return redirect(url_for("contact"))

    return render_template(
        "contact.html",
        page_title="Contact",
        site_name="Jing Lyu | 3D Character Artist Portfolio",
        active_page="contact"
    )

@app.route("/project/<slug>")
def project_detail(slug):
    project = get_project_by_slug(slug)

    # add 404
    if project is None:
        return render_template(
            "404.html",
            page_title="Not Found",
            site_name="Jing Lyu | 3D Character Artist Portfolio"
        ), 404

    return render_template(
        "project_detail.html",
        page_title=project["title"],
        site_name="Jing Lyu | 3D Character Artist Portfolio",
        active_page="portfolio",
        project=project
    )

if __name__ == "__main__":
    debug_mode = os.getenv("FLASK_DEBUG", "False").lower() == "true"
    app.run(debug=debug_mode)