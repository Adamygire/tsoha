from flask import Blueprint, flash, render_template, redirect, url_for, request
from werkzeug.security import generate_password_hash, check_password_hash
from . import db

bp = Blueprint('auth', __name__)

@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        name = request.form['name']
        error = None

        print(username, generate_password_hash(password), name)

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'
        elif not name:
            error = 'Name is required.'


        if error is None:
            try:
                db.session.execute(
                    "INSERT INTO users (username, password, name) VALUES (:username, :password,:name)",
                    {
                        'username': username, 
                        'password': generate_password_hash(password),
                        'name': name
                    },
                )
                db.session.commit()
            except db.IntegrityError:
                error = f"User {username} is already registered."
            else:
                return redirect(url_for("auth.register"))

        flash(error)

    return render_template('signup.html')

@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        db = db.py
        error = None
        user = db.execute(
            'SELECT * FROM user WHERE username = ?', (username,)
        ).fetchone()

        if user is None:
            error = 'Incorrect username.'
        elif not check_password_hash(user['password'], password):
            error = 'Incorrect password.'

        if error is None:
            db.session.clear()
            db.session['user_id'] = user['id']
            return redirect(url_for('index'))

        flash(error)

    return render_template('login.html')
