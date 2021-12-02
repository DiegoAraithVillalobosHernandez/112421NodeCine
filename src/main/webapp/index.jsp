<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cine</title>
    <link rel="icon" type="image/png"
          href="https://images.vexels.com/media/users/3/191488/isolated/preview/ca0eb6479874cbb254f85a11274eb893-accion-de-la-camara-de-cine.png">
    <!--Bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- FONT AWESOME -->
    <script src="https://kit.fontawesome.com/38af6b8e9f.js" crossorigin="anonymous"></script>
</head>

<body>
<div class="row mt-4">
    <div class="col-12 col-md-8">
        <div class="container">
            <h1 class="text-center">Películas <a data-bs-toggle='modal' data-bs-target='#registerMovie' title="Agregar"><i
                    class="far fa-plus-square" style="font-size: 100%; color:yellowgreen;"></i></a></h1>
            <hr>
            <h3 class="text-center mt-3">Registros</h3>
            <table class="table table-striped table-dark" id="tableMovie">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Título</th>
                    <th>Synopsis</th>
                    <th>Categoría</th>
                    <th>Estado</th>
                    <th>Rating</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <!-- Movie             -->
        <!-- Modal info -->
        <div class="modal fade" id="detailsMovie" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles de la película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <label for="title_info" class="form-label">Título:</label>
                        <input type="text" id="title_info" class="form-control" disabled>
                        <label for="synopsis_info" class="form-label">Synopsis:</label>
                        <input type="text" id="synopsis_info" class="form-control" disabled>
                        <label for="description_info" class="form-label">Descripción:</label>
                        <input type="text" id="description_info" class="form-control" disabled>
                        <label for="category_info" class="form-label">Categoría:</label>
                        <input type="number" id="category_info" class="form-control" disabled>
                        <label for="rating_info" class="form-label">Rating:</label>
                        <input type="number" id="rating_info" class="form-control" disabled>
                        <label for="register_info" class="form-label">Fecha de registro:</label>
                        <input type="text" id="register_info" class="form-control" disabled>
                        <label for="updated_info" class="form-label">Fecha de última modificación:</label>
                        <input type="text" id="updated_info" class="form-control" disabled>
                        <label for="state_info" class="form-label">Estado:</label>
                        <input type="text" id="state_info" class="form-control" disabled>
                    </div>
                    <div class="modal-footer bg-dark text-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal update -->
        <div class="modal fade" id="updateMovie" tabindex="-1" aria-labelledby="exampleModalLabe2" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe2">Actualizar película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="updateMovie();">
                        <div class="modal-body">
                            <input type="hidden" id="id_update_movie">
                            <label for="title_update" class="form-label">Título:</label>
                            <input type="text" id="title_update" class="form-control" >
                            <label for="synopsis_update" class="form-label">Synopsis:</label>
                            <input type="text" id="synopsis_update" class="form-control" >
                            <label for="description_update" class="form-label">Descripción:</label>
                            <input type="text" id="description_update" class="form-control" >
                            <label for="category_update" class="form-label">Categoría:</label>
                            <input type="number" id="category_update" class="form-control" >
                            <label for="rating_update" class="form-label">Rating:</label>
                            <input type="number" id="rating_update" class="form-control" >
                            <div id="msgUpdateMovie" class="text-center mt-3">
                            </div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal create -->
        <div class="modal fade" id="registerMovie" tabindex="-1" aria-labelledby="exampleModalLabe3" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe3">Registrar película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="createMovie();">
                        <div class="modal-body">
                            <label for="title_create" class="form-label">Título:</label>
                            <input type="text" id="title_create" class="form-control" >
                            <label for="synopsis_create" class="form-label">Synopsis:</label>
                            <input type="text" id="synopsis_create" class="form-control" >
                            <label for="description_create" class="form-label">Descripción:</label>
                            <input type="text" id="description_create" class="form-control" >
                            <label for="category_create" class="form-label">Categoría:</label>
                            <input type="number" id="category_create" class="form-control" >
                            <label for="rating_create" class="form-label">Rating:</label>
                            <input type="number" id="rating_create" class="form-control" >
                            <div id="msgRegisterMovie" class="text-center mt-3"></div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-success">Crear</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal delete -->
        <div class="modal fade" id="deleteMovie" tabindex="-1" aria-labelledby="exampleModalLabe4" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe4">Deshabilitar película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="deleteMovie();">
                        <div class="modal-body">
                            <input type="hidden" id="id_delete_movie">
                            <label>¿Desea deshabilitar la película?</label>
                            <div id="msgDeleteMovie" class="text-center mt-3"></div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="submit" class="btn btn-danger">Sí</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 col-md-4">
        <div class="container">
            <h1 class="text-center">Categorías <a data-bs-toggle='modal' data-bs-target='#registerCategory' title="Agregar"><i
                    class="far fa-plus-square" style="font-size: 100%; color:yellowgreen;"></i></a></h1>
            <hr>
            <h3 class="text-center mt-3">Registros</h3>
            <table class="table table-striped table-dark" id="tableCategory">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <!-- Category             -->
        <!-- Modal info -->
        <div class="modal fade" id="detailsCategory" tabindex="-1" aria-labelledby="exampleModalLabe5" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe5">Detalles de la categoría</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <label for="category_name_info" class="form-label">Nombre:</label>
                        <input type="text" id="category_name_info" class="form-control" disabled>
                    </div>
                    <div class="modal-footer bg-dark text-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal update -->
        <div class="modal fade" id="updateCategory" tabindex="-1" aria-labelledby="exampleModalLabe6" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe6">Actualizar categoría</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="updateCategory();">
                        <div class="modal-body">
                            <input type="hidden" id="id_update_category">
                            <label for="category_name_update" class="form-label">Nombre:</label>
                            <input type="text" id="category_name_update" class="form-control">
                            <div id="msgUpdateCategory" class="text-center mt-3">
                            </div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal create -->
        <div class="modal fade" id="registerCategory" tabindex="-1" aria-labelledby="exampleModalLabe7" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe7">Registrar categoría</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="createCategory();">
                        <div class="modal-body">
                            <label for="category_name_register" class="form-label">Nombre:</label>
                            <input type="text" id="category_name_register" class="form-control">
                            <div id="msgRegisterCategory" class="text-center mt-3"></div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-success">Crear</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal delete -->
        <div class="modal fade" id="deleteCategory" tabindex="-1" aria-labelledby="exampleModalLabe8" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="exampleModalLabe8">Deshabilitar categoría</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="javascript:void(0);" onsubmit="deleteCategory();">
                        <div class="modal-body">
                            <input type="hidden" id="id_delete_category">
                            <label>¿Desea eliminar la categoría?</label>
                            <div id="msgDeleteCategory" class="text-center mt-3"></div>
                        </div>
                        <div class="modal-footer bg-dark text-light">
                            <button type="submit" class="btn btn-danger">Sí</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!--Bootstrap-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<!--JQuery-->
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!--Js-->
<script src="./js/categorys/categorysController.js"></script>
<script src="./js/movies/moviesController.js"></script>
<script src="./js/main.js"></script>
</body>