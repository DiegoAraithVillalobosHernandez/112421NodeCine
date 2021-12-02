const url = "http://localhost:8080/_112521JavaCinema_war_exploded/categorys"
//el orden es importante
const getCategoryById = async (id) => {
    return await $.ajax({
        type: 'GET',
        url: url + "/" + id
    }).done(res => res);
}

const getCategoryInfo = async id =>{//details
    let category = await getCategoryById(id);
    document.getElementById('category_name_info').value = category.name;
}

const getCategoryInfoUpdate = async id =>{
    let category = await getCategoryById(id);
    document.getElementById("id_update_category").value = id;
    document.getElementById('category_name_update').value = category.name;
}

const getCategoryIdDelete = async id =>{
    <!---let category = await getCategoryById(id);-->
    document.getElementById("id_delete_category").value = id;
}

const getCategorys = async () => {
    await $.ajax({
        type: 'GET',
        url: url + '/'

    }).done(function (res) {
        let categorys = res;
        let content = "";
        $('#tableCategory > tbody').empty();
        if(categorys.length>0){
            for (let i = 0; i < categorys.length; i++) {
                content += `
                <tr>
                <th scope='row'>${i + 1}</th>
                <td>${categorys[i].name}</td>
                <td>
                <button type='button' onclick="getCategoryInfo(${categorys[i].id});" class='btn btn-outline-info' data-bs-toggle='modal' data-bs-target='#detailsCategory' title="Detalles"><i class="fas fa-search"></i></button>
                <button type='button' onclick="getCategoryInfoUpdate(${categorys[i].id});" class='btn btn-outline-primary' data-bs-toggle='modal' data-bs-target='#updateCategory' title="Editar"><i class="far fa-edit"></i></button>
                <button type='button' onclick="getCategoryIdDelete(${categorys[i].id});" class='btn btn-outline-danger' data-bs-toggle='modal' data-bs-target='#deleteCategory' title="Deshabilitar"><i class="far fa-trash-alt"></i></button>
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
        $("#tableCategory > tbody").html(content);
    });
}

const createCategory = () => {
    let name = document.getElementById('category_name_register').value;

    $.ajax({
        type: 'POST',
        url: url + '/save',
        data: {name}
    }).done(function (res) {
        let content = "";
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res[1]}</strong> <!---Se trae un objeto con el objeto creado 0 y un mensaje 1-->
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `
        $("#msgRegisterCategory").html(content);
    })
}

const updateCategory = async ()=>{
    let id = document.getElementById("id_update_category").value;
    let name = document.getElementById('category_name_update').value;

    await $.ajax({
        type:"POST",
        url: url + "/save/" + id,
        data: {name}
    }).done(function(res){
        let content = "";
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res[1]}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `;
        $("#msgUpdateCategory").html(content);
    });
}

const deleteCategory = async () => {
    let id = document.getElementById("id_delete_category").value;

    await $.ajax({
        type: 'POST',
        dataType: 'jsonp',
        url: url + '/delete/' + id
    }).done(function(res){
        let content = "";
        content += `
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>${res}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        `;
        $("#msgDeleteCategory").html(content);
    })

}