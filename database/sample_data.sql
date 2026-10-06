DELETE FROM AUDIT_LOG;
DELETE FROM TRANSACTIONS;
DELETE FROM TOKEN_TRANSFERS;
DELETE FROM WALLETS;
DELETE FROM USERS;
DELETE FROM ROLES;

-- Roles
INSERT INTO ROLES (role_id, role_name) VALUES (1, 'ADMIN');
INSERT INTO ROLES (role_id, role_name) VALUES (2, 'USER');
INSERT INTO ROLES (role_id, role_name) VALUES (3, 'MANAGER');

-- Users
INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (101, 'Rahul Sharma', 'rahul@funfinity.com', 'pass123', 1, 'ACTIVE', SYSDATE - 30);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (102, 'Ananya Roy', 'ananya@funfinity.com', 'pass123', 2, 'ACTIVE', SYSDATE - 25);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (103, 'Vikram Patel', 'vikram@funfinity.com', 'pass123', 2, 'ACTIVE', SYSDATE - 20);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (104, 'Priya Singh', 'priya@funfinity.com', 'pass123', 2, 'ACTIVE', SYSDATE - 15);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (105, 'Amit Verma', 'amit@funfinity.com', 'pass123', 3, 'ACTIVE', SYSDATE - 10);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (106, 'Neha Gupta', 'neha@funfinity.com', 'pass123', 2, 'INACTIVE', SYSDATE - 5);

INSERT INTO USERS (user_id, name, email, password, role_id, status, created_at) 
VALUES (107, 'Suresh Kumar', 'suresh@funfinity.com', 'pass123', 2, 'ACTIVE', SYSDATE - 2);

-- Wallets
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (501, 101, 5000.00, SYSDATE - 30);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (502, 102, 1200.00, SYSDATE - 25);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (503, 103, 850.00, SYSDATE - 20);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (504, 104, 300.00, SYSDATE - 15);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (505, 105, 2500.00, SYSDATE - 10);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (506, 106, 0.00, SYSDATE - 5);
INSERT INTO WALLETS (wallet_id, user_id, balance, created_at) VALUES (507, 107, 100.00, SYSDATE - 2);

-- Token Transfers
INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1001, 501, 502, 500.00, SYSDATE - 12, 'COMPLETED');

INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1002, 502, 503, 150.00, SYSDATE - 10, 'COMPLETED');

INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1003, 503, 504, 200.00, SYSDATE - 7, 'COMPLETED');

INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1004, 501, 505, 1000.00, SYSDATE - 5, 'COMPLETED');

INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1005, 504, 502, 800.00, SYSDATE - 3, 'FAILED');

INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
VALUES (1006, 505, 503, 300.00, SYSDATE - 1, 'COMPLETED');

-- Transactions
INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5001, 501, 'DEPOSIT', 6500.00, NULL, SYSDATE - 30, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5002, 502, 'DEPOSIT', 850.00, NULL, SYSDATE - 25, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5003, 503, 'DEPOSIT', 600.00, NULL, SYSDATE - 20, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5004, 504, 'DEPOSIT', 100.00, NULL, SYSDATE - 15, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5005, 505, 'DEPOSIT', 1800.00, NULL, SYSDATE - 10, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5006, 501, 'DEBIT', 500.00, 1001, SYSDATE - 12, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5007, 502, 'CREDIT', 500.00, 1001, SYSDATE - 12, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5008, 502, 'DEBIT', 150.00, 1002, SYSDATE - 10, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5009, 503, 'CREDIT', 150.00, 1002, SYSDATE - 10, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5010, 503, 'DEBIT', 200.00, 1003, SYSDATE - 7, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5011, 504, 'CREDIT', 200.00, 1003, SYSDATE - 7, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5012, 501, 'DEBIT', 1000.00, 1004, SYSDATE - 5, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5013, 505, 'CREDIT', 1000.00, 1004, SYSDATE - 5, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5014, 504, 'DEBIT', 800.00, 1005, SYSDATE - 3, 'FAILED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5015, 505, 'DEBIT', 300.00, 1006, SYSDATE - 1, 'COMPLETED');

INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
VALUES (5016, 503, 'CREDIT', 300.00, 1006, SYSDATE - 1, 'COMPLETED');

COMMIT;
