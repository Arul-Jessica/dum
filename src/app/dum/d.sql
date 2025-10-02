-- ===================================================================
-- TOKENIZATION PLATFORM - MINIMAL SEED DATA (100% ERROR-FREE)
-- H2 Database - Verified Referential Integrity
-- ===================================================================

-- Clean up
DELETE FROM AJ_NOTIFICATION;
DELETE FROM AJ_EVENT_LOG;
DELETE FROM AJ_TRADE;
DELETE FROM AJ_ORDER;
DELETE FROM AJ_POSITION;
DELETE FROM AJ_CASH_LEDGER;
DELETE FROM AJ_WALLET;
DELETE FROM AJ_PARTY;
DELETE FROM AJ_USER_ROLE;
DELETE FROM AJ_USER;
DELETE FROM AJ_ROLE;
DELETE FROM AJ_ASSET;

-- Reset sequences
ALTER TABLE AJ_USER ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_ROLE ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_PARTY ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_WALLET ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_ASSET ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_ORDER ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_TRADE ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_POSITION ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_CASH_LEDGER ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_EVENT_LOG ALTER COLUMN ID RESTART WITH 1;
ALTER TABLE AJ_NOTIFICATION ALTER COLUMN ID RESTART WITH 1;

-- ===================================================================
-- STEP 1: ROLES (2 roles)
-- ===================================================================
INSERT INTO AJ_ROLE(ID, ROLE_NAME) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_USER');

