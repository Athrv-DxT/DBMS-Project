SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_user_report IS
        SELECT 
            u.user_id,
            u.name,
            w.balance,
            COUNT(t.transaction_id) AS tx_count
        FROM USERS u
        JOIN WALLETS w ON u.user_id = w.user_id
        LEFT JOIN TRANSACTIONS t ON w.wallet_id = t.wallet_id
        GROUP BY u.user_id, u.name, w.balance
        ORDER BY w.balance DESC;

    r_user c_user_report%ROWTYPE;
BEGIN
    OPEN c_user_report;
    LOOP
        FETCH c_user_report INTO r_user;
        EXIT WHEN c_user_report%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(r_user.name || ' - Balance: ' || r_user.balance || ' - Tx Count: ' || r_user.tx_count);
    END LOOP;
    CLOSE c_user_report;
END;
/
