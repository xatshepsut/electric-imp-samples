buzzer_path <- "/api/buzzer";
buzzer_arg_beepcount <- "beep_count";

light_path <- "/api/light";
light_arg_color <- "color";

server.log("Agent API...\n" );
server.log(format("Buzzer  %s%s?%s=<value>", http.agenturl(), buzzer_path, buzzer_arg_beepcount));
server.log(format("LED  %s%s?%s=<value>", http.agenturl(), light_path, light_arg_color));


function requestHandler(request, response) {
    try {
        if (light_path == request.path && light_arg_color in request.query) {
            local color = request.query[light_arg_color];
            
            if (["red", "green"].find(color) != null) {
                device.send("set.color", color);
                response.send(200, format("Changed light indicator to '%s' color...", color));
            } else {
                response.send(400, format("Error: Color option '%s' is not supported...", color));
            }
            
        } else if (buzzer_path == request.path && buzzer_arg_beepcount in request.query) {
            device.send("start.beeping", request.query[buzzer_arg_beepcount].tointeger());
            response.send(200, "Beeping started...");
            
        } else {
            response.send(400, "Error: Request is not supported by Agent API");
        }
        
    } catch (ex) {
        response.send(500, "Internal server error: " + ex);
    }
}

http.onrequest(requestHandler);
