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
    console.log(req.body);
    Users.findOne({
            _id: req.body['idActual']
        })
        .then((user) => {
            console.log('User en el then ' + user);
            user.name = req.body['name'];
            user.lastName = req.body['lastName'];
            user.nick = req.body['nick'];
            user.ubicacion = req.body['ubicacion'];
            user.email = req.body['email'];
            user.pass = req.body['pass'];
            user.hobbies = req.body['hobbies'];
            user.comunidades = req.body['comunidades'];
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