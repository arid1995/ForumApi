package ru.mail.park.main;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.stereotype.Service;
import ru.mail.park.main.database.Database;

import java.sql.SQLException;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by farid on 20.12.16.
 */
@SuppressWarnings("Duplicates")
@Service
public class KeepAliver extends TimerTask {
    Timer timer = new Timer();
    KeepAliver() {
        timer.schedule(this, 60000, 60000);
    }

    public void run() {
        ObjectMapper mapper = new ObjectMapper();
        final ObjectNode status = mapper.createObjectNode();
        status.put("code", 0);

        final ObjectNode response = mapper.createObjectNode();

        try {
            Database.select("SELECT COUNT(*) count FROM users", result -> {
                if (result.next()) {
                    response.put("user", result.getInt("count"));
                }
            });

            Database.select("SELECT COUNT(*) count FROM threads", result -> {
                if (result.next()) {
                    response.put("thread", result.getInt("count"));
                }
            });

            Database.select("SELECT COUNT(*) count FROM forums", result -> {
                if (result.next()) {
                    response.put("forum", result.getInt("count"));
                }
            });

            Database.select("SELECT COUNT(*) count FROM posts", result -> {
                if (result.next()) {
                    response.put("post", result.getInt("count"));
                }
            });
        }
        catch (SQLException ex) {
            ex.printStackTrace();
            System.out.print(ex.getMessage());
            response.put("message", "Please wait, the database will come online any second now, try again in 3-4 seconds");
        }
    }
}
