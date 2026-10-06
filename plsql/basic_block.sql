SET SERVEROUTPUT ON;

DECLARE
    v_total_users       NUMBER;
    v_total_wallets     NUMBER;
    v_circulating_tokens NUMBER(12, 2);
BEGIN
    SELECT COUNT(*) INTO v_total_users FROM USERS WHERE status = 'ACTIVE';
    SELECT COUNT(*), NVL(SUM(balance), 0) INTO v_total_wallets, v_circulating_tokens FROM WALLETS;

    DBMS_OUTPUT.PUT_LINE('Active Users: ' || v_total_users);
    DBMS_OUTPUT.PUT_LINE('Total Wallets: ' || v_total_wallets);
    DBMS_OUTPUT.PUT_LINE('Total Tokens: ' || v_circulating_tokens);
END;
/
