-- Active users
SELECT user_id, name, email, status, created_at
FROM USERS
WHERE status = 'ACTIVE'
ORDER BY created_at DESC;

-- Users with roles and balance
SELECT u.user_id, u.name, r.role_name, w.wallet_id, w.balance
FROM USERS u
INNER JOIN ROLES r ON u.role_id = r.role_id
INNER JOIN WALLETS w ON u.user_id = w.user_id;

-- Transfers sent per user
SELECT u.user_id, u.name, COUNT(tt.transfer_id) AS total_transfers_sent
FROM USERS u
LEFT JOIN WALLETS w ON u.user_id = w.user_id
LEFT JOIN TOKEN_TRANSFERS tt ON w.wallet_id = tt.sender_wallet_id
GROUP BY u.user_id, u.name
ORDER BY total_transfers_sent DESC;

-- Users with higher than average balance
SELECT u.user_id, u.name, w.balance
FROM USERS u
JOIN WALLETS w ON u.user_id = w.user_id
WHERE w.balance > (
    SELECT AVG(balance) FROM WALLETS
);

-- Top token holders
SELECT u.user_id, u.name, w.balance
FROM USERS u
JOIN WALLETS w ON u.user_id = w.user_id
WHERE ROWNUM <= 3
ORDER BY w.balance DESC;

-- Total tokens transferred
SELECT COUNT(transfer_id) AS total_transfers,
       NVL(SUM(amount), 0) AS total_amount_transferred
FROM TOKEN_TRANSFERS
WHERE status = 'COMPLETED';

-- Users with no transactions
SELECT u.user_id, u.name, u.email
FROM USERS u
JOIN WALLETS w ON u.user_id = w.user_id
WHERE w.wallet_id NOT IN (
    SELECT DISTINCT wallet_id FROM TRANSACTIONS
);

-- Largest token transfer
SELECT tt.transfer_id, u1.name AS sender, u2.name AS receiver, tt.amount, tt.transfer_date
FROM TOKEN_TRANSFERS tt
JOIN WALLETS w1 ON tt.sender_wallet_id = w1.wallet_id
JOIN USERS u1 ON w1.user_id = u1.user_id
JOIN WALLETS w2 ON tt.receiver_wallet_id = w2.wallet_id
JOIN USERS u2 ON w2.user_id = u2.user_id
WHERE tt.amount = (SELECT MAX(amount) FROM TOKEN_TRANSFERS WHERE status = 'COMPLETED');

-- Total credits and debits per user
SELECT u.user_id, u.name,
       NVL(SUM(CASE WHEN t.transaction_type IN ('CREDIT', 'DEPOSIT') AND t.status = 'COMPLETED' THEN t.amount ELSE 0 END), 0) AS total_credits,
       NVL(SUM(CASE WHEN t.transaction_type = 'DEBIT' AND t.status = 'COMPLETED' THEN t.amount ELSE 0 END), 0) AS total_debits
FROM USERS u
JOIN WALLETS w ON u.user_id = w.user_id
LEFT JOIN TRANSACTIONS t ON w.wallet_id = t.wallet_id
GROUP BY u.user_id, u.name
ORDER BY u.user_id;
