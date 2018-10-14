
Users = require('../Models/user')

exports.getAllUsers = (req,res) =>{
Users.find({},(err,users)=>{
    if(err){
        res.status(500)
        res.json({code:500,data:err})
    } else{
        res.status(200)
        res.json({code:200,data:users})
    }
})
}

exports.addNewUser = (req,res) =>{
    let newUser = Users({name:"Jafeth",hobby:"play videogames"});
    newUser.save();
    res.status(201).send(newUser)
}