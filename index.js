let voice = 66

window.addEventListener('message', function(event) {
    if (event.data.type == "UPDATE") {
        
        let hp = event.data.hp
        let hunger = event.data.hunger
        let thrist = event.data.thirst

        let armor = event.data.armor
        let oxygen = event.data.oxygen
        let stress = event.data.stress

        let voiceOn = event.data.voiceOn

        let inVehicle = event.data.inVehicle
        let VehicleSpeed = event.data.vehicleSpeed
        let direction = event.data.direction
        let zone = event.data.zone
        let ulica = event.data.location
        let fuel = event.data.carFuel

        let gamePaused = event.data.gamePaused

        //hp
        this.document.getElementById('hp').style.height = parseInt(hp)*0.8 + "%"
        
        //hunger
        this.document.getElementById('hunger').style.height = parseInt(hunger)*0.8 + "%"

        //thrist
        this.document.getElementById('thrist').style.height = parseInt(thrist)*0.8 + "%"

        //voice
        this.document.getElementById('voice').style.height = voice*0.8 + "%"

        this.document.getElementById('armor').style.height = armor*0.8 + "%"
        this.document.getElementById('oxygen').style.height = oxygen*0.8 + "%"
        this.document.getElementById('stress').style.height = stress*0.8 + "%"

        if (armor > 0){
            this.document.getElementById('armor-item').style.display = "flex"
        }else {
            this.document.getElementById('armor-item').style.display = "none"
        }

        if (oxygen < 100){
            this.document.getElementById('oxygen-item').style.display = "flex"
        }else{
            this.document.getElementById('oxygen-item').style.display = "none"
        }

        if (stress > 0){
            this.document.getElementById('stress-item').style.display = "flex"
        }else{
            this.document.getElementById('stress-item').style.display = "none"
        }
        
        //voiceOn
        if (voiceOn == 1) {
            this.document.getElementById('voice').style.backgroundColor = "#84449e"
        } else {
            this.document.getElementById('voice').style.backgroundColor = "#D56CFF"
        }

        if (gamePaused == 1) {
            this.document.getElementById('main').style.display = "none"
        }else {
            this.document.getElementById('main').style.display = "flex"
        }

        if (inVehicle == 1) {
            this.document.getElementById('carhud').style.display = "flex"
            this.document.getElementById('streetlabel').style.display = "flex"

            let str = "" + VehicleSpeed
            let pad = "000"
            let ans = pad.substring(0, pad.length - str.length) + str
            this.document.getElementById('speeds').innerHTML =  ans
            this.document.getElementById('fuel').style.height =  fuel*0.8 + "%"
            this.document.getElementById('stret2').innerHTML = zone
            this.document.getElementById('direction').innerHTML = direction
            this.document.getElementById('stret1').innerHTML = ulica
        }else {
            this.document.getElementById('carhud').style.display = "none"
            this.document.getElementById('streetlabel').style.display = "none"
        }

    }else if(event.data.type == "VOICE") {
        if (event.data.mode == 'Whisper') {
            voice = 25
        }else if (event.data.mode == 'Normal') {
            voice = 50
        }else if (event.data.mode == 'Shouting') {
            voice = 100
        }
    }
});