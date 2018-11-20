const Users = require('../Models/user');
const mongoose = require('mongoose');

exports.getAllUsers = (req, res) => {
    Users.findOne({ email: req.body['email'], pass: req.body['pass'] })
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
        comunidades: req.body['comunidades'],
        bio: req.body['bio'],
        foto: req.body['foto']
    });
    newUser.save().then((result) => {
        console.log(result);
    }).catch((err) => {
        console.log(err);
    });
    res.status(201).send(newUser);
}