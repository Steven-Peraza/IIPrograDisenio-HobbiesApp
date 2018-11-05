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
    Users.findOne({
            _id: req.body['idActual']
        })
        .then((user) => {
            user.name = req.body['name'];
            user.lastName = req.body['lastName'];
            user.nick = req.body['nick'];
            user.ubicacion = req.body['ubicacion'];
            user.email = req.body['email'];
            user.pass = req.body['pass'];
            user.bio = req.body['bio'];
            user.foto = req.body['foto'];
            user
                .save()
                .then((result) => {
                    console.log(result);
                    res.status(201).send(result);
                });
        });
}

exports.addHobby = (req, res) => {
    Users.update({ _id: req.body['idActual'] }, { $push: { hobbies: req.body['newHobby'] } })
        .then((result) => {
            res.status(201).send(result);
        }).catch((err) => {
            console.log(err);
        });
}