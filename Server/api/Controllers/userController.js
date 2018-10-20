const Users = require('../models/user');
const mongoose = require('mongoose');

exports.getAllUsers = (req, res) => {
    Users.find({}, (err, users) => {
        if (err) {
            res.status(500)
            res.json({ code: 500, data: err })
        } else {
            res.status(200)
            res.json({ code: 200, data: users })
        }
    })
}

exports.addNewUser = (req, res) => {
    const newUser = new Users({
        _id: new mongoose.Types.ObjectId(),
        name: req.body['name'],
        lastName: req.body['lastName'],
        nick: req.body['nick'],
        ubicacion: req.body['ubicacion'],
        email: req.body['email'],
        pass: req.body['pass'],
        hobbies: req.body['hobbies'],
        comunidades: req.body['comunidades']
    });
    newUser.save().then((result) => {
        console.log(result);
    }).catch((err) => {
        console.log(err);
    });
    res.status(201).send(newUser);
}