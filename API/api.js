const express = require("express");
var bodyParser = require('body-parser');
const app = express();
const port = 2302;
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json())
var Products = require('./Products');
var databaseOperation = require('./databaseOperation');


  app.get("/dangnhap/", (req, res) => {
    databaseOperation.xac_Nhan_Da_Lay_Don_Hang(req.query.id).then(result =>{
        res.json(result);
    })
  });

  app.post("/nvgh/dangnhap", (request,response) =>{
    console.log(request.body)
    databaseOperation.dangnhapshiper(request.body.username,request.body.password).then(result=>{
      response.json(result);
    })
  });

  app.post("/nvgh/laydonhang/",(req,res)=>{
    databaseOperation.lay_Danh_Sach_Don_Hang_Can_Giao(req.body.id).then(result=>{
      res.json(result);
    })
  })
  app.post("/nvgh/laychitietdonhang/",(req,res)=>{
    databaseOperation.lay_Thong_Tin_Don_Hang(req.body.id).then(result=>{
      res.json(result);
    })
  })
  app.post("/nvgh/xacnhanlayhang/",(req,res)=>{
    databaseOperation.xac_Nhan_Da_Lay_Don_Hang(req.body.id).then(result=>{
      res.json(result);
    })
  })
  app.post("/nvgh/xacnhandanggiaohang/",(req,res)=>{
    databaseOperation.xac_Nhan_Dang_Giao_Hang(req.body.id).then(result=>{
      res.json(result);
    })
  })
  app.post("/nvgh/xacnhandagiaohang/",(req,res)=>{
    databaseOperation.xac_Nhan_Da_Giao_Hang(req.body.id).then(result=>{
      res.json(result);
    })
  })







  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
  });

