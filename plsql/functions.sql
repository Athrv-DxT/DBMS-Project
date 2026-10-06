CREATE OR REPLACE FUNCTION GET_WALLET_BALANCE (
    p_user_id IN NUMBER
) RETURN NUMBER IS
    v_balance WALLETS.balance%TYPE;
BEGIN
    SELECT balance INTO v_balance
    FROM WALLETS
    WHERE user_id = p_user_id;

    RETURN v_balance;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

CREATE OR REPLACE FUNCTION GET_TRANSACTION_COUNT (
    p_user_id IN NUMBER
) RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(t.transaction_id) INTO v_count
    FROM TRANSACTIONS t
    JOIN WALLETS w ON t.wallet_id = w.wallet_id
    WHERE w.user_id = p_user_id;

    RETURN v_count;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/

SELECT user_id, name, 
       GET_WALLET_BALANCE(user_id) AS balance,
       GET_TRANSACTION_COUNT(user_id) AS tx_count
FROM USERS;
