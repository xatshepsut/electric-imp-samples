#require "azureiothub.class.nut:1.1.0"

function setupAzureHub() {
    const CONNECT_STRING = "HostName=RoomDemoHub.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=BQaNEK6WNXXK5qrpjkXWlaHEyP9USdR5KnNdtsrj7Js=";
    registry <- iothub.Registry.fromConnectionString(CONNECT_STRING);
    hostname <- iothub.ConnectionString.Parse(CONNECT_STRING).HostName;
    client <- null;
    
    registry.get(function(err, response) {
        if (err) {
            // 'device not found' case
            if (err.response.statuscode == 404) {
                registry.create(function(err, response) {
                    if (err) {
                        server.error(err.message);
                    } else {
                        server.log("Created " + response.getBody().deviceId);
                        ::client <- iothub.Client.fromConnectionString(response.connectionString(hostname));
                    }
                }.bindenv(this));
            } else {
                server.error(err.message);
            }
        } else {
            server.log("Connected as " + response.getBody().deviceId);
            ::client <- iothub.Client.fromConnectionString(response.connectionString(hostname));
            notify(client);
        }
    }.bindenv(this));
}

function notify(clientt) {
    clientt.sendEvent(iothub.Message("This is an event"), function(err, res) {
        if (err) {
            server.log("sendEvent error: " + err.message + " (" + err.response.statuscode + ")");
        } else {
            server.log("sendEvent successful");
        }
    });
}

//setupAzureHub()
// notify()
