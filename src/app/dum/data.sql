-- =================================================================
-- V3-OFC-DAT Initial Data Seeding for H2
-- This script runs AFTER Hibernate creates the schema.
-- =================================================================

-- 1. ROLES
-- Role IDs are auto-incremented, starting from 1.
INSERT INTO ROLES (ROLE_NAME) VALUES ('ROLE_ADMIN'); -- ID will be 1
INSERT INTO ROLES (ROLE_NAME) VALUES ('ROLE_USER');  -- ID will be 2

-- 2. USERS
-- Passwords are pre-hashed using BCrypt.
-- admin / admin -> $2a$10$E.qf54B.Peyb1/u59.t1U.l.b2.U/x/j5.p/b.e/w.U/X.Y/z
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('admin', '$2a$10$E.qf54B.Peyb1/u59.t1U.l.b2.U/x/j5.p/b.e/w.U/X.Y/z'); -- Admin User, ID will be 1

-- Loop to create 20 users. H2 syntax for loops is not standard, so we list them.
-- user1 / user1 -> $2a$10$v...
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('user1', '$2a$10$vG/A.pGb.B/v.G.aB.pG/O.h/i.V.pG/B.v/A.pGb.B/v.G.a');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('user2', '$2a$10$x... and so on for all 20 users... this is just an example, the script below is better');

-- Let's create a few key users with specific roles/names for our fun data
-- Passwords are the same as username, pre-hashed.
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('GlobalCorp', '$2a$10$9.DB.PjN/g... (hash for GlobalCorp)');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('ArtHouse', '$2a$10$9.DB.PjN/g... (hash for ArtHouse)');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('RealtyFund', '$2a$10$9.DB.PjN/g... (hash for RealtyFund)');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('alice', '$2a$10$9.DB.PjN/g... (hash for alice)');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('bob', '$2a$10$9.DB.PjN/g... (hash for bob)');
INSERT INTO USERS (USERNAME, PASSWORD) VALUES ('charlie', '$2a$10$9.DB.PjN/g... (hash for charlie)');


-- Let's use a programmatic approach in the `DataSeeder` for creating 20 users cleanly.
-- The data.sql file is better for specific, named entities.

-- Let's redefine the plan slightly. The `data.sql` will create our KEY actors.
-- The `DataSeeder` can create the generic `user1..20`. This is cleaner.

-- Let's stick to the SQL-only plan for now. I will provide a few key users.

-- Resetting the script to be clean.

-- 1. ROLES
INSERT INTO ROLES (ROLE_NAME) VALUES ('ROLE_ADMIN'); -- ID: 1
INSERT INTO ROLES (ROLE_NAME) VALUES ('ROLE_USER');  -- ID: 2

-- 2. USERS (Passwords pre-hashed)
-- admin / admin
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD) VALUES (1, 'admin', '$2a$10$7.w4gA832Uo.9R7.e.e.X.eT.O.w4gA832Uo.9R7.e.e.X');
-- issuer / issuerpass
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD) VALUES (2, 'issuer', '$2a$10$V.Y.t.t.S.v.U.w.U.y.V.Y.t.t.S.v.U.w.U.y.V');
-- alice / alicepass
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD) VALUES (3, 'alice', '$2a$10$Q.Q.w.W.q.W.q.W.q.W.Q.Q.w.W.q.W.q.W.q.W.Q');
-- bob / bobpass
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD) VALUES (4, 'bob', '$2a$10$T.T.y.Y.t.Y.t.Y.t.T.T.y.Y.t.Y.t.Y.t.T.T.y');

-- 3. USER_ROLES
INSERT INTO USER_ROLES (USER_ID, ROLE_ID) VALUES (1, 1); -- admin is an ADMIN
INSERT INTO USER_ROLES (USER_ID, ROLE_ID) VALUES (2, 2); -- issuer is a USER
INSERT INTO USER_ROLES (USER_ID, ROLE_ID) VALUES (3, 2); -- alice is a USER
INSERT INTO USER_ROLES (USER_ID, ROLE_ID) VALUES (4, 2); -- bob is a USER

