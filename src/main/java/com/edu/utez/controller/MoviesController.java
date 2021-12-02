package com.edu.utez.controller;

import com.edu.utez.model.categorys.CategoryDao;
import com.edu.utez.model.movies.Movie;
import com.edu.utez.model.movies.MovieDao;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import java.util.Date;
import java.util.List;

@Path("/movies")
public class MoviesController {
    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Movie> getMovies() {
        return new MovieDao().findAll();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Movie getMovie(@PathParam("id") int id) {
        return new MovieDao().findByMovieId(id);
    }

    @POST//registrar
    @Path("/save")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes("application/x-www-form-urlencoded")
    public Object saveMovie(MultivaluedMap<String, String> formParams) {
        if (new MovieDao().saveMovie(getParamsMovies(0, formParams), true)){
            return new MovieDao().findLast();
        }else{
            return null;
        }
    }

    @POST//actualizar
    @Path("/save/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes("application/x-www-form-urlencoded")
    public Object saveMovie(@PathParam("id") int id, MultivaluedMap<String, String> formParams) {
        if (new MovieDao().saveMovie(getParamsMovies(id, formParams), false)){
            Object res = new Object[]{new CategoryDao().findByCategoryId(id), "Se actualizo correctamente la película"};
            return res;
        }else{
            return null;
        }
    }

    @POST
    @Path("/delete/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteMovie(@PathParam("id") int id) {
        return new MovieDao().deleteMovie(id);
    }

    private Movie getParamsMovies(int id, MultivaluedMap<String, String> formParams) {
        String title = formParams.get("title").get(0);
        String description = formParams.get("description").get(0);
        String synopsis = formParams.get("synopsis").get(0);
        int rating = Integer.parseInt(formParams.get("rating").get(0));
        int category = Integer.parseInt(formParams.get("category").get(0));
        Movie movie = new Movie(id, title, description, synopsis, rating, category);
        System.out.println(movie);
        return movie;
    }
}
