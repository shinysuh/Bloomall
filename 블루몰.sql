/*
    �ۼ���: ���ſ�
*/

CREATE USER PROJECT IDENTIFIED BY 1234;

GRANT CONNECT, RESOURCE, DBA TO PROJECT;

--1)ȸ�� ���̺�: ȸ�� ���� ����
DROP TABLE MEMBER_TB;

CREATE TABLE MEMBER_TB(
    MEM_ID              VARCHAR2(50)            PRIMARY KEY,
    MEM_PW              VARCHAR2(60)            NOT NULL,
    MEM_NAME            VARCHAR2(30)            NOT NULL,
    MEM_EMAIL           VARCHAR2(50)            NOT NULL,
    MEM_ZIP             CHAR(5)                 NOT NULL,
    MEM_ADDR            VARCHAR2(50)            NOT NULL,
    MEM_ADDR_D          VARCHAR2(50)            NOT NULL,
    MEM_TEL             VARCHAR2(15)            NOT NULL,
    MEM_NICK            VARCHAR2(20)            UNIQUE NOT NULL,
    MEM_EMAIL_ACCP      CHAR(1)                 NOT NULL,
    MEM_POINT           NUMBER DEFAULT 0        NOT NULL,
    MEM_REGDATE         DATE DEFAULT SYSDATE    NOT NULL,
    MEM_UPDATEDATE      DATE DEFAULT SYSDATE    NOT NULL,
    MEM_LAST_VISIT      DATE DEFAULT SYSDATE    NOT NULL,
    MEM_AUTHCODE        CHAR(6) DEFAULT 'N'     NOT NULL
);


--2)ī�װ� ���̺�: ��ǰ ī�װ� ����
DROP TABLE CATEGORY_TB;

CREATE TABLE CATEGORY_TB(
    CTGR_CD             VARCHAR2(20)            PRIMARY KEY,
    CTGR_PRT_CD         VARCHAR2(20)            NULL REFERENCES CATEGORY_TB(CTGR_CD),
    CTGR_NAME           VARCHAR2(50)            NOT NULL
);


--3)��ǰ ���̺�: ��ǰ ���� ����
DROP TABLE PRODUCT_TB;

CREATE TABLE PRODUCT_TB(
    PRD_IDX             NUMBER                  PRIMARY KEY,                            -- ������
    CTGR_CD             VARCHAR2(20)            NOT NULL REFERENCES CATEGORY_TB(CTGR_CD),
    CTGR_PRT_CD         VARCHAR2(20)            NULL,            -- 1�� ī�װ� �ڵ�
    PRD_TITLE           VARCHAR2(100)           NOT NULL,
    PRD_AUTHOR          VARCHAR2(50)            NOT NULL,
    PRD_PRICE           NUMBER                  NOT NULL,
    PRD_DC_PRICE        NUMBER                  NOT NULL,
    PRD_COMPANY         VARCHAR2(30)            NOT NULL,
    PRD_DETAIL          VARCHAR2(4000)          NOT NULL,    -- CKEditor ����ؼ� ��ǰ���� ����(html �±��������� ����)
    PRD_IMG             VARCHAR2(100)           NOT NULL,
    PRD_AMOUNT          NUMBER                  NOT NULL,
    PRD_IN_STOCK        CHAR(1)                 NOT NULL,
    PRD_REGDATE         DATE DEFAULT SYSDATE    NOT NULL,
    PRD_UPDATEDATE      DATE DEFAULT SYSDATE    NOT NULL,
    ORD_AMOUNT          NUMBER DEFAULT 0,
    RVW_COUNT           NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_PRD_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;


--4)��ٱ��� ���̺�
DROP TABLE CART_TB;

CREATE TABLE CART_TB(
    CART_IDX        NUMBER          PRIMARY KEY,                           -- ������
    PRD_IDX         NUMBER          NOT NULL REFERENCES PRODUCT_TB(PRD_IDX),
    MEM_ID          VARCHAR2(50)    NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    CART_AMOUNT     NUMBER          NOT NULL
);

CREATE SEQUENCE SEQ_CART_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;


--5)�ֹ� ���̺�: �ֹ� ȸ�� ���� ����
DROP TABLE ORDER_TB;

CREATE TABLE ORDER_TB(
    ORD_IDX             NUMBER                  PRIMARY KEY,                           -- ������
    MEM_ID              VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    ORD_RECP_NAME       VARCHAR2(30)            NOT NULL,
    ORD_RECP_ZIP        CHAR(5)                 NOT NULL,
    ORD_RECP_ADDR       VARCHAR2(50)            NOT NULL,
    ORD_RECP_ADDR_D     VARCHAR2(50)            NOT NULL,
    ORD_RECP_TEL        VARCHAR2(15)            NOT NULL,
    ORD_TOT_PRICE       NUMBER                  NOT NULL,
    ORD_DATE            DATE DEFAULT SYSDATE    NOT NULL,
    ORD_STATE           NUMBER  DEFAULT 1,
    ORD_COUNT           NUMBER DEFAULT 1,
    ORD_UPDATEDATE      DATE DEFAULT SYSDATE,
    STATE_UPDATEDATE    DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_ORD_IDX
START WITH 10001
INCREMENT BY 1
MINVALUE 0;


--6)�ֹ��� ���̺�: �ֹ� ��ǰ ���� ����
DROP TABLE ORD_DETAIL_TB;

