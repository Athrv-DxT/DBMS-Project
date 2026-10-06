CREATE INDEX idx_users_email ON USERS(email);
CREATE INDEX idx_transactions_date ON TRANSACTIONS(transaction_date);
CREATE INDEX idx_transfers_sender ON TOKEN_TRANSFERS(sender_wallet_id);
CREATE INDEX idx_transfers_receiver ON TOKEN_TRANSFERS(receiver_wallet_id);

EXPLAIN PLAN FOR
SELECT * FROM USERS WHERE email = 'rahul@funfinity.com';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
