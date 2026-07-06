# Flask + MySQL Portfolio Website

This folder contains the original full-stack implementation of my portfolio website, developed as part of the **Interactive Media Management** program at Sheridan College.

Unlike the deployed static portfolio, this version demonstrates a database-driven architecture using Flask and MySQL.

---

## Features

- Flask web application
- MySQL database integration
- Dynamic project routing
- Database-driven portfolio content
- Responsive front-end
- Contact form with MySQL storage
- Environment variable configuration

---

## Tech Stack

- Python
- Flask
- MySQL
- HTML5
- CSS3
- JavaScript

---

## Project Structure

```text
flask_mysql_version/
│
├── app.py
├── portfolio_site.sql
├── requirements.txt
├── .env.example
│
├── static/
│
├── templates/
│
└── README.md
```

---

## Local Setup

### 1. Clone the repository

```bash
git clone <repository-url>
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Create a MySQL database

Import:

```text
portfolio_site.sql
```

### 4. Configure environment variables

Create a `.env` file using `.env.example` as a template.

Example:

```env
SECRET_KEY=your_secret_key

MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DB=portfolio_site

FLASK_DEBUG=True
```

### 5. Run the application

```bash
python app.py
```

The application will start locally, typically at:

```
http://127.0.0.1:5000
```

---

## Why a Static Version?

The public portfolio is deployed as a static website using GitHub Pages for simplicity, speed, and long-term maintainability.

This Flask + MySQL implementation is preserved as a technical reference demonstrating full-stack web development skills.

---

## Copyright

© Jing Lyu

All artwork, images, videos, and portfolio content remain the intellectual property of Jing Lyu.

This source code is provided for demonstration purposes only.