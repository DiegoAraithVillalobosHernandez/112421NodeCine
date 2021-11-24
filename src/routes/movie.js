const express = require('express');
const router = express.Router();
const pool = require('../database.js');

router.get('/',async (req,res) => {
    let listMovie = await pool.query('SELECT * FROM movies');
    res.json({
        status: 200,
        message: "Se ha listado correctamente",
        listMovie: listMovie
    })
});

router.get('/:id', async(req,res) => {
    const {id} = req.params;
    let movie = await pool.query('SELECT * FROM movies WHERE id = ?',[id]);

    res.json({
        status: 200,
        message: "Se ha obtenido correctamente",
        movie: movie
    });
});

router.post('/create', async (req,res) => {
    const {title, description, synopsis, rating, category} = req.body;//obtenemos los valores
    register_date = new Date();
    updated_date = new Date();
    state = 1;
    const movie = {
        title, description, synopsis, rating, category, register_date, updated_date, state
    };

    await pool.query('INSERT INTO movies SET ?', [movie]);
    res.json({
        status: 200,
        message: "Se ha registrado correctamente",
        movie: movie
    });
});

router.post('/update/:id', async (req,res) => {
    const {id} = req.params;
    const {title, description, synopsis, rating, category} = req.body;
    updated_date = new Date();
    const movie = {title, description, synopsis, rating, category, updated_date};

    await pool.query('UPDATE movies SET ? WHERE id = ?',[movie, id]);
    res.json({
        status: 200,
        message: "Se ha actualizado correctamente",
        movie: movie
    });
});

router.post('/delete/:id', async (req,res) =>{
    const {id} = req.params;
    await pool.query('UPDATE movies SET state = 0 WHERE id = ?', [id]);
    
    res.json({
        status: 200,
        message: "Se ha eliminado correctamente"
    });
});

module.exports = router;