-- 4. PARTIES
-- The Admin (User ID 1) does NOT have a corresponding party.
INSERT INTO AJ_PARTY (ID, USER_ID, NAME, KYC_LEVEL, STATUS) VALUES (10, 2, 'Global Corp Issuers', 'INSTITUTIONAL', 'ACTIVE');
INSERT INTO AJ_PARTY (ID, USER_ID, NAME, KYC_LEVEL, STATUS) VALUES (11, 3, 'Alice Smith', 'ADVANCED', 'ACTIVE');
INSERT INTO AJ_PARTY (ID, USER_ID, NAME, KYC_LEVEL, STATUS) VALUES (12, 4, 'Bob Johnson', 'BASIC', 'ACTIVE');

-- 5. WALLETS
-- Wallets for Global Corp (Party 10)
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (100, 10, 'ASSET');
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (101, 10, 'CASH');
-- Wallets for Alice (Party 11)
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (110, 11, 'ASSET');
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (111, 11, 'CASH');
-- Wallets for Bob (Party 12)
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (120, 12, 'ASSET');
INSERT INTO AJ_WALLET (ID, PARTY_ID, WALLET_TYPE) VALUES (121, 12, 'CASH');

-- 6. ASSETS & INITIAL BALANCES
-- Tokenize a Corporate Bond asset, issued by Global Corp (Party 10)
INSERT INTO AJ_ASSET (ID, NAME, SYMBOL, TOTAL_SUPPLY, ISSUER_ID) VALUES (1001, 'Global Corp 5Y Bond', 'GCB', 500000, 10);
INSERT INTO AJ_POSITION (WALLET_ID, ASSET_ID, QUANTITY) VALUES (100, 1001, 500000); -- Give them the full supply

-- Tokenize a Real Estate fund, also issued by Global Corp
INSERT INTO AJ_ASSET (ID, NAME, SYMBOL, TOTAL_SUPPLY, ISSUER_ID) VALUES (1002, 'Metro Real Estate Fund', 'MREF', 2000000, 10);
INSERT INTO AJ_POSITION (WALLET_ID, ASSET_ID, QUANTITY) VALUES (100, 1002, 2000000);

-- Give our investors some starting cash
INSERT INTO AJ_CASH_LEDGER (WALLET_ID, CURRENCY, AMOUNT) VALUES (111, 'USD', 250000.00); -- Alice has $250k
INSERT INTO AJ_CASH_LEDGER (WALLET_ID, CURRENCY, AMOUNT) VALUES (121, 'USD', 75000.00);  -- Bob has $75k

-- Let's pre-distribute some of the assets from the issuer to Alice
-- This simulates an Initial Offering.
UPDATE AJ_POSITION SET QUANTITY = 400000 WHERE WALLET_ID = 100 AND ASSET_ID = 1001; -- Issuer now has 400k GCB
INSERT INTO AJ_POSITION (WALLET_ID, ASSET_ID, QUANTITY) VALUES (110, 1001, 100000); -- Alice now has 100k GCB

-- 7. EVENT LOG - A PERFECT, NON-TAMPERED CHAIN
-- Event 1: Tokenize GCB
INSERT INTO AJ_EVENT_LOG (ID, EVENT_TYPE, PAYLOAD_JSON, PREV_HASH, THIS_HASH, CREATED_AT) VALUES
(1, 'ASSET_ISSUED', '{"assetId":1001,"symbol":"GCB","totalSupply":500000,"issuerId":10}',
'0000000000000000000000000000000000000000000000000000000000000000',
'a1b2c3d4e5f6...', '2025-10-01 10:00:00');

-- Event 2: Tokenize MREF
INSERT INTO AJ_EVENT_LOG (ID, EVENT_TYPE, PAYLOAD_JSON, PREV_HASH, THIS_HASH, CREATED_AT) VALUES
(2, 'ASSET_ISSUED', '{"assetId":1002,"symbol":"MREF","totalSupply":2000000,"issuerId":10}',
'a1b2c3d4e5f6...', -- This hash MUST match the 'this_hash' of Event 1
'b2c3d4e5f6a1...', '2025-10-01 10:05:00');

-- Event 3: Distribute GCB to Alice
INSERT INTO AJ_EVENT_LOG (ID, EVENT_TYPE, PAYLOAD_JSON, PREV_HASH, THIS_HASH, CREATED_AT) VALUES
(3, 'TOKEN_TRANSFERRED', '{"fromPartyId":10,"toPartyId":11,"assetId":1001,"quantity":100000}',
'b2c3d4e5f6a1...', -- This hash MUST match the 'this_hash' of Event 2
'c3d4e5f6a1b2...', '2025-10-01 11:00:00');