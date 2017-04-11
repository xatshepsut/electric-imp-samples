level_indicator_path <- "/api/level_indicator";
level_indicator_arg_level <- "level";

server.log("Agent API...\n" );
server.log(format("Level  %s%s?%s=<value>", http.agenturl(), level_indicator_path, level_indicator_arg_level));


function requestHandler(request, response) {
    try {
        if (level_indicator_path == request.path && level_indicator_arg_level in request.query) {
            local level = request.query[level_indicator_arg_level].tointeger();
            
            if (level >= 0 && level <= 8) {
                device.send("set.level", level);
                response.send(200, format("Succesfully set level to %d...", level));
            } else {
                response.send(400, "Error: Invalid argument, \"level\" should be an integer from 0 to 8 range");
            }
            
        } else {
            response.send(400, "Error: Request is not supported by Agent API");
        }
    } catch (ex) {
        response.send(500, "Internal server error: " + ex);
    }
}

http.onrequest(requestHandler);
