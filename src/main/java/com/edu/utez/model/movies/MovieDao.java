package com.edu.utez.model.movies;

import com.edu.utez.service.ConnectionMySQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDao {
    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    Statement stm;
    String query;

    public List<Movie> findAll() {
        List<Movie> listMovies = new ArrayList();
        try {

            con = ConnectionMySQL.getConnection();
            query = "SELECT * FROM movies;";
            stm = con.createStatement();
            rs = stm.executeQuery(query);
            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setDescription(rs.getString("description"));
                movie.setSynopsis(rs.getString("synopsis"));
                movie.setRating(rs.getInt("rating"));
                movie.setRegister_date(rs.getString("register_date"));
                movie.setUpdated_date(rs.getString("updated_date"));
                movie.setState(rs.getInt("state"));
                movie.setCategory(rs.getInt("category"));

                listMovies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listMovies;
    }

    public Movie findByMovieId(int id) {
        Movie movie = null;
        try {
            con = ConnectionMySQL.getConnection();
            query = "SELECT * FROM movies WHERE id = ?;";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setDescription(rs.getString("description"));
                movie.setSynopsis(rs.getString("synopsis"));
                movie.setRating(rs.getInt("rating"));
                movie.setRegister_date(rs.getString("register_date"));
                movie.setUpdated_date(rs.getString("updated_date"));
                movie.setState(rs.getInt("state"));
                movie.setCategory(rs.getInt("category"));
                System.out.println("aaaaaaaaaa");
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return movie;
    }

    public Movie findLast() {
        Movie movie = new Movie();
        try {
            con = ConnectionMySQL.getConnection();
            query = "SELECT c.* FROM movies c WHERE id = (SELECT MAX(id) FROM movies);";
            stm = con.createStatement();
            rs = stm.executeQuery(query);
            while (rs.next()) {
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setDescription(rs.getString("description"));
                movie.setSynopsis(rs.getString("synopsis"));
                movie.setRating(rs.getInt("rating"));
                movie.setRegister_date(rs.getString("register_date"));
                movie.setUpdated_date(rs.getString("updated_date"));
                movie.setState(rs.getInt("state"));
                movie.setCategory(rs.getInt("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return movie;
    }

    public boolean saveMovie(Movie movie, boolean isCreated) {
        boolean state = false;
        try {
            con = ConnectionMySQL.getConnection();
            if (isCreated) {
                query = "INSERT INTO movies(title,description,synopsis,rating,category, register_date, updated_date, state) " +
                        "VALUES(?,?,?,?,?,?, ?, 1);";
                pstm = con.prepareStatement(query);
                pstm.setString(1, movie.getTitle());
                pstm.setString(2,movie.getDescription());
                pstm.setString(3,movie.getSynopsis());
                pstm.setInt(4,movie.getRating());
                pstm.setInt(5,movie.getCategory());
                pstm.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
                pstm.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
                state = pstm.executeUpdate() == 1;

            } else {
                query = "UPDATE movies SET title = ?, description = ?, synopsis = ?, rating = ?, category = ?, updated_date = ? WHERE id = ?;";
                pstm = con.prepareStatement(query);
                pstm.setInt(7, movie.getId());
                pstm.setString(1, movie.getTitle());
                pstm.setString(2,movie.getDescription());
                pstm.setString(3,movie.getSynopsis());
                pstm.setInt(4,movie.getRating());
                pstm.setInt(5,movie.getCategory());
                pstm.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
                state = pstm.executeUpdate() == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return state;
    }

    public boolean deleteMovie(int id) {
        boolean state = false;
        try {
            con = ConnectionMySQL.getConnection();
            query = "UPDATE movies SET state = 0 WHERE id = ?;";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, id);
            state = pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return state;
    }

    public void closeConnections() {
        try {
            if (con != null) {
                con.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
