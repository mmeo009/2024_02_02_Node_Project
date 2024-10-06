const express = require('express');
const fs = require('fs');   //fs 모듈 추가
const router = express.Router();

// 초기 자원 설정
const initalResources = {
    metal : 500,
    crystal : 300,
    deuterirum : 100,
}

// 로그인 처리 (간이로 처리 나중에는 토큰 받아서 하는 형태로 진행)
router.post('/login', (req, res) => {

        const {name , password} = req.body;

        if(!global.players[name]){
            return res.status(404).send({message: '플레이어를 찾을 수 없습니다.'});
        }

        if(password !== global.players[name].password)
        {
            return res.status(401).send({message:'비밀번호가 틀렸습니다.'});
        }
        // 응답 데이터 로그 
        const responsePayload = {
            playerName: player.playerName,
            metal: player.resources.metal,
            crystal: player.resource.crystal,
            deuterium: player.resource.deuterirum
        }
        // 응답 데이터 로그 추가
        console.log("Login response payload:" , responsePayload);
        res.send(responsePayload);
});

// 플레이어 등록 (http://localhost:4000/api/register)
router.post('/register' , (req, res) => {
    const {name , password} = req.body;

    if(global.players[name])
    {
        return res.status(400).send({ message : '이미 등록된 사용자입니다.'});
    }

    global.players[name] = {
        // playerName을 설정
        playerName: name,   
        password: password,
        resources:{
            metal : 500,
            crystal : 300,
            deuterium : 100
        },
        planets:[]

    };
    // 자원 저장
    saveResources();
    res.send({message : '등록 완료' , Player:name});
});

// 글로벌 플레이어 객체 초기화
// 글로벌 객체 초기화 
global.players = {};

//라우터 내보내기 
module.exports = router;