SET SERVEROUTPUT ON;

DECLARE
    v_bal NUMBER;
BEGIN
    SELECT balance INTO v_bal FROM WALLETS WHERE wallet_id = 502;
    DBMS_OUTPUT.PUT_LINE('Initial Balance: ' || v_bal);

    UPDATE WALLETS SET balance = balance + 500 WHERE wallet_id = 502;
    SAVEPOINT step1;

    UPDATE WALLETS SET balance = balance - 2000 WHERE wallet_id = 502;

    -- Rollback to savepoint
    ROLLBACK TO SAVEPOINT step1;

    SELECT balance INTO v_bal FROM WALLETS WHERE wallet_id = 502;
    DBMS_OUTPUT.PUT_LINE('Balance after rollback to savepoint: ' || v_bal);

    ROLLBACK;
END;
/
