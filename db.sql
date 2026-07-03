DROP DATABASE IF EXISTS auction_db;
CREATE DATABASE auction_db;
USE auction_db;

-- superclass table of buyer and seller
CREATE TABLE USER (
    user_id INT AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

-- subclass of user
CREATE TABLE BUYER (
    user_id INT,
    shipping_address TEXT,
    max_bid_limit DECIMAL(10, 2),
    payment_token VARCHAR(255),
    bidder_status VARCHAR(50) DEFAULT 'Pending',
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE
);

--  sub class of user
CREATE TABLE SELLER (
    user_id INT,
    bank_acc VARCHAR(50) NOT NULL,
    bank_routing_no VARCHAR(50) NOT NULL,
    tax_id VARCHAR(50),
    rating DECIMAL(3, 2) DEFAULT 0.00,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE
);

CREATE TABLE AUCTION_HOUSE (
    house_id INT AUTO_INCREMENT,
    house_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    h_email VARCHAR(255) UNIQUE,
    PRIMARY KEY (house_id)
);

CREATE TABLE AUCTIONEVENT (
    event_id INT AUTO_INCREMENT,
    house_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    start_date_time DATETIME NOT NULL,
    end_date_time DATETIME NOT NULL,
    buyer_premium_percentage DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (event_id),
    FOREIGN KEY (house_id) REFERENCES AUCTION_HOUSE(house_id) ON DELETE CASCADE
);

CREATE TABLE CATEGORY (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE ITEM (
    item_id INT AUTO_INCREMENT,
    event_id INT NOT NULL,
    category_id INT NOT NULL,
    seller_id INT NOT NULL,
    lot_number INT NOT NULL,
    item_name VARCHAR(255) NOT NULL,
    description TEXT,
    starting_price DECIMAL(10, 2) NOT NULL,
    reserve_price DECIMAL(10, 2),
    PRIMARY KEY (item_id),
    FOREIGN KEY (event_id) REFERENCES AUCTIONEVENT(event_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id) ON DELETE RESTRICT,
    FOREIGN KEY (seller_id) REFERENCES SELLER(user_id) ON DELETE CASCADE
);

CREATE TABLE BID (
    item_id INT,
    bid_id INT,
    buyer_id INT NOT NULL,
    bid_amount DECIMAL(10, 2) NOT NULL,
    bid_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (item_id, bid_id),
    FOREIGN KEY (item_id) REFERENCES ITEM(item_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES BUYER(user_id) ON DELETE CASCADE
);

CREATE TABLE PAYMENT (
    payment_id INT AUTO_INCREMENT,
    item_id INT NOT NULL UNIQUE, 
    buyer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    transaction_date DATETIME NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (item_id) REFERENCES ITEM(item_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES BUYER(user_id) ON DELETE CASCADE
);

USE auction_db;

INSERT INTO USER (user_id, email, password, first_name, last_name, phone) VALUES
(1, 'emily23@gmail.com', 'pass1', 'John', 'Doe', '555-0101'),
(2, 'bsinger32@yahoo.com', 'pass2', 'Jane', 'Smith', '555-0102'),
(3, 'falafa@outlook.com', 'pass3', 'Robert', 'Brown', '555-0103'),
(4, 'cutsiepie@gmail.com', 'pass4', 'Emily', 'Davis', '555-0104'),
(5, 'michwil55@icloud.com', 'pass5', 'Michael', 'Wilson', '555-0105'),
(6, 'sarah576@gmail.com', 'pass6', 'Sarah', 'Miller', '555-0106'),   -- both buyer and seller
(7, 'TayDav4555@yahoo.com', 'pass7', 'David', 'Taylor', '555-0107'),   -- both buyer and seller
(8, 'ADny57J@gmail.com', 'pass8', 'Jessica', 'Anderson', '555-0108'),-- both buyer and seller
(9, 'sonotJames@outlook.com', 'pass9', 'James', 'Thomas', '555-0109'), -- both buyer and seller
(10, 'AmandyJack88@gmail.com', 'pass10', 'Amanda', 'Jackson', '555-0110'),-- both buyer and seller
(11, 'PendleA331@gmail.com', 'pass11', 'Arthur', 'Pendleton', '555-0201'),
(12, 'VanceBet44@yahoo.com', 'pass12', 'Beatrice', 'Vance', '555-0202'),
(13, 'Kingsleyhrels@gmail.com', 'pass13', 'Charles', 'Kingsley', '555-0203'),
(14, 'doenyp99@outlook.com', 'pass14', 'Daniel', 'Gould', '555-0204'),
(15, 'lastuser11@gmail.com', 'pass15', 'Eleanor', 'Russo', '555-0205');

-- uses User IDs 1 to 10
INSERT INTO BUYER (user_id, shipping_address, max_bid_limit, payment_token, bidder_status) VALUES
(1, '123 Main St, New York, NY', 5000.00, 'tok_1', 'Approved'),
(2, '456 Oak Ave, Los Angeles, CA', 15000.00, 'tok_2', 'Approved'),
(3, '789 Pine Rd, Chicago, IL', 2500.00, 'tok_3', 'Approved'),
(4, '321 Elm St, Houston, TX', 50000.00, 'tok_4', 'Approved'),
(5, '654 Maple Dr, Miami, FL', 1000.00, 'tok_5', 'Pending'),
(6, '987 Cedar Ln, Seattle, WA', 8000.00, 'tok_6', 'Approved'),      -- Overlapping
(7, '147 Birch Hwy, Boston, MA', 12000.00, 'tok_7', 'Approved'),     -- Overlapping
(8, '258 Walnut St, Denver, CO', 3500.00, 'tok_8', 'Approved'),      -- Overlapping
(9, '369 Ash Blvd, Phoenix, AZ', 20000.00, 'tok_9', 'Approved'),     -- Overlapping
(10, '951 Cherry Ct, Atlanta, GA', 6000.00, 'tok_10', 'Approved');   -- Overlapping

-- uses User IDs 6 to 15
INSERT INTO SELLER (user_id, bank_acc, bank_routing_no, tax_id, rating) VALUES
(6, 'acc_6', 'rout_6', 'tax-6', 4.8),    -- Overlapping
(7, 'acc_7', 'rout_7', 'tax-7', 4.5),    -- Overlapping
(8, 'acc_8', 'rout_8', 'tax-8', 4.9),    -- Overlapping
(9, 'acc_9', 'rout_9', 'tax-9', 4.2),    -- Overlapping
(10, 'acc_10', 'rout_10', 'tax-10', 4.7),-- Overlapping
(11, 'acc_11', 'rout_11', 'tax-11', 5.0),
(12, 'acc_12', 'rout_12', 'tax-12', 4.6),
(13, 'acc_13', 'rout_13', 'tax-13', 4.4),
(14, 'acc_14', 'rout_14', 'tax-14', 4.3),
(15, 'acc_15', 'rout_15', 'tax-15', 4.9);

INSERT INTO AUCTION_HOUSE (house_id, house_name, location, website, h_email) VALUES
(1, 'Manhattan Galleries', 'New York, NY', 'www.manhattan.com', 'info@manhattan.com'),
(2, 'Pacific Auctioneers', 'San Francisco, CA', 'www.pacific.com', 'contact@pacific.com'),
(3, 'Windy City Coins', 'Chicago, IL', 'www.windycity.com', 'sales@windycity.com'),
(4, 'Lone Star Auto Vault', 'Austin, TX', 'www.lonestar.com', 'bids@lonestar.com'),
(5, 'Gotham Manuscripts', 'Brooklyn, NY', 'www.gotham.com', 'catalog@gotham.com'),
(6, 'Emerald Jewelry Vault', 'Seattle, WA', 'www.emerald.com', 'appraisal@emerald.com'),
(7, 'New England Militaria', 'Boston, MA', 'www.newengland.com', 'history@newengland.com'),
(8, 'Southby Modern Furniture', 'Miami, FL', 'www.southby.com', 'consign@southby.com'),
(9, 'Atlantic Archeology', 'Philadelphia, PA', 'www.atlantic.com', 'admin@atlantic.com'),
(10, 'Rocky Mountain Sculpture', 'Denver, CO', 'www.rockymountain.com', 'gallery@rockymountain.com');

INSERT INTO AUCTIONEVENT (event_id, house_id, title, start_date_time, end_date_time, buyer_premium_percentage) VALUES
(1, 1, 'Spring Masterpieces', '2026-06-01 18:00:00', '2026-06-01 22:00:00', 25.00),
(2, 2, 'Luxury Estate Sale', '2026-06-05 10:00:00', '2026-06-07 18:00:00', 20.00),
(3, 3, 'Rare Gold Sovereigns', '2026-06-12 13:00:00', '2026-06-12 17:00:00', 18.50),
(4, 4, 'Vintage Muscle Cars', '2026-06-20 09:00:00', '2026-06-20 21:00:00', 12.00),
(5, 5, 'First Editions Showcase', '2026-06-25 14:00:00', '2026-06-25 19:00:00', 22.00),
(6, 6, 'Art Deco Watches', '2026-07-02 19:00:00', '2026-07-02 23:00:00', 25.00),
(7, 7, 'Historic Artifacts Event', '2026-07-10 11:00:00', '2026-07-10 16:00:00', 15.00),
(8, 8, 'Mid-Century Furniture Design', '2026-07-18 12:00:00', '2026-07-19 18:00:00', 20.00),
(9, 9, 'Ancient Relics Auction', '2026-07-25 15:00:00', '2026-07-25 20:00:00', 21.00),
(10, 10, 'Monolithic Bronze Statues', '2026-08-01 17:00:00', '2026-08-01 21:00:00', 24.00);

INSERT INTO CATEGORY (category_id, category_name) VALUES
(1, 'Fine Art'), (2, 'Jewelry'), (3, 'Coins'), (4, 'Automobiles'), (5, 'Books'),
(6, 'Furniture'), (7, 'Pottery'), (8, 'Militaria'), (9, 'Sculptures'), (10, 'Memorabilia');

-- using Seller IDs 6 through 15
INSERT INTO ITEM (item_id, event_id, category_id, seller_id, lot_number, item_name, description, starting_price, reserve_price) VALUES
(1, 1, 1, 11, 101, 'Monet Replica Study', 'Oil on canvas in an ornate frame.', 3500.00, 4500.00),
(2, 2, 2, 12, 405, 'Art Deco Diamond Ring', 'Platinum band with a 2-carat stone.', 5000.00, 6200.00),
(3, 3, 3, 13, 12, '1907 Double Eagle Coin', 'High-relief gold coin graded MS-64.', 8000.00, 9500.00),
(4, 4, 4, 14, 88, '1969 Camaro Yenko', 'Fully restored V8 muscle car.', 45000.00, 52000.00),
(5, 5, 5, 15, 204, 'Shakespeare Folio Leaf', 'Authentic paper fragment from 1632.', 1200.00, 1500.00),
(6, 6, 2, 6, 301, 'Rolex Submariner Ref 5513', 'Vintage 1970 dive watch.', 9000.00, 11000.00),         -- sold by overlapping user 6
(7, 7, 8, 7, 51, 'M1 Garand Rifle', 'Springfield production model dated 1943.', 1500.00, 1800.00),    -- sold by overlapping user 7
(8, 8, 6, 8, 112, 'Eames Lounge Chair', 'Original production in walnut leather.', 2200.00, 2800.00),  -- sold by overlapping user 8
(9, 9, 7, 9, 9, 'Zapotec Funerary Urn', 'Oaxaca Valley provenance.', 4000.00, 4800.00),               -- sold by overlapping user 9
(10, 10, 9, 10, 77, 'Bronze Torso Statue', 'Limited series foundry piece.', 6000.00, 7500.00);        -- sold by overlapping user 10

-- using Buyer IDs 1 through 10
INSERT INTO BID (item_id, bid_id, buyer_id, bid_amount, bid_timestamp) VALUES
(1, 1, 1, 3500.00, '2026-05-17 12:00:00'),
(1, 2, 2, 4600.00, '2026-05-17 12:05:00'),   -- buyer 1 and 2 can bid on the same item 
(2, 1, 4, 6500.00, '2026-05-17 12:10:00'),
(3, 1, 2, 9600.00, '2026-05-17 12:15:00'),         -- a buyer can bid on multible items
(4, 1, 4, 53000.00, '2026-05-17 12:20:00'),
(5, 1, 3, 1600.00, '2026-05-17 12:25:00'),
(6, 1, 7, 11500.00, '2026-05-17 12:30:00'), -- buyer 7 bidding on an item listed by Seller 6 , roles are swutched
(7, 1, 6, 1900.00, '2026-05-17 12:35:00'),  -- buyer 6 bidding on an item listed by Seller 7
(8, 1, 9, 3000.00, '2026-05-17 12:40:00'),
(9, 1, 10, 5000.00, '2026-05-17 12:45:00'),
(10, 1, 2, 7600.00, '2026-05-17 12:50:00');


INSERT INTO PAYMENT (payment_id, item_id, buyer_id, total_amount, payment_status, transaction_date) VALUES
(1, 1, 2, 5750.00, 'Completed', '2026-05-17 13:00:00'),
(2, 2, 4, 7800.00, 'Completed', '2026-05-17 13:05:00'),
(3, 3, 2, 11376.00, 'Completed', '2026-05-17 13:10:00'),
(4, 4, 4, 59360.00, 'Processing', '2026-05-17 13:15:00'),
(5, 5, 3, 1952.00, 'Completed', '2026-05-17 13:20:00'),
(6, 6, 7, 14375.00, 'Completed', '2026-05-17 13:25:00'),
(7, 7, 6, 2185.00, 'Failed', '2026-05-17 13:30:00'),
(8, 8, 9, 3600.00, 'Completed', '2026-05-17 13:35:00'),
(9, 9, 10, 6050.00, 'Completed', '2026-05-17 13:40:00'),
(10, 10, 2, 9424.00, 'Processing', '2026-05-17 13:45:00');

-- verification of inserted tables
USE auction_db;
SELECT * FROM USER;

SELECT * FROM BUYER;

SELECT * FROM SELLER;

SELECT * FROM AUCTION_HOUSE;

SELECT * FROM AUCTIONEVENT;

SELECT * FROM CATEGORY;

SELECT * FROM ITEM;

SELECT * FROM BID;

SELECT * FROM PAYMENT;

-- join statement
/*
	query automatically matches every recorded payment with the exact
    item name that was purchased and the full name of the buyer who paid for it
*/
USE auction_db;
SELECT 
    p.payment_id,
    CONCAT(u.first_name, ' ', u.last_name) AS buyer_name,
    i.item_name,
    p.total_amount,
    p.payment_status
FROM PAYMENT p
JOIN ITEM i ON p.item_id = i.item_id
JOIN USER u ON p.buyer_id = u.user_id;