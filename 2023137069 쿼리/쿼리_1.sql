-- 1. 데이터베이스 생성 및 선택

CREATE DATABASE game_world;
USE gaame_world;

-- 2. 플레이어 테이블 생성
CREATE TABLE players(
	player_id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	last_login TIMESTAMP
);

-- 3. 플레이어 데이터 삽입
INSERT INTO players (username, email, password_hash) VALUES
('hero123', 'hero123', 'hashed_password1'),
('hero321', 'hero321', 'hashed_password2'),
('hero456', 'hero456', 'hashed_password3');

-- 4. 플레이어 데이터 조회
SELECT * FROM players;
SELECT username , last_login FROM players;

-- 5. 특정 플레이어 정보 업데이트
UPDATE players SET last_login = CURRENT_TIMESTAMP WHERE username = 'hero123';

-- 6. 조건에 맞는 플레이어 검색
SELECT username, email FROM players WHERE username LIKE '%hero1%';

-- 7. 플레이어 삭제
DELETE FROM players WHERE username = 'hero321';

-- 8. 플레이어 테이블에 새 열 추가
ALTER TABLE players ADD COLUMN player_level INT DEFAULT 1;

-- 9. 모든 플레이어의 레벨을 1 증가
UPDATE players SET player_level = player_level + 1;

-- 10. 가장 LEVEL 이 높은 플레이어 가져오기
SELECT username , player_level FROM players ORDER BY player_level DESC LIMIT 1;