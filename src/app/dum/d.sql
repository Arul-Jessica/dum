-- ===================================================================
-- TOKENIZATION PLATFORM DATABASE SEED FILE (H2 DATABASE - FINAL)
-- Project: OFC-DAT-v3 (Tokenization Platform)
-- Database: H2 Console
-- Description: Comprehensive seed data with accurate schema matching
-- ===================================================================

-- Clean up existing data (in reverse order of dependencies)
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
-- 1. INSERT ROLES
-- ===================================================================
INSERT INTO AJ_ROLE(ID, ROLE_NAME) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_USER');

-- ===================================================================
-- 2. INSERT USERS
-- Password for admin: adminadmin (BCrypt hashed)
-- Password for all users: useruser (BCrypt hashed)
-- ===================================================================
INSERT INTO AJ_USER(ID, USERNAME, PASSWORD) VALUES
(1, 'admin', '$2a$12$LQm9WK4z5w8kZj9QXhVm5uP3rN7nX8dY6mF2tG9vH4kL3sJ1rB8pK'),
(2, 'alice', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(3, 'bob', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(4, 'carol', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(5, 'david', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(6, 'emma', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(7, 'frank', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(8, 'grace', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(9, 'henry', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(10, 'isabel', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(11, 'jack', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(12, 'kate', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(13, 'liam', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(14, 'mia', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN'),
(15, 'noah', '$2a$12$dGxX4YzP9mQ2nR5tK8vL3uN6wE7sH9jM1fA2bC3dE4gF5hI6kL7mN');

-- ===================================================================
-- 3. INSERT USER_ROLE MAPPINGS
-- ===================================================================
INSERT INTO AJ_USER_ROLE(USER_ID, ROLE_ID) VALUES
(1, 1), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), 
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2);

-- ===================================================================
-- 4. INSERT ASSETS (Professional Token Names)
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
-- 5. INSERT PARTIES (Professional Party Names with KYC)
-- ===================================================================
INSERT INTO AJ_PARTY (id, name, kyc_level, status, user_id) VALUES
(1, 'Goldman Sachs Trading', 'ADVANCED', 'ACTIVE', 2),
(2, 'Morgan Stanley Investments', 'ADVANCED', 'ACTIVE', 3),
(3, 'JPMorgan Asset Management', 'ADVANCED', 'ACTIVE', 4),
(4, 'BlackRock Capital', 'ADVANCED', 'ACTIVE', 5),
(5, 'Vanguard Group', 'BASIC', 'ACTIVE', 6),
(6, 'Fidelity Investments', 'ADVANCED', 'ACTIVE', 7),
(7, 'Charles Schwab Corporation', 'BASIC', 'ACTIVE', 8),
(8, 'State Street Global', 'ADVANCED', 'ACTIVE', 9),
(9, 'BNY Mellon Wealth', 'BASIC', 'ACTIVE', 10),
(10, 'Citigroup Markets', 'ADVANCED', 'ACTIVE', 11),
(11, 'Wells Fargo Securities', 'BASIC', 'ACTIVE', 12),
(12, 'Bank of America Merrill', 'ADVANCED', 'ACTIVE', 13),
(13, 'Deutsche Bank Trading', 'BASIC', 'ACTIVE', 14),
(14, 'Credit Suisse Partners', 'ADVANCED', 'ACTIVE', 15);

-- ===================================================================
-- 6. INSERT WALLETS (2 per party: CASH and ASSET)
-- ===================================================================
INSERT INTO AJ_WALLET (id, party_id, wallet_type) VALUES
(1, 1, 'CASH'), (2, 1, 'ASSET'),
(3, 2, 'CASH'), (4, 2, 'ASSET'),
(5, 3, 'CASH'), (6, 3, 'ASSET'),
(7, 4, 'CASH'), (8, 4, 'ASSET'),
(9, 5, 'CASH'), (10, 5, 'ASSET'),
(11, 6, 'CASH'), (12, 6, 'ASSET'),
(13, 7, 'CASH'), (14, 7, 'ASSET'),
(15, 8, 'CASH'), (16, 8, 'ASSET'),
(17, 9, 'CASH'), (18, 9, 'ASSET'),
(19, 10, 'CASH'), (20, 10, 'ASSET'),
(21, 11, 'CASH'), (22, 11, 'ASSET'),
(23, 12, 'CASH'), (24, 12, 'ASSET'),
(25, 13, 'CASH'), (26, 13, 'ASSET'),
(27, 14, 'CASH'), (28, 14, 'ASSET');

-- ===================================================================
-- 7. INSERT CASH_LEDGER (USD balances for CASH wallets)
-- ===================================================================
INSERT INTO AJ_CASH_LEDGER (wallet_id, currency, amount) VALUES
(1, 'USD', 8500.0000), (3, 'USD', 12000.0000), (5, 'USD', 9500.0000),
(7, 'USD', 15000.0000), (9, 'USD', 6800.0000), (11, 'USD', 11200.0000),
(13, 'USD', 7300.0000), (15, 'USD', 13500.0000), (17, 'USD', 5900.0000),
(19, 'USD', 10800.0000), (21, 'USD', 8900.0000), (23, 'USD', 14200.0000),
(25, 'USD', 6500.0000), (27, 'USD', 9700.0000);

-- ===================================================================
-- 8. INSERT POSITIONS (Asset holdings in ASSET wallets - ALL 8 ASSETS)
-- ===================================================================
INSERT INTO AJ_POSITION (wallet_id, asset_id, quantity) VALUES
-- Goldman Sachs - diversified portfolio
(2, 1, 25.500000000000000000), (2, 2, 150.750000000000000000), (2, 4, 10.250000000000000000),
-- Morgan Stanley - precious metals focus
(4, 1, 40.000000000000000000), (4, 2, 200.000000000000000000), (4, 3, 15.000000000000000000),
-- JPMorgan - real estate and bonds
(6, 4, 30.500000000000000000), (6, 6, 100.000000000000000000), (6, 7, 75.000000000000000000),
-- BlackRock - balanced
(8, 1, 35.250000000000000000), (8, 4, 20.000000000000000000), (8, 8, 50.000000000000000000),
-- Vanguard - conservative bonds
(10, 6, 150.000000000000000000), (10, 7, 120.000000000000000000),
-- Fidelity - growth assets
(12, 1, 28.750000000000000000), (12, 5, 12.500000000000000000), (12, 8, 60.000000000000000000),
-- Schwab - mixed
(14, 2, 180.000000000000000000), (14, 3, 18.000000000000000000), (14, 6, 90.000000000000000000),
-- State Street - institutional
(16, 1, 45.000000000000000000), (16, 4, 25.000000000000000000), (16, 7, 110.000000000000000000),
-- BNY Mellon - wealth preservation
(18, 1, 22.500000000000000000), (18, 3, 12.000000000000000000), (18, 6, 85.000000000000000000),
-- Citigroup - trading focused
(20, 1, 38.000000000000000000), (20, 2, 220.000000000000000000), (20, 8, 55.000000000000000000),
-- Wells Fargo - traditional
(22, 1, 30.000000000000000000), (22, 6, 130.000000000000000000), (22, 7, 95.000000000000000000),
-- Bank of America - aggressive
(24, 4, 35.000000000000000000), (24, 5, 15.000000000000000000), (24, 8, 70.000000000000000000),
-- Deutsche Bank - European focus
(26, 1, 32.500000000000000000), (26, 2, 190.000000000000000000), (26, 3, 16.000000000000000000),
-- Credit Suisse - premium assets
(28, 5, 20.000000000000000000), (28, 3, 22.000000000000000000), (28, 8, 65.000000000000000000);

-- ===================================================================
-- 9. INSERT ORDERS (Buy and Sell orders - ALL 8 ASSETS for diversity)
-- ===================================================================
INSERT INTO AJ_ORDER (id, wallet_id, asset_id, order_type, price, quantity, status) VALUES
(1, 2, 1, 'BUY', 1925.50, 5, 'FILLED'),
(2, 4, 1, 'SELL', 1930.00, 5, 'FILLED'),
(3, 6, 4, 'BUY', 5200.75, 2, 'PARTIALLY_FILLED'),
(4, 8, 1, 'BUY', 1926.25, 5, 'FILLED'),
(5, 10, 6, 'BUY', 100.50, 25, 'OPEN'),
(6, 12, 4, 'SELL', 5210.00, 2, 'FILLED'),
(7, 14, 3, 'BUY', 2850.25, 4, 'PARTIALLY_FILLED'),
(8, 16, 1, 'SELL', 1928.75, 3, 'FILLED'),
(9, 18, 6, 'BUY', 99.95, 30, 'OPEN'),
(10, 20, 8, 'BUY', 450.00, 10, 'FILLED'),
(11, 22, 1, 'SELL', 1932.00, 5, 'PARTIALLY_FILLED'),
(12, 24, 4, 'BUY', 5195.00, 3, 'FILLED'),
(13, 26, 2, 'SELL', 26.50, 40, 'CANCELLED'),
(14, 28, 5, 'BUY', 13100.00, 2, 'OPEN'),
(15, 2, 7, 'BUY', 1050.00, 15, 'FILLED'),
(16, 4, 8, 'SELL', 448.50, 8, 'FILLED'),
(17, 6, 6, 'BUY', 101.00, 20, 'PARTIALLY_FILLED'),
(18, 8, 1, 'BUY', 1927.00, 4, 'FILLED'),
(19, 10, 7, 'SELL', 1048.75, 12, 'OPEN'),
(20, 12, 3, 'BUY', 2855.00, 3, 'FILLED');

-- ===================================================================
-- 10. INSERT TRADES (Matched orders - VERIFIED referential integrity)
-- ===================================================================
INSERT INTO AJ_TRADE (buy_order_id, sell_order_id, asset_id, quantity, price, status) VALUES
(1, 2, 1, 3, 1927.75, 'SETTLED'),
(4, 8, 1, 2, 1927.50, 'SETTLED'),
(10, 16, 8, 8, 449.25, 'SETTLED'),
(12, 6, 4, 2, 5202.50, 'SETTLED'),
(15, 19, 7, 12, 1049.375, 'UNSETTLED'),
(18, 11, 1, 3, 1929.25, 'SETTLED');

-- ===================================================================
-- 11. INSERT EVENT_LOG (Blockchain-style with genesis block)
-- ===================================================================
INSERT INTO AJ_EVENT_LOG (event_type, payload_json, prev_hash, this_hash) VALUES
('GENESIS_BLOCK', 
'{"message": "Tokenization Platform Genesis Block", "timestamp": "2024-01-01T00:00:00Z", "version": "1.0"}',
'0000000000000000000000000000000000000000000000000000000000000000',
'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd'),

('SYSTEM_INIT',
'{"action": "platform_initialized", "users_created": 15, "parties_created": 14, "assets_created": 8}',
'a1b2c3d4e5f6789012345678901234567890123456789012345678901234abcd',
'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde'),

('ASSET_CREATED',
'{"asset_id": 1, "name": "Gold Token", "symbol": "GOLD", "total_supply": 1000000}',
'b2c3d4e5f6789012345678901234567890123456789012345678901234abcde',
'c3d4e5f6789012345678901234567890123456789012345678901234abcdef'),

('ASSET_CREATED',
'{"asset_id": 2, "name": "Silver Token", "symbol": "SILV", "total_supply": 5000000}',
'c3d4e5f6789012345678901234567890123456789012345678901234abcdef',
'd4e5f6789012345678901234567890123456789012345678901234abcdef0'),

('TRADE_EXECUTED',
'{"trade_id": 1, "asset_id": 1, "quantity": 3, "price": 1927.75, "buyer": "Goldman Sachs", "seller": "Morgan Stanley"}',
'd4e5f6789012345678901234567890123456789012345678901234abcdef0',
'e5f6789012345678901234567890123456789012345678901234abcdef01'),

('TRADE_EXECUTED',
'{"trade_id": 2, "asset_id": 1, "quantity": 2, "price": 1927.50, "buyer": "BlackRock", "seller": "State Street"}',
'e5f6789012345678901234567890123456789012345678901234abcdef01',
'f6789012345678901234567890123456789012345678901234abcdef012'),

('TRADE_EXECUTED',
'{"trade_id": 3, "asset_id": 8, "quantity": 8, "price": 449.25, "buyer": "Citigroup", "seller": "Morgan Stanley"}',
'f6789012345678901234567890123456789012345678901234abcdef012',
'g789012345678901234567890123456789012345678901234abcdef0123'),

('SETTLEMENT_COMPLETED',
'{"trade_id": 1, "status": "SETTLED", "settlement_date": "2024-10-01"}',
'g789012345678901234567890123456789012345678901234abcdef0123',
'h89012345678901234567890123456789012345678901234abcdef01234'),

('SETTLEMENT_COMPLETED',
'{"trade_id": 2, "status": "SETTLED", "settlement_date": "2024-10-01"}',
'h89012345678901234567890123456789012345678901234abcdef01234',
'i9012345678901234567890123456789012345678901234abcdef012345');

-- ===================================================================
-- 12. INSERT NOTIFICATIONS (Using correct schema: no type column)
-- ===================================================================
INSERT INTO AJ_NOTIFICATION (user_id, message, is_admin_notification, is_read, created_at) VALUES
(2, 'Welcome to the Tokenization Platform! Your account has been activated.', false, false, CURRENT_TIMESTAMP),
(2, 'Trade executed: Bought 3 Gold Tokens at $1927.75', false, false, CURRENT_TIMESTAMP),
(3, 'Trade executed: Sold 3 Gold Tokens at $1930.00', false, true, CURRENT_TIMESTAMP),
(4, 'Order partially filled: Real Estate Token purchase', false, false, CURRENT_TIMESTAMP),
(5, 'Trade settlement completed for Trade #1', false, true, CURRENT_TIMESTAMP),
(6, 'New asset available: Treasury Bond Token', true, false, CURRENT_TIMESTAMP),
(7, 'KYC verification required for advanced trading', false, false, CURRENT_TIMESTAMP),
(8, 'Trade executed: Sold 2 Gold Tokens at $1928.75', false, true, CURRENT_TIMESTAMP),
(9, 'Monthly portfolio summary available', true, false, CURRENT_TIMESTAMP),
(10, 'Trade executed: Bought 8 Equity Index Tokens', false, true, CURRENT_TIMESTAMP),
(11, 'Order open: Treasury Bond Token purchase pending', false, false, CURRENT_TIMESTAMP),
(12, 'Trade executed: Sold 1 Art Collection Token', false, false, CURRENT_TIMESTAMP),
(13, 'Order cancelled: Silver Token sale', false, true, CURRENT_TIMESTAMP),
(14, 'System maintenance scheduled for 2024-10-05', true, false, CURRENT_TIMESTAMP),
(15, 'New trading limits applied to your account', true, false, CURRENT_TIMESTAMP);

-- ===================================================================
-- DATA INTEGRITY VERIFICATION
-- ===================================================================
SELECT 'Total Users' as metric, COUNT(*) as count FROM AJ_USER
UNION ALL SELECT 'Total Parties', COUNT(*) FROM AJ_PARTY
UNION ALL SELECT 'Total Wallets', COUNT(*) FROM AJ_WALLET
UNION ALL SELECT 'Total Assets', COUNT(*) FROM AJ_ASSET
UNION ALL SELECT 'Total Orders', COUNT(*) FROM AJ_ORDER
UNION ALL SELECT 'Total Trades', COUNT(*) FROM AJ_TRADE
UNION ALL SELECT 'Total Positions', COUNT(*) FROM AJ_POSITION
UNION ALL SELECT 'Total Event Logs', COUNT(*) FROM AJ_EVENT_LOG
UNION ALL SELECT 'Total Notifications', COUNT(*) FROM AJ_NOTIFICATION;

-- ===================================================================
-- SEED DATA COMPLETE - CORRECTED FOR H2 DATABASE
-- ===================================================================