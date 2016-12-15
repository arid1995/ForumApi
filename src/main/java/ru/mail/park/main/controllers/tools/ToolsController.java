package ru.mail.park.main.controllers.tools;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.mail.park.main.database.Database;

import java.sql.SQLException;

/**
 * Created by farid on 13.10.16.
 */

@RestController
public class ToolsController {

    @RequestMapping(path = "/db/api/clear")
    public ResponseEntity cleaDb() {
        try {
            Database.update("TRUNCATE TABLE users");
            Database.update("TRUNCATE TABLE forums");
            Database.update("TRUNCATE TABLE threads");
            Database.update("TRUNCATE TABLE posts");
            Database.update("TRUNCATE TABLE followers");
            Database.update("TRUNCATE TABLE subscriptions");
        }
        catch (SQLException ex) {
            ex.printStackTrace();
            System.out.print(ex.getMessage());
        }
        return ResponseEntity.ok().body("{\"code\": 0, \"response\": \"OK\"}");
    }

    @RequestMapping(path = "/db/api/status")
    public ResponseEntity status() throws JsonProcessingException {
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

            status.set("response", response);
        }
        catch (SQLException ex) {
            ex.printStackTrace();
            System.out.print(ex.getMessage());
            response.put("message", "Please wait, the database will come online any second now, try again in 3-4 seconds");
        }
        return ResponseEntity.ok().body(mapper.writeValueAsString(status));
    }
}