CREATE TABLE ORD_DETAIL_TB(
    ORD_IDX             NUMBER              NOT NULL REFERENCES ORDER_TB(ORD_IDX),
    PRD_IDX             NUMBER              NOT NULL REFERENCES PRODUCT_TB(PRD_IDX),
    ORD_AMOUNT          NUMBER              NOT NULL,
    ORD_PRICE           NUMBER              NOT NULL,
    CONSTRAINTS ORD_D_PK PRIMARY KEY(ORD_IDX, PRD_IDX)
);


--7)�Խ��� ���̺�: ȸ�� �� ����
DROP TABLE BOARD_TB;

CREATE TABLE BOARD_TB(
    BRD_IDX         NUMBER                  PRIMARY KEY,                           -- ������
    MEM_ID          VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    BRD_TITLE       VARCHAR2(100)           NOT NULL,
    BRD_CONTENT     VARCHAR2(4000)          NOT NULL,
    BRD_REGDATE     DATE DEFAULT SYSDATE    NOT NULL
);

CREATE SEQUENCE SEQ_BRD_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;


--8)���� ���̺�
DROP TABLE REVIEW_TB;

CREATE TABLE REVIEW_TB(
    RVW_IDX             NUMBER                  PRIMARY KEY,                           -- ������
    MEM_ID              VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    PRD_IDX             NUMBER                  NOT NULL REFERENCES PRODUCT_TB(PRD_IDX),
    RVW_CONTENT         VARCHAR2(200)           NOT NULL,
    RVW_RATING          NUMBER                  NOT NULL,
    RVW_REGDATE         DATE DEFAULT SYSDATE    NOT NULL
);

CREATE SEQUENCE SEQ_RVW_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;

delete from REVIEW_TB;

insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval, 'user01', 1, '���� ��� Ȯ�ο� ��� 1', 4, sysdate);
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval, 'user02', 1, '���� ��� Ȯ�ο� ��� 2', 3, sysdate); 
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval, 'user01', 1, '���� ��� Ȯ�ο� ��� 3', 5, sysdate);   
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user02', 1, '���� ��� Ȯ�ο� ��� 4', 4, sysdate); 
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user02', 1, '���� ��� Ȯ�ο� ��� 5', 2, sysdate);
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user01', 1, '���� ��� Ȯ�ο� ��� 6', 5, sysdate); 
    
commit;
    
-- 9) ������ �α��� ���̺�
CREATE TABLE ADMIN_TB(
    AD_ID           VARCHAR2(20)            PRIMARY KEY,
    AD_PW           VARCHAR2(60)            NOT NULL,
    AD_NAME         VARCHAR2(30)            NOT NULL,
    AD_LAST_VISIT   DATE DEFAULT SYSDATE    NOT NULL 
);

-- ������ ���� �߰�
INSERT INTO ADMIN_TB(AD_ID, AD_PW, AD_NAME)
            VALUES('admin', '1111', 'admin');

COMMIT;

--ī�װ� ���̺� ������ �߰�
DELETE FROM CATEGORY_TB;

INSERT INTO CATEGORY_TB
	VALUES('100', NULL, '��������');
INSERT INTO CATEGORY_TB
	VALUES('110', '100', '�Ҽ�/��');
INSERT INTO CATEGORY_TB
	VALUES('120', '100', '������');
INSERT INTO CATEGORY_TB
	VALUES('130', '100', '�ڱ���');
INSERT INTO CATEGORY_TB
	VALUES('140', '100', 'û�ҳ�');
    
INSERT INTO CATEGORY_TB
	VALUES('200', NULL, '�ܱ�����');
INSERT INTO CATEGORY_TB
	VALUES('210', '200', '�Ҽ�/��');
INSERT INTO CATEGORY_TB
	VALUES('220', '200', '������');
INSERT INTO CATEGORY_TB
	VALUES('230', '200', '�ڱ���');
INSERT INTO CATEGORY_TB
	VALUES('240', '200', 'û�ҳ�');
    
INSERT INTO CATEGORY_TB
	VALUES('300', NULL, 'eBook');
INSERT INTO CATEGORY_TB
	VALUES('310', '300', '�Ҽ�/��');
INSERT INTO CATEGORY_TB
	VALUES('320', '300', '������');
INSERT INTO CATEGORY_TB
	VALUES('330', '300', '�ڱ���');
INSERT INTO CATEGORY_TB
	VALUES('340', '300', 'û�ҳ�');
    
INSERT INTO CATEGORY_TB
	VALUES('400', NULL, '�߰�');
INSERT INTO CATEGORY_TB
	VALUES('460', '400', '�ֻ�');
INSERT INTO CATEGORY_TB
	VALUES('470', '400', '��');
INSERT INTO CATEGORY_TB
	VALUES('480', '400', '��');
INSERT INTO CATEGORY_TB
	VALUES('490', '400', '��');


COMMIT;


/* ���̺� ��ȸ */
SELECT * FROM MEMBER_TB;
SELECT * FROM CATEGORY_TB;
SELECT * FROM PRODUCT_TB;
SELECT * FROM CART_TB;
SELECT * FROM ORDER_TB;
SELECT * FROM ORD_DETAIL_TB;
SELECT * FROM BOARD_TB;
SELECT * FROM REVIEW_TB;
SELECT * FROM ADMIN_TB;















