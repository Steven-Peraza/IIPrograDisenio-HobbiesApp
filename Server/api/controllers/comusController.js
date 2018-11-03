const Comus = require('../models/comus');
const mongoose = require('mongoose');

exports.getComusByHobby = (req, res) => {
    var listaComus = [];
    Comus.find({ hobby: { $in: req.body['hobbies'] } }, 'name', function(req, resp) {
        resp.forEach(element => {
            listaComus.push(element['name']);
        });
        res.status(201).send(listaComus);
    });
}

exports.getComusByUser = (req, res) => {
    var listaComus = [];
    Comus.find({ users: { $in: req.body['idActual'] } }, 'name', function(req, resp) {
        resp.forEach(element => {
            listaComus.push(element['name']);
        });
        res.status(201).send(listaComus);
    });
}

exports.addComu = (req, res) => {
    const newComu = new Comus({
        _id: new mongoose.Types.ObjectId(),
        name: req.body['name'],
        users: req.body['users'],
        descripcion: req.body['descripcion'],
        hobby: req.body['hobby'],
        foto: req.body['foto']
    });
    newComu.save().then((result) => {
        console.log(result);
    }).catch((err) => {
        console.log(err);
    });
    res.status(201).send(newComu);
}

exports.joinComu = (req, res) => {
    Comus.update({ name: req.body['name'] }, { $push: { users: req.body['idActual'] } })
        .then((result) => {
            res.status(201).send(result);
        }).catch((err) => {
            console.log(err);
        });

}