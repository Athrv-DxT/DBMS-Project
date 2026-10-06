CREATE OR REPLACE VIEW USER_WALLET_SUMMARY AS
SELECT 
    u.user_id,
    u.name AS user_name,
    u.email,
    r.role_name,
    w.wallet_id,
    w.balance AS current_balance,
    u.status AS user_status
FROM USERS u
JOIN ROLES r ON u.role_id = r.role_id
JOIN WALLETS w ON u.user_id = w.user_id;

CREATE OR REPLACE VIEW TRANSACTION_SUMMARY AS
SELECT 
    t.transaction_id,
    w.wallet_id,
    u.user_id,
    u.name AS user_name,
    t.transaction_type,
    t.amount,
    t.reference_id,
    t.transaction_date,
    t.status AS transaction_status
FROM TRANSACTIONS t
JOIN WALLETS w ON t.wallet_id = w.wallet_id
JOIN USERS u ON w.user_id = u.user_id;

SELECT * FROM USER_WALLET_SUMMARY WHERE current_balance > 1000;
SELECT * FROM TRANSACTION_SUMMARY WHERE transaction_type = 'CREDIT';
