/* 주문취소/반품 정보 백업 테이블 & 트리거 */
/*
주문취소 트리거 생성하기 (트리거 예제에 백업테이블 참조)
	>> 주문 취소되면 정보 백업할 테이블 생성
	>> 주문테이블에서 삭제시 작동돼서 해당 데이터 백업테이블에 넣을 트리거
		>> 주문/주문상세 같이 삭제되는지 확인(서비스쪽)
        -- 주문정보 삭제 시, 주문테이블/주문상세테이블 같이 지워지도록 ServiceImpl에서 설정되어 있음.
	>> 백업테이블 컬럼들은 외래키 XX
	>> 주문 취소시, 관리자랑 사용자측에 어떻게 보이게 할지
	>> 주문취소 페이지를 따로 만드는게 편하긴 할듯(사용자,관리자)
    
    -- 주문 취소시, 회원 포인트 삭감 => 이건 트리거 말고 스프링 메소드로 처리
*/


-- 주문 백업 테이블 (주문테이블 베이스)
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
    return_state        number default 7        not null,       -- 취소/환불상태 '취소접수(7)/반품완료(8)/환불처리중(9)/환불완료(0)'
    cancel_date         date default sysdate    not null,       -- 주문취소 접수 날짜
    cancel_updatedate   date default sysdate    not null       -- 취소/환불상태 변경날짜 (개발단 처리)
    --, cancel_user         varchar2(20)            not null        -- 주문취소 접수자(관리자 중) 아이디
);

-- 주문상세 백업 테이블(주문상세테이블 베이스)
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



-- 트리거 1 => 주문테이블에서 삭제 발생시, 백업테이블에 정보 저장
drop trigger trg_backup_ord;

CREATE OR REPLACE TRIGGER trg_backup_ord
    AFTER DELETE        -- 주문 테이블에서 삭제가 진행된 후
    ON order_tb
    FOR EACH ROW
BEGIN
    INSERT INTO backup_ord_tb
        VALUES(:OLD.ord_idx, :OLD.mem_id, :OLD.ord_recp_name, :OLD.ord_recp_zip, :OLD.ord_recp_addr,
        :OLD.ord_recp_addr_d, :OLD.ord_recp_tel, :OLD.ord_tot_price, :OLD.ord_date, :OLD.ord_state,
        :OLD.ord_count, :OLD.ord_updatedate, :OLD.state_updatedate, 7, sysdate, sysdate);
END;


-- 트리거 2 => 주문상세테이블에서 삭제 발생시, 백업테이블에 정보 저장
drop trigger trg_backup_o_detail;

CREATE OR REPLACE TRIGGER trg_backup_o_detail
    AFTER DELETE
    ON ord_detail_tb
    FOR EACH ROW
BEGIN
    INSERT INTO backup_o_detail_tb
        VALUES(:OLD.ord_idx, :OLD.prd_idx, :OLD.ord_amount, :OLD.ord_price);
END;




















































































