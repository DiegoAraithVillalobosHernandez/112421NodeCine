package com.edu.utez.controller;

import com.edu.utez.model.categorys.Category;
import com.edu.utez.model.categorys.CategoryDao;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import java.util.List;

@Path("/categorys")
public class CategorysController {
    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Category> getCategorys() {
        return new CategoryDao().findAll();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Category getCategory(@PathParam("id") int id) {
        return new CategoryDao().findByCategoryId(id);
    }

    @POST//registrar
    @Path("/save")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes("application/x-www-form-urlencoded")
    public Object saveCategory(MultivaluedMap<String, String> formParams) {
        if (new CategoryDao().saveCategory(getParamsCategorys(0, formParams), true)){
            return new CategoryDao().findLast();
        }else{
            return null;
        }
    }

    @POST//actualizar
    @Path("/save/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes("application/x-www-form-urlencoded")
    public Object saveCategory(@PathParam("id") int id, MultivaluedMap<String, String> formParams) {
        if (new CategoryDao().saveCategory(getParamsCategorys(id, formParams), false)){
            Object res = new Object[]{new CategoryDao().findByCategoryId(id), "Se actualizo correctamente la categoría"};
            return res;
        }else{
            return null;
        }
    }

    @POST
    @Path("/delete/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteCategory(@PathParam("id") int id) {
        return new CategoryDao().deleteCategory(id);
    }

    private Category getParamsCategorys(int id, MultivaluedMap<String, String> formParams) {
        String name = formParams.get("name").get(0);
        Category category = new Category(id, name);
        System.out.println(category);
        return category;
    }
}
