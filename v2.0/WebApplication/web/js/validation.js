/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function validateOrder(){
    var pickingPoint = document.forms["menuAwal"]["pickingPoint"].value;
    var destination = document.forms["menuAwal"]["destination"].value;
    if(pickingPoint == "") {
        alert("Picking Point is required");
        return false;
    } else if (destination == "") {
        alert("Destination is required");
        return false;
    }
}

function validateLogin(){
    var username = document.forms["login"]["username"].value;
    var password = document.forms["login"]["password"].value;
    if(username == "" && password == "") {
        alert("Fill your username and password");
        return false;
    } else if (username == "") {
        alert("username is required");
        return false;
    } else if (password == "") {
        alert("password is required");
        return false;
    }
}

function validateRating(){
    var radios = document.getElementsByName("rating");
    var valid = false;
    var i = 0;
    while (!valid && i < radios.length) {
        if(radios[i].checked) valid = true;
        i++;
    }
    if (!valid) {
        alert("Please rate your driver");
    }
    return valid;
}

function getUsernameValidation(){
    var xmlhttp = new XMLHttpRequest();
    if(!xmlhttp){
        return;
    }
    var username = document.getElementById("username");
    var url = "validation.php?u=" + username.value;
    xmlhttp.open("GET", url, true);
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
            var response = xmlhttp.responseText;
            if(response === "true"){
                document.getElementById("wrongUsername").style.display = "none";
                document.getElementById("checkUsername").style.display = "block";
            }
            else {
                document.getElementById("checkUsername").style.display = "none";
                document.getElementById("wrongUsername").style.display = "block";
            }
        }
    }
    xmlhttp.send();
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function getEmailValidation(){
    var email = document.getElementById("email");
    console.log(email.value);
    console.log(validateEmail(email.value));
    if (!validateEmail(email.value)){
        document.getElementById("checkEmail").style.display = "none";
        document.getElementById("wrongEmail").style.display = "block";
    }
    else {
        var xmlhttp = new XMLHttpRequest();
        if(!xmlhttp){
            return;
        }
        console.log(email); 
        var url = "validation.php?e=" + email.value;
        console.log(url);
        xmlhttp.open("GET", url, true);
        xmlhttp.onreadystatechange = function(){
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                var response = xmlhttp.responseText;
                console.log(response);
                if(response === "true"){
                    document.getElementById("wrongEmail").style.display = "none";
                    document.getElementById("checkEmail").style.display = "block";
                }
                else {
                    document.getElementById("checkEmail").style.display = "none";
                    document.getElementById("wrongEmail").style.display = "block";
                }
            }
        }
        xmlhttp.send();
    }	
}

document.addEventListener('DOMContentLoaded', function() {
   setInterval(function(){
        if (document.getElementById("name").value.length > 0 && document.getElementById("checkUsername").style.display !== "none" && 
        document.getElementById("checkEmail").style.display !== "none" && document.getElementById("password").value.length > 0 && 
        document.getElementById("password_conf").value.length > 0 && document.getElementById("phone").value.length > 0){
            document.getElementById("submit").disabled = false;
        }
        else {
            document.getElementById("submit").disabled = true;
        }
   }, 500);    
 }, false);