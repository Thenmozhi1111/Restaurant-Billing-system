CREATE DATABASE RestaurantDB;
USE RestaurantDB;

-- Table for Restaurant Tables
CREATE TABLE Tables (
    table_id INT AUTO_INCREMENT PRIMARY KEY,
    table_number INT NOT NULL,
    capacity INT NOT NULL,
    is_reserved BOOLEAN DEFAULT FALSE
);

-- Table for Menu Items
CREATE TABLE Menu (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(6, 2) NOT NULL,
    category VARCHAR(50)
);

-- Table for Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    table_id INT,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES Tables(table_id)
);

-- Table for Order Details
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    amount DECIMAL(8, 2) NOT NULL,
    payment_method VARCHAR(50),
    payment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

select * from Tables;

-- Insert Tables
INSERT INTO Tables (table_number, capacity) VALUES (1, 4), (2, 2), (3, 6);

-- Insert Menu Items
INSERT INTO Menu (name, price, category) VALUES
-- Appetizers
('Spring Rolls', 50.00, 'Appetizers'),
('Chicken Satay', 55.00, 'Appetizers'),
('Bruschetta', 45.00, 'Appetizers'),
('Hummus with Pita', 42.00, 'Appetizers'),
('Stuffed Mushrooms', 48.00, 'Appetizers'),
('Deviled Eggs', 38.00, 'Appetizers'),
('Paneer Tikka', 52.00, 'Appetizers'),
('Garlic Bread', 40.00, 'Appetizers'),

-- Soups
('Tomato Basil Soup', 35.00, 'Soups'),
('Chicken Noodle Soup', 38.00, 'Soups'),
('Hot and Sour Soup', 40.00, 'Soups'),
('Cream of Mushroom', 37.00, 'Soups'),
('Miso Soup', 36.00, 'Soups'),
('Lentil Soup (Dal)', 34.00, 'Soups'),
('Corn Chowder', 39.00, 'Soups'),
('Thai Coconut Soup', 41.00, 'Soups'),

-- Snacks
('French Fries', 30.00, 'Snacks'),
('Samosa', 20.00, 'Snacks'),
('Nachos with Cheese', 32.00, 'Snacks'),
('Popcorn', 25.00, 'Snacks'),
('Onion Rings', 28.00, 'Snacks'),
('Pakoras', 26.00, 'Snacks'),
('Chicken Nuggets', 33.00, 'Snacks'),
('Veggie Sandwich', 35.00, 'Snacks'),

-- Main Dishes
('Butter Chicken', 70.00, 'Main Dish'),
('Spaghetti Carbonara', 68.00, 'Main Dish'),
('Grilled Salmon with Lemon Butter', 85.00, 'Main Dish'),
('Paneer Tikka Masala', 72.00, 'Main Dish'),
('Beef Stroganoff', 80.00, 'Main Dish'),
('Chicken Alfredo Pasta', 74.00, 'Main Dish'),
('Vegetable Biryani', 90.00, 'Main Dish'),
('Teriyaki Chicken Bowl', 75.00, 'Main Dish'),

-- Drinks
('Mango Lassi', 28.00, 'Drinks'),
('Iced Matcha Latte', 32.00, 'Drinks'),
('Fresh Lime Soda', 18.00, 'Drinks'),
('Strawberry Smoothie', 30.00, 'Drinks'),
('Cold Brew Coffee', 29.00, 'Drinks'),
('Masala Chai', 22.00, 'Drinks'),
('Watermelon Juice', 24.00, 'Drinks'),
('Virgin Mojito', 26.00, 'Drinks'),

-- Desserts
('Chocolate Lava Cake', 50.00, 'Desserts'),
('Gulab Jamun', 38.00, 'Desserts'),
('Cheesecake', 48.00, 'Desserts'),
('Tiramisu', 52.00, 'Desserts'),
('Rasmalai', 40.00, 'Desserts'),
('Apple Pie', 45.00, 'Desserts'),
('Brownies', 43.00, 'Desserts'),
('Panna Cotta', 49.00, 'Desserts');

select * from Menu;