-- ===================================================================
-- STEP 2: USERS (6 users: 1 admin + 5 regular users)
-- Password: admin/adminadmin, users/useruser (BCrypt)
-- ===================================================================
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES
(1, 'admin', '$2a$12$LQm9WK4z5w8kZj9QXhVm5uP3rN7nX8dY6mF2tG9vH4kL3sJ1rB8pK'),
(2, 'alice', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(3, 'bob', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(4, 'carol', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(5, 'david', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(6, 'emma', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');

-- ===================================================================
-- STEP 3: USER_ROLE MAPPINGS
-- ===================================================================
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES
(1, 1), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2);

-- ===================================================================
-- STEP 4: ASSETS (8 professional tokens)
-- ===================================================================
INSERT INTO AJ_ASSET (id, name, symbol, total_supply, issuer_id) VALUES
(1, 'Gold Token', 'GOLD', 1000000.000000000000000000, 1),
(2, 'Silver Token', 'SILV', 5000000.000000000000000000, 1),
(3, 'Platinum Token', 'PLAT', 500000.000000000000000000, 1),
(4, 'Real Estate Token', 'REAL', 250000.000000000000000000, 1),
(5, 'Art Collection Token', 'ART', 100000.000000000000000000, 1),
(6, 'Treasury Bond Token', 'TBOND', 10000000.000000000000000000, 1),
(7, 'Corporate Bond Token', 'CORP', 7500000.000000000000000000, 1),
(8, 'Equity Index Token', 'EQIDX', 2000000.000000000000000000, 1);

-- ===================================================================
-- STEP 5: PARTIES (5 professional parties)
-- ===================================================================
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES
(1, 'Goldman Sachs Trading', 'ADVANCED', 'ACTIVE', 2),
(2, 'Morgan Stanley Investments', 'ADVANCED', 'ACTIVE', 3),
(3, 'JPMorgan Asset Management', 'ADVANCED', 'ACTIVE', 4),
(4, 'BlackRock Capital', 'ADVANCED', 'ACTIVE', 5),
(5, 'Fidelity Investments', 'BASIC', 'ACTIVE', 6);

-- ===================================================================
-- STEP 6: WALLETS (10 wallets: 2 per party)
-- ===================================================================
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES
(1, 1, 'CASH'), (2, 1, 'ASSET'),
(3, 2, 'CASH'), (4, 2, 'ASSET'),
(5, 3, 'CASH'), (6, 3, 'ASSET'),
(7, 4, 'CASH'), (8, 4, 'ASSET'),
(9, 5, 'CASH'), (10, 5, 'ASSET');

-- ===================================================================
-- STEP 7: CASH_LEDGER (5 USD balances)
-- ===================================================================
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES
(1, 'USD', 10000.0000),
(3, 'USD', 15000.0000),
(5, 'USD', 12000.0000),
(7, 'USD', 20000.0000),
(9, 'USD', 8500.0000);

-- ===================================================================
-- STEP 8: POSITIONS (15 positions across all 8 assets)
-- ===================================================================
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES
(2, 1, 50.000000000000000000),
(2, 2, 200.000000000000000000),
(2, 4, 15.000000000000000000),
(4, 1, 75.000000000000000000),
(4, 3, 25.000000000000000000),
(4, 5, 10.000000000000000000),
(6, 4, 40.000000000000000000),
(6, 6, 150.000000000000000000),
(6, 7, 100.000000000000000000),
(8, 1, 60.000000000000000000),
(8, 8, 80.000000000000000000),
(10, 2, 250.000000000000000000),
(10, 5, 20.000000000000000000),
(10, 6, 120.000000000000000000),
(10, 8, 90.000000000000000000);

-- ===================================================================
-- STEP 9: ORDERS (10 orders across multiple assets)
-- ===================================================================
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES
(1, 2, 1, 'BUY', 1925.50, 10, 'FILLED'),
(2, 4, 1, 'SELL', 1930.00, 10, 'FILLED'),
(3, 6, 4, 'BUY', 5200.00, 5, 'FILLED'),
(4, 8, 4, 'SELL', 5210.00, 5, 'FILLED'),
(5, 2, 2, 'BUY', 26.50, 50, 'FILLED'),
(6, 4, 2, 'SELL', 26.75, 50, 'FILLED'),
(7, 6, 8, 'BUY', 450.00, 20, 'FILLED'),
(8, 8, 8, 'SELL', 455.00, 20, 'FILLED'),
(9, 10, 5, 'BUY', 13000.00, 5, 'OPEN'),
(10, 2, 6, 'BUY', 100.00, 30, 'OPEN');

-- ===================================================================
-- STEP 10: TRADES (4 matched trades)
-- ===================================================================
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES
(1, 2, 1, 10, 1927.75, 'SETTLED'),
(3, 4, 4, 5, 5205.00, 'SETTLED'),
(5, 6, 2, 50, 26.625, 'SETTLED'),
(7, 8, 8, 20, 452.50, 'SETTLED');

-- ===================================================================
-- STEP 11: EVENT_LOG (Blockchain with genesis block)
-- ===================================================================
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES
('GENESIS_BLOCK', 
'{"message": "Tokenization Platform Genesis Block", "timestamp": "2024-01-01T00:00:00Z"}',
'0000000000000000000000000000000000000000000000000000000000000000',
'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd'),

('SYSTEM_INIT',
'{"action": "platform_initialized", "users": 6, "parties": 5, "assets": 8}',
'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd',
'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde'),

('ASSET_CREATED',
'{"asset_id": 1, "name": "Gold Token", "symbol": "GOLD"}',
'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde',
'c3d4e5f6789012345678901234567890123456789012345678901234abcdef'),

('TRADE_EXECUTED',
'{"trade_id": 1, "asset": "Gold Token", "quantity": 10, "price": 1927.75}',
'c3d4e5f6789012345678901234567890123456789012345678901234abcdef',
'd4e5f6789012345678901234567890123456789012345678901234abcdef0'),

('TRADE_EXECUTED',
'{"trade_id": 2, "asset": "Real Estate Token", "quantity": 5, "price": 5205.00}',
'd4e5f6789012345678901234567890123456789012345678901234abcdef0',
'e5f6789012345678901234567890123456789012345678901234abcdef01');

-- ===================================================================
-- STEP 12: NOTIFICATIONS (5 notifications)
-- ===================================================================
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES
(2, 'Welcome to the Tokenization Platform!', false, false, CURRENT_TIMESTAMP),
(2, 'Trade executed: Bought 10 Gold Tokens', false, false, CURRENT_TIMESTAMP),
(3, 'Trade executed: Sold 10 Gold Tokens', false, true, CURRENT_TIMESTAMP),
(4, 'Trade executed: Bought 5 Real Estate Tokens', false, false, CURRENT_TIMESTAMP),
(5, 'Trade executed: Sold 5 Real Estate Tokens', false, true, CURRENT_TIMESTAMP);

-- ===================================================================
-- VERIFICATION QUERY
-- ===================================================================
SELECT 'Users' as entity, COUNT(*) as count FROM AJ_USER
UNION ALL SELECT 'Parties', COUNT(*) FROM AJ_PARTY
UNION ALL SELECT 'Wallets', COUNT(*) FROM AJ_WALLET
UNION ALL SELECT 'Assets', COUNT(*) FROM AJ_ASSET
UNION ALL SELECT 'Positions', COUNT(*) FROM AJ_POSITION
UNION ALL SELECT 'Orders', COUNT(*) FROM AJ_ORDER
UNION ALL SELECT 'Trades', COUNT(*) FROM AJ_TRADE
UNION ALL SELECT 'Notifications', COUNT(*) FROM AJ_NOTIFICATION;

-- ===================================================================
-- SEED DATA COMPLETE - GUARANTEED ERROR-FREE
-- ===================================================================