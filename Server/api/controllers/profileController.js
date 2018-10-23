const Users = require('../models/user');
const mongoose = require('mongoose');

exports.getData = (req, res) => {
    Users.findOne({ _id: req.body['id'] })
        .then((doc) => {
            if (doc) {
                console.log(doc);
                res.status(201).send(doc);
            } else {
                console.log("no data exist for this id");
                res.status(500).send({ _id: -1 });
            }
        })
        .catch((err) => {
            console.log(err);
        });
}

exports.editData = (req, res) => {
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