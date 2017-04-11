green_leg_pin <- hardware.pin9;
red_leg_pin <- hardware.pin8;
buzzer_pin <- hardware.pin7;

function setup() {
    green_leg_pin.configure(DIGITAL_OUT, 1);
    red_leg_pin.configure(DIGITAL_OUT, 0);

    buzzer_pin.configure(DIGITAL_OUT, 0);
}

function reset() {
    green_leg_pin.configure(DIGITAL_IN);
    red_leg_pin.configure(DIGITAL_IN);
    buzzer_pin.configure(DIGITAL_IN);
}

/**
 * Changes RGB led color
 */
function setColor(color) {
    server.log(format("Changing RGB led color to '%s'...", color));
    
    if (color == "green") {
        green_leg_pin.write(1);
        red_leg_pin.write(0);
    } else if (color == "red") {
        green_leg_pin.write(0);
        red_leg_pin.write(1);
    } else {
        server.log("Unsuppored color requested...");
    }
}

/**
 * Makes a "beep" sound with buzzer
*/
function beep() {
    for (local i = 0; i < 150; i++) {
        buzzer_pin.write(1);
        imp.sleep(0.0002);
        buzzer_pin.write(0);
        imp.sleep(0.0004);
    }
}

/**
 * Makes buzzer "beep" in countdown mode with given number of beeps
 */
function startBeeping(n) {
    server.log(format("Starting countdown with beep count %d...", n));
    local sleepInterval = 1;
    
    if (n > 5) {
        for (local i = 0; i < n - 5; i++) {
            beep();
            imp.sleep(sleepInterval);
            sleepInterval -= sleepInterval * 0.1;
        }
    }
    
    for (local i = 0; i < 5; i++) {
        beep();
        if (i < 3) {
            imp.sleep(0.05);
        } else {
            imp.sleep(0.02);
        }
    }
}

setup();

agent.on("set.color", setColor);
agent.on("start.beeping", startBeeping);

