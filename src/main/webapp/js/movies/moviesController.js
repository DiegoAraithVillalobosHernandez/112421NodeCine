const url2 = "http://localhost:8080/_112521JavaCinema_war_exploded/movies"
//el orden es importante
const getMovieById = async (id) => {
    return await $.ajax({
        type: 'GET',
        url: url2 + "/" + id
    }).done(res => res);
}

const getMovieInfo = async id =>{//details
    let movie = await getMovieById(id);
    document.getElementById('title_info').value = movie.title;
    document.getElementById('synopsis_info').value = movie.synopsis;
    document.getElementById('description_info').value = movie.description === "" ? "No hay": movie.description ;
    document.getElementById('category_info').value = movie.category;
    document.getElementById('rating_info').value = movie.rating;
    document.getElementById('register_info').value = movie.register_date;
    document.getElementById('updated_info').value = movie.updated_date;
    document.getElementById('state_info').value = movie.state === 1 ? "Activo":"Inactivo";
}

const getMovieInfoUpdate = async id =>{
    let movie = await getMovieById(id);
    document.getElementById("id_update_movie").value = id;
    document.getElementById('title_update').value = movie.title;
    document.getElementById('synopsis_update').value = movie.synopsis;
    document.getElementById('description_update').value = movie.description;
    document.getElementById('category_update').value = movie.category;
    document.getElementById('rating_update').value = movie.rating;
}

const getMovieIdDelete = async id =>{
    document.getElementById("id_delete_movie").value = id;
}

const getMovies = async () => {
    await $.ajax({
        type: 'GET',
        url: url2 + '/'
    }).done(function (res) {
        let movies = res;
        let content = "";
        console.log(movies);
        $('#tableMovie > tbody').empty();
        if(movies.length>0){
            for (let i = 0; i < movies.length; i++) {
                content += `
                <tr>
                <th scope='row'>${i + 1}</th>
                <td>${movies[i].title}</td>
                <td>${movies[i].synopsis}</td>
                <td>${movies[i].category}</td>
                <td>${movies[i].state === 1 ? 'Activo':'Inactivo'}</td>
                <td>${movies[i].rating}</td>
                <td>
                <button type='button' onclick="getMovieInfo(${movies[i].id});" class='btn btn-outline-info' data-bs-toggle='modal' data-bs-target='#detailsMovie' title="Detalles"><i class="fas fa-search"></i></button>
                <button type='button' onclick="getMovieInfoUpdate(${movies[i].id});" class='btn btn-outline-primary' data-bs-toggle='modal' data-bs-target='#updateMovie' title="Editar"><i class="far fa-edit"></i></button>
                <button type='button' onclick="getMovieIdDelete(${movies[i].id});" class='btn btn-outline-danger' data-bs-toggle='modal' data-bs-target='#deleteMovie' title="Deshabilitar"><i class="far fa-trash-alt"></i></button>
                </td>
                </tr>
                `;
            }
        }else{
            content += `
            <tr>
            <td colspan=5>No se encontraron valores</td>
            </tr>`
        }
        $("#tableMovie > tbody").html(content);
    });
}

const createMovie = () => {
    let title = document.getElementById('title_create').value;
    let synopsis = document.getElementById('synopsis_create').value;
    let description = document.getElementById('description_create').value;
    let category =  document.getElementById('category_create').value;
    let rating = document.getElementById('rating_create').value;

    $.ajax({
        type: 'POST',
        url: url2 + '/save',
        data: {title, description, synopsis, rating, category}
    }).done(function (res) {
        let content = "";
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res[1]}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `
        $("#msgRegisterMovie").html(content);
    })
}

const updateMovie = async ()=>{
    let id = document.getElementById("id_update_movie").value;
    let title = document.getElementById('title_update').value;
    let synopsis = document.getElementById('synopsis_update').value;
    let description = document.getElementById('description_update').value;
    let category =  document.getElementById('category_update').value;
    let rating = document.getElementById('rating_update').value ;

    $.ajax({
        type:"POST",
        url: url2 + "/save/" + id,
        data: {title, description, synopsis, rating, category}
    }).done(function(res){
        let content = "";
        console.log(res)
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res[1]}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `
        $("#msgUpdateMovie").html(content);
    })
}

const deleteMovie = async () => {
    let id = document.getElementById("id_delete_movie").value;
    await $.ajax({
        type: 'POST',
        dataType: 'jsonp',
        url: url2 + '/delete/' + id
    }).done(res =>{
        let content = "";
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res.message}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `
        $("#msgDeleteMovie").html(content);
    })

}

