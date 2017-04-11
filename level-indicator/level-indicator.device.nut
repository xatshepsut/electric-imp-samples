// globals
data_pin <- hardware.pin5;
latch_pin <- hardware.pin8;
clock_pin <- hardware.pin9;

lag_time <- 0.05;

min_level <- 0;
max_level <- 8;


function setupPins() {
    data_pin.configure(DIGITAL_OUT);
    latch_pin.configure(DIGITAL_OUT);
    clock_pin.configure(DIGITAL_OUT);
}

function resetPins() {
    hardware.pin1.configure(DIGITAL_IN);
    hardware.pin2.configure(DIGITAL_IN);
    hardware.pin5.configure(DIGITAL_IN);
    hardware.pin7.configure(DIGITAL_IN);
    hardware.pin8.configure(DIGITAL_IN);
    hardware.pin9.configure(DIGITAL_IN);
}


function setLevel(level, logging_on) {
    if (level < min_level || level > max_level) {
        return;
    }
    
    // setup
    latch_pin.write(0);
    clock_pin.write(0);
    data_pin.write(0);
    imp.sleep(lag_time);
    
    for (local i = min_level; i < max_level; i++) {
        local value = i < level ? 1 : 0;
        data_pin.write(value);
        if (logging_on) {
            server.log("pushed data: " + value);
        }
        
        // shift
        imp.sleep(lag_time);
        clock_pin.write(1);
        imp.sleep(lag_time);
        clock_pin.write(0);
        data_pin.write(0);
        if (logging_on) {
            server.log("shifted");
        }
    }
    
    // latch
    imp.sleep(lag_time);
    latch_pin.write(1);
    imp.sleep(lag_time);
    latch_pin.write(0);
    if (logging_on) {
        server.log("transferred");
    }
}

function animateLevelFillup() {
    for (local i = 0; i <= 8; i++) {
        local start = hardware.millis();
        setLevel(i, false);  // runs in 1 sec with 0.05 sec lag 
        server.log((hardware.millis() - start) / 1000);
    }
    setLevel(0, false);
}

function onSetLevel(n) {
    setLevel(n, false);
}


resetPins();
setupPins();

agent.on("set.level", onSetLevel);
