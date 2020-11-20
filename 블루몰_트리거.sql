-- 1)�ֹ�(���) Ʈ���� : �ֹ��� �߻��ϸ� �ֹ� �߻�����ŭ ��ǰ���̺��� �ֹ���ǰ�� ����� ����
DROP TRIGGER TRG_STOCK;


CREATE OR REPLACE TRIGGER TRG_STOCK
    AFTER INSERT OR UPDATE OR DELETE
    ON ord_detail_tb       -- �ֹ������̺� �ֹ����� ����/����/�����Ǹ�
    FOR EACH ROW                        -- �� �ึ��
DECLARE
    v_ord_amount    NUMBER;
    v_prd_idx       NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�ֹ� Ʈ���� ����');
    
    IF INSERTING THEN   -- �ֹ� �߻�(�����)
        -- �ش� �ֹ��� ���� ������ v_ord_amount�� ����
        SELECT :NEW.ord_amount INTO v_ord_amount FROM DUAL;
        -- ���� ��ǰ��ȣ�� v_prd_idx�� ����
        SELECT :NEW.prd_idx INTO v_prd_idx FROM DUAL;
        -- �ֹ� ������ŭ �ش� ��ǰ ���� ����
        UPDATE product_tb SET prd_amount = prd_amount - v_ord_amount
            WHERE prd_idx = v_prd_idx;
    END IF;        
    
    IF UPDATING THEN -- �ֹ� ����(������)
        -- (���� �ֹ����� - �� �ֹ�����) �� v_ord_amount�� ����
        SELECT :NEW.ord_amount - :OLD.ord_amount INTO v_ord_amount FROM DUAL;   
        -- ���� ��ǰ��ȣ�� v_prd_idx�� ����
        SELECT :NEW.prd_idx INTO v_prd_idx FROM DUAL;   
        -- ���� �ֹ������� ������ �ֹ� ������ ���̸�ŭ �ش� ��ǰ ���� ����
        UPDATE product_tb SET prd_amount = prd_amount - v_ord_amount
            WHERE prd_idx = v_prd_idx;
    END IF;
    
    IF DELETING THEN -- �ֹ� ���(������)
        -- ��ҵ� �ֹ������� v_ord_amount�� ����
        SELECT :OLD.ord_amount INTO v_ord_amount FROM DUAL;
        -- ���� ��ǰ��ȣ�� v_prd_idx�� ����
        SELECT :OLD.prd_idx INTO v_prd_idx FROM DUAL;
        -- ��ҵ� �ֹ� ������ŭ �ش� ��ǰ ��� ���� ����
        UPDATE product_tb SET prd_amount = prd_amount + v_ord_amount
                WHERE prd_idx = v_prd_idx;
    END IF;
    
END;




-- 2)��ۻ���/�ֹ�ó������ ���� Ʈ���� => Ʈ���Ÿ� ���� ���� �߼�/��� �Ǽ� Ȯ�� ����
drop trigger trg_shipping;


CREATE OR REPLACE TRIGGER TRG_SHIPPING
    AFTER
    UPDATE OF ORD_STATE ON ORDER_TB  -- �ֹ� ���̺��� [�ֹ�ó������ �÷�] ������Ʈ �� ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('��ۻ��� ������Ʈ Ʈ���� ����');
    -- [�ֹ�ó������ �÷�] ���� �� STATE_UPDATEDATE ������Ʈ
    UPDATE ORDER_TB SET STATE_UPDATEDATE = SYSDATE;
END;

