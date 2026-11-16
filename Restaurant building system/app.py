from flask import Flask, render_template, request, redirect
import mysql.connector
from datetime import datetime

app = Flask(__name__)

# DB Connection
db = mysql.connector.connect(
    host="localhost",
    user="root",          # use your DB username
    password="Thenu",          # your DB password
    database="RestaurantDB"
)
cursor = db.cursor(dictionary=True)

@app.route('/')
def home():
    return render_template('rbs.html')
@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/menus')
def menus():
    return render_template('menus.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/menu', methods=['GET'])
def menu():
    cursor.execute("SELECT * FROM Menu")
    items = cursor.fetchall()
    return render_template('menu.html', menu_items=items)

@app.route('/order', methods=['POST'])
def order():
    customer_name = request.form.get('name')
    customer_phone = request.form.get('phone')
    table_id = int(request.form.get('table_id'))
    
    selected_items = request.form.getlist('item')
    quantities = request.form.getlist('quantity')
    
    # Save customer
    cursor.execute("INSERT INTO Customer (name, phone) VALUES (%s, %s)", (customer_name, customer_phone))
    customer_id = cursor.lastrowid
    
    # Create order
    cursor.execute("INSERT INTO Orders (table_id) VALUES (%s)", (table_id,))
    order_id = cursor.lastrowid
    
    # Add items
    total_amount = 0
    for item_id, qty in zip(selected_items, quantities):
        cursor.execute("SELECT price FROM Menu WHERE item_id = %s", (item_id,))
        price = cursor.fetchone()['price']
        total_amount += price * int(qty)
        cursor.execute("INSERT INTO OrderItems (order_id, item_id, quantity) VALUES (%s, %s, %s)", 
                       (order_id, item_id, qty))
    
    # Add payment
    cursor.execute("INSERT INTO Payment (order_id, customer_id, amount, payment_method) VALUES (%s, %s, %s, %s)",
                   (order_id, customer_id, total_amount, "Cash"))

    db.commit()

    return render_template("bill.html", amount=total_amount, order_id=order_id, customer_name=customer_name)

if __name__ == '__main__':
    app.run(debug=True)
