-- 1)주문(재고) 트리거 : 주문이 발생하면 주문 발생량만큼 상품테이블에서 주문상품들 재고에서 빼기
DROP TRIGGER TRG_STOCK;


CREATE OR REPLACE TRIGGER TRG_STOCK
    AFTER INSERT OR UPDATE OR DELETE
    ON ord_detail_tb       -- 주문상세테이블에 주문건이 삽입/수정/삭제되면
    FOR EACH ROW                        -- 각 행마다
DECLARE
    v_ord_amount    NUMBER;
    v_prd_idx       NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('주문 트리거 동작');
    
    IF INSERTING THEN   -- 주문 발생(사용자)
        -- 해당 주문의 구매 수량을 v_ord_amount에 저장
        SELECT :NEW.ord_amount INTO v_ord_amount FROM DUAL;
        -- 구매 상품번호를 v_prd_idx에 저장
        SELECT :NEW.prd_idx INTO v_prd_idx FROM DUAL;
        -- 주문 수량만큼 해당 상품 개수 차감
        UPDATE product_tb SET prd_amount = prd_amount - v_ord_amount
            WHERE prd_idx = v_prd_idx;
    END IF;        
    
    IF UPDATING THEN -- 주문 수정(관리자)
        -- (이전 주문수량 - 새 주문수량) 을 v_ord_amount에 저장
        SELECT :NEW.ord_amount - :OLD.ord_amount INTO v_ord_amount FROM DUAL;   
        -- 기존 상품번호를 v_prd_idx에 저장
        SELECT :NEW.prd_idx INTO v_prd_idx FROM DUAL;   
        -- 기존 주문수량과 수정된 주문 수량의 차이만큼 해당 상품 개수 차감
        UPDATE product_tb SET prd_amount = prd_amount - v_ord_amount
            WHERE prd_idx = v_prd_idx;
    END IF;
    
    IF DELETING THEN -- 주문 취소(관리자)
        -- 취소된 주문수량을 v_ord_amount에 저장
        SELECT :OLD.ord_amount INTO v_ord_amount FROM DUAL;
        -- 기존 상품번호를 v_prd_idx에 저장
        SELECT :OLD.prd_idx INTO v_prd_idx FROM DUAL;
        -- 취소된 주문 수량만큼 해당 상품 재고 개수 증가
        UPDATE product_tb SET prd_amount = prd_amount + v_ord_amount
                WHERE prd_idx = v_prd_idx;
    END IF;
    
END;




-- 2)배송상태/주문처리상태 수정 트리거 => 트리거를 통해 일일 발송/배송 건수 확인 가능
drop trigger trg_shipping;


CREATE OR REPLACE TRIGGER TRG_SHIPPING
    AFTER
    UPDATE OF ORD_STATE ON ORDER_TB  -- 주문 테이블의 [주문처리상태 컬럼] 업데이트 시 적용
BEGIN
    DBMS_OUTPUT.PUT_LINE('배송상태 업데이트 트리거 동작');
    -- [주문처리상태 컬럼] 수정 시 STATE_UPDATEDATE 업데이트
    UPDATE ORDER_TB SET STATE_UPDATEDATE = SYSDATE;
END;

