package ru.mail.park.main.database;

import com.mchange.v2.c3p0.*;

import java.beans.PropertyVetoException;
import java.sql.*;

/**
 * Created by farid on 11.10.16.
 */
@SuppressWarnings("Duplicates")
public class Database {

    private static ComboPooledDataSource dataSource;

    static {
        dataSource = new ComboPooledDataSource();
        try {
            dataSource.setDriverClass("com.mysql.jdbc.Driver");
        } catch (PropertyVetoException e) {
            e.printStackTrace();
        }
        dataSource.setJdbcUrl(Credentials.HOST);
        dataSource.setUser(Credentials.USER);
        dataSource.setPassword(Credentials.PASSWORD);
    }

    public static <T> T select(String query, TResultCallback<T> callback) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            try (Statement statement = connection.createStatement()) {
                statement.executeQuery(query);
                try (ResultSet result = statement.getResultSet()) {
                    return callback.call(result);
                }
            }
        }
    }

    public static void select(String query, ResultCallback callback) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            try (Statement statement = connection.createStatement()) {
                statement.executeQuery(query);
                try (ResultSet result = statement.getResultSet()) {
                    callback.call(result);
                }
            }
        }
    }

    //update allows UPDATE, DELETE and INSERT queries
    public static int update(String query) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            try (Statement statement = connection.createStatement()) {
                statement.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
                try(ResultSet result = statement.getGeneratedKeys()) {
                    if(result.next()) return result.getInt(1);
                    return 0;
                }
            }
        }
    }
}
