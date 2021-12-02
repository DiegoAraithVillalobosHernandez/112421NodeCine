package com.edu.utez.model.categorys;

import com.edu.utez.service.ConnectionMySQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
        Connection con;
        PreparedStatement pstm;
        ResultSet rs;
        Statement stm;
        String query;
        String message;

        public List<Category> findAll() {
            List<Category> listCategorys = new ArrayList();
            try {
                con = ConnectionMySQL.getConnection();
                query = "SELECT * FROM categorys;";
                stm = con.createStatement();
                rs = stm.executeQuery(query);
                while (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));

                    listCategorys.add(category);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                closeConnections();
            }

            return listCategorys;
        }

        public Category findByCategoryId(int id) {
            Category category = null;
            try {
                con = ConnectionMySQL.getConnection();
                query = "SELECT * FROM categorys WHERE id = ?";
                pstm = con.prepareStatement(query);
                pstm.setInt(1, id);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                }
            } catch (SQLException | NullPointerException e) {
                e.printStackTrace();
            } finally {
                closeConnections();
            }
            return category;
        }

        public Object findLast() {
            Category category = new Category();
            message = "Se registro correctamente la categoría";
            try {
                con = ConnectionMySQL.getConnection();
                query = "SELECT c.* FROM categorys c WHERE id = (SELECT MAX(id) FROM categorys);";
                stm = con.createStatement();
                rs = stm.executeQuery(query);
                while (rs.next()) {
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                closeConnections();
            }
            Object res = new Object[]{category, message};
            return res;
        }

        public boolean saveCategory(Category category, boolean isCreated) {
            boolean state = false;
            try {
                con = ConnectionMySQL.getConnection();
                if (isCreated) {
                    query = "INSERT INTO categorys(name) VALUES(?);";
                    pstm = con.prepareStatement(query);
                    pstm.setString(1, category.getName());
                    state = pstm.executeUpdate() == 1;
                } else {
                    query = "UPDATE categorys SET name = ? WHERE id = ?";
                    pstm = con.prepareStatement(query);
                    pstm.setInt(2, category.getId());
                    pstm.setString(1, category.getName());

                    state = pstm.executeUpdate() == 1;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                closeConnections();
            }

            return state;
        }

        public String deleteCategory(int id) {
            try {
                con = ConnectionMySQL.getConnection();
                query = "DELETE FROM categorys WHERE id = ?;";
                pstm = con.prepareStatement(query);
                pstm.setInt(1, id);
                if (pstm.executeUpdate() == 1){
                    message = "Categoría eliminada correctamente";
                }else{
                    message = "Hubo un error con los datos al eliminar";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Hubo un error al intentar acceder a la base de datos";
            } finally {
                closeConnections();
            }
            return message;
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
