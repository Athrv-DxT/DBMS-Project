CREATE OR REPLACE TRIGGER trg_audit_wallet_update
AFTER UPDATE OF balance ON WALLETS
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_LOG (
        audit_id,
        table_name,
        record_id,
        operation,
        old_value,
        new_value,
        changed_by,
        changed_at
    ) VALUES (
        audit_seq.NEXTVAL,
        'WALLETS',
        :OLD.wallet_id,
        'UPDATE',
        'balance: ' || TO_CHAR(:OLD.balance, 'FM999999990.00'),
        'balance: ' || TO_CHAR(:NEW.balance, 'FM999999990.00'),
        USER,
        SYSDATE
    );
END;
/

CREATE OR REPLACE TRIGGER trg_audit_transfer_insert
AFTER INSERT ON TOKEN_TRANSFERS
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_LOG (
        audit_id,
        table_name,
        record_id,
        operation,
        old_value,
        new_value,
        changed_by,
        changed_at
    ) VALUES (
        audit_seq.NEXTVAL,
        'TOKEN_TRANSFERS',
        :NEW.transfer_id,
        'INSERT',
        NULL,
        'sender: ' || :NEW.sender_wallet_id || ', receiver: ' || :NEW.receiver_wallet_id || ', amount: ' || TO_CHAR(:NEW.amount),
        USER,
        SYSDATE
    );
END;
/
