CREATE OR REPLACE PROCEDURE TRANSFER_TOKENS (
    p_sender_user_id   IN NUMBER,
    p_receiver_user_id IN NUMBER,
    p_amount           IN NUMBER
) AS
    v_sender_wallet_id   WALLETS.wallet_id%TYPE;
    v_receiver_wallet_id WALLETS.wallet_id%TYPE;
    v_sender_balance     WALLETS.balance%TYPE;
    v_sender_status      USERS.status%TYPE;
    v_receiver_status    USERS.status%TYPE;
    v_transfer_id        NUMBER;

    e_same_user          EXCEPTION;
    e_invalid_amount     EXCEPTION;
    e_insufficient_funds EXCEPTION;
    e_inactive_user      EXCEPTION;
BEGIN
    IF p_sender_user_id = p_receiver_user_id THEN
        RAISE e_same_user;
    END IF;

    IF p_amount <= 0 THEN
        RAISE e_invalid_amount;
    END IF;

    -- Fetch sender info
    BEGIN
        SELECT u.status, w.wallet_id, w.balance
        INTO v_sender_status, v_sender_wallet_id, v_sender_balance
        FROM USERS u
        JOIN WALLETS w ON u.user_id = w.user_id
        WHERE u.user_id = p_sender_user_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Sender user not found.');
    END;

    IF v_sender_status <> 'ACTIVE' THEN
        RAISE e_inactive_user;
    END IF;

    -- Fetch receiver info
    BEGIN
        SELECT u.status, w.wallet_id
        INTO v_receiver_status, v_receiver_wallet_id
        FROM USERS u
        JOIN WALLETS w ON u.user_id = w.user_id
        WHERE u.user_id = p_receiver_user_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Receiver user not found.');
    END;

    IF v_receiver_status <> 'ACTIVE' THEN
        RAISE e_inactive_user;
    END IF;

    IF v_sender_balance < p_amount THEN
        RAISE e_insufficient_funds;
    END IF;

    SAVEPOINT start_transfer;

    -- Update balances
    UPDATE WALLETS 
    SET balance = balance - p_amount 
    WHERE wallet_id = v_sender_wallet_id;

    UPDATE WALLETS 
    SET balance = balance + p_amount 
    WHERE wallet_id = v_receiver_wallet_id;

    -- Insert transfer
    v_transfer_id := transfer_seq.NEXTVAL;
    INSERT INTO TOKEN_TRANSFERS (transfer_id, sender_wallet_id, receiver_wallet_id, amount, transfer_date, status)
    VALUES (v_transfer_id, v_sender_wallet_id, v_receiver_wallet_id, p_amount, SYSDATE, 'COMPLETED');

    -- Insert transactions
    INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
    VALUES (transaction_seq.NEXTVAL, v_sender_wallet_id, 'DEBIT', p_amount, v_transfer_id, SYSDATE, 'COMPLETED');

    INSERT INTO TRANSACTIONS (transaction_id, wallet_id, transaction_type, amount, reference_id, transaction_date, status)
    VALUES (transaction_seq.NEXTVAL, v_receiver_wallet_id, 'CREDIT', p_amount, v_transfer_id, SYSDATE, 'COMPLETED');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer successful. Transfer ID: ' || v_transfer_id);

EXCEPTION
    WHEN e_same_user THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Sender and receiver cannot be same.');
    WHEN e_invalid_amount THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Amount must be greater than zero.');
    WHEN e_insufficient_funds THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20005, 'Insufficient balance.');
    WHEN e_inactive_user THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20006, 'Account is inactive.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20000, 'Error during transfer: ' || SQLERRM);
END;
/
