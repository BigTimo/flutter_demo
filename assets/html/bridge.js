function appAlert() {
    window.NativeBridge.appAlert(JSON.stringify({"text": "appAlert"}));
}

function getAppInfo() {
    window.NativeBridge.getAppInfo().then(result => {
        alert(result);
    });
}


function jsAlert(params) {
    console.log(typeof params)
    alert(params);
}

function getJsInfo() {
    return JSON.stringify({
        "info": "JsInfo",
    })
}