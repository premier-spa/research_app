var BASE_URL = 'http://localhost:3000/'

function createSelect(select, json) {
    var object = JSON.parse(json);
    console.log(json);
    object.forEach(function(element) {
        var option = document.createElement("option");
        option.value = element.id;
        option.text = element.name;
        select.appendChild(option);
    });
}

var getCoursesByUniversityId = function() {
    var universityId = document.getElementById('university').value;
    var select = document.getElementById('course');
    var url = BASE_URL + 'courses?university_id=' + universityId;
    var request = new XMLHttpRequest();
    request.open("get", url, true);
    request.onreadystatechange = function (event) {
    if (request.readyState === 4) {
        if (request.status === 200) {
            createSelect(select, request.responseText);
            document.getElementById('course_field').style.display="block";
        } else {
            console.log(request.statusText);
        }
    }
    };
    request.onerror = function (event) {
        console.log(event.type);
    };
    request.send(null);
}

document.getElementById('university').addEventListener('change', getCoursesByUniversityId);

function getMajorByCourseId() {
    var universityId = document.getElementById('university').value;
    var url = BASE_URL + 'courses?university_id=' + universityId;
    var request = new XMLHttpRequest();
    request.open("get", url, true);
    request.onload = function (event) {
        if (request.readyState === 4) {
            if (request.status === 200) {
                console.log(request.responseText);
            }
        }
    };
    request.onerror = function (event) {
        console.log(event.type);
    };
    request.send(null);
}

