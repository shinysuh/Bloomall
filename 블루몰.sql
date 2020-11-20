/*
    작성자: 서신영
*/

CREATE USER PROJECT IDENTIFIED BY 1234;

GRANT CONNECT, RESOURCE, DBA TO PROJECT;

--1)회원 테이블: 회원 정보 저장
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


--2)카테고리 테이블: 상품 카테고리 저장
DROP TABLE CATEGORY_TB;

CREATE TABLE CATEGORY_TB(
    CTGR_CD             VARCHAR2(20)            PRIMARY KEY,
    CTGR_PRT_CD         VARCHAR2(20)            NULL REFERENCES CATEGORY_TB(CTGR_CD),
    CTGR_NAME           VARCHAR2(50)            NOT NULL
);


--3)상품 테이블: 상품 정보 저장
DROP TABLE PRODUCT_TB;

CREATE TABLE PRODUCT_TB(
    PRD_IDX             NUMBER                  PRIMARY KEY,                            -- 시퀀스
    CTGR_CD             VARCHAR2(20)            NOT NULL REFERENCES CATEGORY_TB(CTGR_CD),
    CTGR_PRT_CD         VARCHAR2(20)            NULL,            -- 1차 카테고리 코드
    PRD_TITLE           VARCHAR2(100)           NOT NULL,
    PRD_AUTHOR          VARCHAR2(50)            NOT NULL,
    PRD_PRICE           NUMBER                  NOT NULL,
    PRD_DC_PRICE        NUMBER                  NOT NULL,
    PRD_COMPANY         VARCHAR2(30)            NOT NULL,
    PRD_DETAIL          VARCHAR2(4000)          NOT NULL,    -- CKEditor 사용해서 상품설명 정보(html 태그형식으로 저장)
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


--4)장바구니 테이블
DROP TABLE CART_TB;

CREATE TABLE CART_TB(
    CART_IDX        NUMBER          PRIMARY KEY,                           -- 시퀀스
    PRD_IDX         NUMBER          NOT NULL REFERENCES PRODUCT_TB(PRD_IDX),
    MEM_ID          VARCHAR2(50)    NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    CART_AMOUNT     NUMBER          NOT NULL
);

CREATE SEQUENCE SEQ_CART_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;


--5)주문 테이블: 주문 회원 정보 저장
DROP TABLE ORDER_TB;

CREATE TABLE ORDER_TB(
    ORD_IDX             NUMBER                  PRIMARY KEY,                           -- 시퀀스
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


--6)주문상세 테이블: 주문 상품 정보 저장
DROP TABLE ORD_DETAIL_TB;

CREATE TABLE ORD_DETAIL_TB(
    ORD_IDX             NUMBER              NOT NULL REFERENCES ORDER_TB(ORD_IDX),
    PRD_IDX             NUMBER              NOT NULL REFERENCES PRODUCT_TB(PRD_IDX),
    ORD_AMOUNT          NUMBER              NOT NULL,
    ORD_PRICE           NUMBER              NOT NULL,
    CONSTRAINTS ORD_D_PK PRIMARY KEY(ORD_IDX, PRD_IDX)
);


--7)게시판 테이블: 회원 글 저장
DROP TABLE BOARD_TB;

CREATE TABLE BOARD_TB(
    BRD_IDX         NUMBER                  PRIMARY KEY,                           -- 시퀀스
    MEM_ID          VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TB(MEM_ID),
    BRD_TITLE       VARCHAR2(100)           NOT NULL,
    BRD_CONTENT     VARCHAR2(4000)          NOT NULL,
    BRD_REGDATE     DATE DEFAULT SYSDATE    NOT NULL
);

CREATE SEQUENCE SEQ_BRD_IDX
START WITH 1
INCREMENT BY 1
MINVALUE 0;


--8)리뷰 테이블
DROP TABLE REVIEW_TB;

CREATE TABLE REVIEW_TB(
    RVW_IDX             NUMBER                  PRIMARY KEY,                           -- 시퀀스
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
    values(SEQ_RVW_IDX.nextval, 'user01', 1, '리뷰 기능 확인용 댓글 1', 4, sysdate);
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval, 'user02', 1, '리뷰 기능 확인용 댓글 2', 3, sysdate); 
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval, 'user01', 1, '리뷰 기능 확인용 댓글 3', 5, sysdate);   
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user02', 1, '리뷰 기능 확인용 댓글 4', 4, sysdate); 
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user02', 1, '리뷰 기능 확인용 댓글 5', 2, sysdate);
insert into REVIEW_TB(rvw_idx, MEM_ID, PRD_IDX, RVW_CONTENT, RVW_RATING, RVW_REGDATE)
    values(SEQ_RVW_IDX.nextval,'user01', 1, '리뷰 기능 확인용 댓글 6', 5, sysdate); 
    
commit;
    
-- 9) 관리자 로그인 테이블
CREATE TABLE ADMIN_TB(
    AD_ID           VARCHAR2(20)            PRIMARY KEY,
    AD_PW           VARCHAR2(60)            NOT NULL,
    AD_NAME         VARCHAR2(30)            NOT NULL,
    AD_LAST_VISIT   DATE DEFAULT SYSDATE    NOT NULL 
);

-- 관리자 계정 추가
INSERT INTO ADMIN_TB(AD_ID, AD_PW, AD_NAME)
            VALUES('admin', '1111', 'admin');

COMMIT;

--카테고리 테이블 데이터 추가
DELETE FROM CATEGORY_TB;

INSERT INTO CATEGORY_TB
	VALUES('100', NULL, '국내도서');
INSERT INTO CATEGORY_TB
	VALUES('110', '100', '소설/시');
INSERT INTO CATEGORY_TB
	VALUES('120', '100', '에세이');
INSERT INTO CATEGORY_TB
	VALUES('130', '100', '자기계발');
INSERT INTO CATEGORY_TB
	VALUES('140', '100', '청소년');
    
INSERT INTO CATEGORY_TB
	VALUES('200', NULL, '외국도서');
INSERT INTO CATEGORY_TB
	VALUES('210', '200', '소설/시');
INSERT INTO CATEGORY_TB
	VALUES('220', '200', '에세이');
INSERT INTO CATEGORY_TB
	VALUES('230', '200', '자기계발');
INSERT INTO CATEGORY_TB
	VALUES('240', '200', '청소년');
    
INSERT INTO CATEGORY_TB
	VALUES('300', NULL, 'eBook');
INSERT INTO CATEGORY_TB
	VALUES('310', '300', '소설/시');
INSERT INTO CATEGORY_TB
	VALUES('320', '300', '에세이');
INSERT INTO CATEGORY_TB
	VALUES('330', '300', '자기계발');
INSERT INTO CATEGORY_TB
	VALUES('340', '300', '청소년');
    
INSERT INTO CATEGORY_TB
	VALUES('400', NULL, '중고샵');
INSERT INTO CATEGORY_TB
	VALUES('460', '400', '최상');
INSERT INTO CATEGORY_TB
	VALUES('470', '400', '상');
INSERT INTO CATEGORY_TB
	VALUES('480', '400', '중');
INSERT INTO CATEGORY_TB
	VALUES('490', '400', '하');


COMMIT;


/* 테이블 조회 */
SELECT * FROM MEMBER_TB;
SELECT * FROM CATEGORY_TB;
SELECT * FROM PRODUCT_TB;
SELECT * FROM CART_TB;
SELECT * FROM ORDER_TB;
SELECT * FROM ORD_DETAIL_TB;
SELECT * FROM BOARD_TB;
SELECT * FROM REVIEW_TB;
SELECT * FROM ADMIN_TB;















