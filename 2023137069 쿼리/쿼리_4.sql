-- 24. 상점 테이블 생성
CREATE TABLE shops(
	shop_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	location VARCHAR(100)
);

-- 25. 상점 데이터 삽입
INSERT INTO shops (name, location) VALUES
('모험가의 장비점', '시작 마을'),
('마법 물약 상회', '마법의 숲');

-- 26. 상점 재고 테이블 생성
CREATE TABLE shop_inventory(
	shop_id INT,
	item_id INT,
	price INT NOT NULL,
	stock INT DEFAULT 0,
	PRIMARY KEY (shop_id, item_id),
	FOREIGN KEY (shop_id) REFERENCES shops(shop_id),
	FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- 27. 상점 재고 데이터 삽입
INSERT INTO shop_inventory(shop_id, item_id, price, stock) VALUES
(1,1,20,5),		-- 모험가의 장비점 검 5개 (가격 20)
(1,2,30,3),		-- 모험가의 장비점 방패 3개 (가격 30)
(2,3,10,10);	-- 마법 물약 상회 물약 10개 (가격 10)

-- 28. 특정 상점의 재고 조회
SELECT s.name AS shop_name, i.name AS item_name, si.price, si.stock
FROM shops s
JOIN shop_inventory si ON s.shop_id = si.shop_id
JOIN items i ON si.item_id = i.item_id
WHERE s.shop_id = 1;

-- 29. 플레이어 지갑 테이블 생성
CREATE TABLE player_wallet(
	player_id INT PRIMARY KEY,
	gold INT DEFAULT 0,
	FOREIGN KEY (player_id) REFERENCES players(player_id)	
);	

-- 30. 플레이어 지갑에 초기 금액 지급
INSERT INTO player_wallet (player_id, gold) VALUES
(1,100),
(2,150);

-- 31. 아이템 구매 프로시저 생성
DELIMITER //
CREATE PROCEDURE buy_item(IN p_player_id INT, IN p_shop_id INT, IN p_item_id INT, IN p_quantity INT)
BEGIN
	DECLARE item_price INT;
	DECLARE total_price INT;
	DECLARE player_gold INT;
	
	-- 아이템 가격 확인
	SELECT price INTO item_price FROM shop_inventory
	WHERE shop_id = p_shop_id AND item_id = p_item_id;
	
	SET total_price = item_price * p_quantity;
	
	-- 플레이어의 골드 확인
	SELECT gold INTO player_gold FROM player_wallet
	WHERE player_id = p_player_id;
	
	-- 구매 가능 여부 확인 처리
	IF player_gold >= total_price THEN
		-- 플레이어의 골드 차감
		UPDATE player_wallet SET gold = gold - total_price
		WHERE player_id = p_player_id;
		
		-- 상점 재고 감소
		UPDATE shop_inventory SET stock = stock - p_quantity
		WHERE shop_id = p_shop_id AND item_id = p_item_id;
		
		-- 플레이어 인벤토리에 아이템 추가
		INSERT INTO inventories (player_id, item_id, quantity)
		VALUE (p_player_id, p_item_id, p_quantity)
		ON DUPLICATE KEY UPDATE quantity = quantity + p_quantity;
		
		SELECT 'purchase successful' AS result;
	
	ELSE
		SELECT 'Insufficaient gold' AS result;
	END IF;
END
DELIMITER //

-- 32. 아이템 구매 프로시저 실행
player_wallet