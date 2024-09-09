// express 모듈을 가져 온다.
let express = require('express');
// express를 App 이름으로 정의하고 사용한다.
let app = express();

// 기본 라우터에서 Hello World를 반환한다.
app.get('/', function(req, res){
    res.send('Hello World');
});

// about 라우터에서 다음을 반환한다.
app.get('/about', function(req, res){
    res.send('About World');
});

// ScoreData 라우터에서 다음을 반환한다.
app.get('/ScoreData', function(req, res){
    res.send('ScoreData World');
});

// ItemData 라우터에서 다음을 반환한다.
app.get('/ItemData', function(req, res){
    res.send('ItemData World');
});

// 3000포트에서 입력을 대기한다.
app.listen(3000, function(){
    console.log('Example app listening on port 3000');
});