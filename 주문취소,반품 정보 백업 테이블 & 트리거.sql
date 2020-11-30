/* �ֹ����/��ǰ ���� ��� ���̺� & Ʈ���� */
/*
�ֹ���� Ʈ���� �����ϱ� (Ʈ���� ������ ������̺� ����)
	>> �ֹ� ��ҵǸ� ���� ����� ���̺� ����
	>> �ֹ����̺��� ������ �۵��ż� �ش� ������ ������̺� ���� Ʈ����
		>> �ֹ�/�ֹ��� ���� �����Ǵ��� Ȯ��(������)
        -- �ֹ����� ���� ��, �ֹ����̺�/�ֹ������̺� ���� ���������� ServiceImpl���� �����Ǿ� ����.
	>> ������̺� �÷����� �ܷ�Ű XX
	>> �ֹ� ��ҽ�, �����ڶ� ��������� ��� ���̰� ����
	>> �ֹ���� �������� ���� ����°� ���ϱ� �ҵ�(�����,������)
    
    -- �ֹ� ��ҽ�, ȸ�� ����Ʈ �谨 => �̰� Ʈ���� ���� ������ �޼ҵ�� ó��
*/


-- �ֹ� ��� ���̺� (�ֹ����̺� ���̽�)
DROP TABLE backup_ord_tb;

CREATE TABLE backup_ord_tb(
    ORD_IDX             NUMBER                  PRIMARY KEY,                           
    MEM_ID              VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    ORD_RECP_NAME       VARCHAR2(30)            NOT NULL,
    ORD_RECP_ZIP        CHAR(5)                 NOT NULL,
    ORD_RECP_ADDR       VARCHAR2(50)            NOT NULL,
    ORD_RECP_ADDR_D     VARCHAR2(50)            NOT NULL,
    ORD_RECP_TEL        VARCHAR2(15)            NOT NULL,
    ORD_TOT_PRICE       NUMBER                  NOT NULL,
    ORD_DATE            DATE DEFAULT SYSDATE    NOT NULL,
    ORD_STATE           NUMBER DEFAULT 1,
    ORD_COUNT           NUMBER DEFAULT 1,
    ORD_UPDATEDATE      DATE DEFAULT SYSDATE,
    STATE_UPDATEDATE    DATE DEFAULT SYSDATE,
    return_state        number default 7        not null,       -- ���/ȯ�һ��� '�������(7)/��ǰ�Ϸ�(8)/ȯ��ó����(9)/ȯ�ҿϷ�(0)'
    cancel_date         date default sysdate    not null,       -- �ֹ���� ���� ��¥
    cancel_updatedate   date default sysdate    not null       -- ���/ȯ�һ��� ���泯¥ (���ߴ� ó��)
    --, cancel_user         varchar2(20)            not null        -- �ֹ���� ������(������ ��) ���̵�
);

-- �ֹ��� ��� ���̺�(�ֹ������̺� ���̽�)
DROP TABLE backup_o_detail_tb;

CREATE TABLE backup_o_detail_tb(
    ORD_IDX             NUMBER              NOT NULL,
    PRD_IDX             NUMBER              NOT NULL,
    ORD_AMOUNT          NUMBER              NOT NULL,
    ORD_PRICE           NUMBER              NOT NULL,
    CONSTRAINTS backup_ORD_D_PK PRIMARY KEY(ORD_IDX, PRD_IDX)
);


select * from backup_ord_tb;
select * from backup_o_detail_tb;



-- Ʈ���� 1 => �ֹ����̺��� ���� �߻���, ������̺� ���� ����
drop trigger trg_backup_ord;

CREATE OR REPLACE TRIGGER trg_backup_ord
    AFTER DELETE        -- �ֹ� ���̺��� ������ ����� ��
    ON order_tb
    FOR EACH ROW
BEGIN
    INSERT INTO backup_ord_tb
        VALUES(:OLD.ord_idx, :OLD.mem_id, :OLD.ord_recp_name, :OLD.ord_recp_zip, :OLD.ord_recp_addr,
        :OLD.ord_recp_addr_d, :OLD.ord_recp_tel, :OLD.ord_tot_price, :OLD.ord_date, :OLD.ord_state,
        :OLD.ord_count, :OLD.ord_updatedate, :OLD.state_updatedate, 7, sysdate, sysdate);
END;


-- Ʈ���� 2 => �ֹ������̺��� ���� �߻���, ������̺� ���� ����
drop trigger trg_backup_o_detail;

CREATE OR REPLACE TRIGGER trg_backup_o_detail
    AFTER DELETE
    ON ord_detail_tb
    FOR EACH ROW
BEGIN
    INSERT INTO backup_o_detail_tb
        VALUES(:OLD.ord_idx, :OLD.prd_idx, :OLD.ord_amount, :OLD.ord_price);
END;




















































































