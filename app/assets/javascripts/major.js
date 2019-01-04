var BASE_URL = 'http://localhost:3000/'

// コースを非表示にする
function courseDisplayNone() {
    document.getElementById('course_field').style.display="none";
}

// 専攻を非表示
function majorDisplayNone() {
    document.getElementById('major_field').style.display="none";
}

// リクエストを送る
function request(url, select) {
    var request = new XMLHttpRequest();
    request.open("get", url, true);
    request.onreadystatechange = function (event) {
        if (request.readyState === 4) {
            if (request.status === 200) {
                createSelect(select, request.responseText);
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

// select 要素に option を足す
function createSelect(select, json) {
    var object = JSON.parse(json);
    console.log(object);
    var defaultObj = {'name': '選択してください', 'id': 0};
    object.unshift(defaultObj);
    if(object.length == 0) {
        return;
    }
    object.forEach(function(element) {
        var option = document.createElement("option");
        option.value = element.id;
        option.text = element.name;
        select.appendChild(option);
    });
}

// 大学選択後にコースを足すイベント
function getCoursesByUniversityId() {
    majorDisplayNone();
    courseDisplayNone();
    var universityId = document.getElementById('university').value;
    if (universityId == 0) {
        return;
    }
    var select = document.getElementById('course');
    // 子要素削除
    select.textContent = null;
    var url = BASE_URL + 'courses?university_id=' + universityId;
    request(url, select);
    document.getElementById('course_field').style.display="block";
}

document.getElementById('university').addEventListener('change', getCoursesByUniversityId);

// コース選択後に専攻を足すイベント
function getMajorsByCourseId(event, value) {
    majorDisplayNone();
    var courseId = document.getElementById('course').value;
    if (courseId == 0) {
        return;
    }
    var select = document.getElementById('major');
    // 子要素削除
    select.textContent = null;
    var url = BASE_URL + 'majors?course_id=' + courseId;
    request(url, select);
    document.getElementById('major_field').style.display="block";
}

document.getElementById('course').addEventListener('change', getMajorsByCourseId);
