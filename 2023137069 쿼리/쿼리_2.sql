-- 10. 아이템 테이블 생성

CREATE TABLE items (
	item_id INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	DESCRIPTION TEXT,
	VALUE INT DEFAULT 0
);

-- 11. 아이템 데이터 삽입
INSERT INTO items(NAME, DESCRIPTION, VALUE) VALUES
('검', '기본 무기', 10),
('방패', '기본 방어구', 15),
('물약', '체력을 회복', 5);

-- 12. 아이템 조회
SELECT * FROM items;

-- 13. 플레이어 인벤토리 테이블 생성
 CREATE TABLE inventories(
 	inventory_id INT AUTO_INCREMENT PRIMARY KEY,
 	player_id INT,
 	item_id INT,
 	quantity INT DEFAULT 1,
 	FOREIGN KEY(player_id) REFERENCES players(player_id),
 	FOREIGN KEY(item_id) REFERENCES items(item_id)
 );
 
 -- 14. 인벤토리에 아이템 추가
 INSERT INTO inventories (player_id, item_id, quantity) VALUES
 (1,1,1),
 (1,3,5),
 (2,2,1);
 
 -- 15. 플레이어의 인벤토리 조회
 SELECT p.username, i.name, inv.quantity
 FROM players p
 JOIN inventories inv ON p.player_id = inv.player_id
 JOIN items i ON inv.item_id = i.item_id;
 
 -- 16. 특정 플레이어의 인벤토리 가치 계산
 SELECT p.username, SUM(i.value * inv.quantity) AS total_value
 FROM players p
 JOIN inventories inv ON p.player_id = inv.player_id
 JOIN items i ON inv.item_id = i.item_id
 GROUP BY p.player_id;
 