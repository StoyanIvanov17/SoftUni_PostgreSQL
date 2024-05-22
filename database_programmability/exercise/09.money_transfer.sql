CREATE PROCEDURE
    sp_transfer_money (
    sender_id INT,
    receiver_id INT,
    amount NUMERIC(10, 4)
)
AS
$$
DECLARE
    current_balance NUMERIC;
BEGIN
    CALL sp_withdraw_money(sender_id, amount);
    CALL sp_deposit_money(receiver_id, amount);

    SELECT balance INTO current_balance FROM accounts WHERE id = sender_id;

END;
$$
LANGUAGE plpgsql;