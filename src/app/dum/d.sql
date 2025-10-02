-- H2 Database Seed File - Simple and Direct
-- Password for admin: adminadmin
-- Password for all users: useruser

-- Insert Roles
INSERT INTO AJ_ROLE(ID, ROLE_NAME) VALUES (1, 'ROLE_ADMIN');
INSERT INTO AJ_ROLE(ID, ROLE_NAME) VALUES (2, 'ROLE_USER');

-- Insert Users
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (1, 'admin', '$2a$12$LQm9WK4z5w8kZj9QXhVm5uP3rN7nX8dY6mF2tG9vH4kL3sJ1rB8pK');
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (2, 'alice', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (3, 'bob', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (4, 'carol', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (5, 'david', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES (6, 'emma', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');

-- Insert User Roles
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (1, 1);
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (2, 2);
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (3, 2);
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (4, 2);
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (5, 2);
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES (6, 2);

-- Insert Assets
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (1, 'Gold Token', 'GOLD', 1000000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (2, 'Silver Token', 'SILV', 5000000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (3, 'Platinum Token', 'PLAT', 500000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (4, 'Real Estate Token', 'REAL', 250000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (5, 'Art Collection Token', 'ART', 100000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (6, 'Treasury Bond Token', 'TBOND', 10000000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (7, 'Corporate Bond Token', 'CORP', 7500000, 1);
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES (8, 'Equity Index Token', 'EQIDX', 2000000, 1);

-- Insert Parties
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES (1, 'Goldman Sachs Trading', 'ADVANCED', 'ACTIVE', 2);
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES (2, 'Morgan Stanley Investments', 'ADVANCED', 'ACTIVE', 3);
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES (3, 'JPMorgan Asset Management', 'ADVANCED', 'ACTIVE', 4);
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES (4, 'BlackRock Capital', 'ADVANCED', 'ACTIVE', 5);
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES (5, 'Fidelity Investments', 'BASIC', 'ACTIVE', 6);

-- Insert Wallets
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (1, 1, 'CASH');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (2, 1, 'ASSET');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (3, 2, 'CASH');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (4, 2, 'ASSET');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (5, 3, 'CASH');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (6, 3, 'ASSET');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (7, 4, 'CASH');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (8, 4, 'ASSET');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (9, 5, 'CASH');
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES (10, 5, 'ASSET');

-- Insert Cash Ledger
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES (1, 'USD', 10000);
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES (3, 'USD', 15000);
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES (5, 'USD', 12000);
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES (7, 'USD', 20000);
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES (9, 'USD', 8500);

-- Insert Positions
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (2, 1, 50);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (2, 2, 200);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (2, 4, 15);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (4, 1, 75);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (4, 3, 25);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (4, 5, 10);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (6, 4, 40);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (6, 6, 150);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (6, 7, 100);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (8, 1, 60);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (8, 8, 80);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (10, 2, 250);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (10, 5, 20);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (10, 6, 120);
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES (10, 8, 90);

-- Insert Orders
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (1, 2, 1, 'BUY', 1925.50, 10, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (2, 4, 1, 'SELL', 1930.00, 10, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (3, 6, 4, 'BUY', 5200.00, 5, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (4, 8, 4, 'SELL', 5210.00, 5, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (5, 2, 2, 'BUY', 26.50, 50, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (6, 4, 2, 'SELL', 26.75, 50, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (7, 6, 8, 'BUY', 450.00, 20, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (8, 8, 8, 'SELL', 455.00, 20, 'FILLED');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (9, 10, 5, 'BUY', 13000.00, 5, 'OPEN');
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES (10, 2, 6, 'BUY', 100.00, 30, 'OPEN');

-- Insert Trades
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES (1, 2, 1, 10, 1927.75, 'SETTLED');
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES (3, 4, 4, 5, 5205.00, 'SETTLED');
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES (5, 6, 2, 50, 26.625, 'SETTLED');
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES (7, 8, 8, 20, 452.50, 'SETTLED');

-- Insert Event Log
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES ('GENESIS_BLOCK', '{"message": "Genesis Block"}', '0000000000000000000000000000000000000000000000000000000000000000', 'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd');
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES ('SYSTEM_INIT', '{"users": 6, "parties": 5}', 'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd', 'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde');
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES ('ASSET_CREATED', '{"asset_id": 1}', 'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde', 'c3d4e5f6789012345678901234567890123456789012345678901234abcdef');
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES ('TRADE_EXECUTED', '{"trade_id": 1}', 'c3d4e5f6789012345678901234567890123456789012345678901234abcdef', 'd4e5f6789012345678901234567890123456789012345678901234abcdef0');
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES ('TRADE_EXECUTED', '{"trade_id": 2}', 'd4e5f6789012345678901234567890123456789012345678901234abcdef0', 'e5f6789012345678901234567890123456789012345678901234abcdef01');

-- Insert Notifications
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES (2, 'Welcome to the platform', false, false, CURRENT_TIMESTAMP);
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES (2, 'Trade executed successfully', false, false, CURRENT_TIMESTAMP);
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES (3, 'Trade completed', false, true, CURRENT_TIMESTAMP);
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES (4, 'Order filled', false, false, CURRENT_TIMESTAMP);
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES (5, 'Settlement complete', false, true, CURRENT_TIMESTAMP);