/*
 * (C)opyright 2009 Ricardo Martins
 * Licensed under the MIT/X11 License.
 */

/* De-obfuscates a ROT13 encrypted and html ascii entity string */
function deobfuscate(email) {
    var s = "";
    var bleh = email.replace(/&#/g, "").split(";");
    for (i = 0; i < bleh.length; i++)
        s += (String.fromCharCode(bleh[i]));
    s = s.replace(/[a-zA-Z]/g, function(c){
            return String.fromCharCode((c <= "Z" ? 90 : 122) >= (c = c.charCodeAt(0) + 13) ? c : c - 26);});
    return s;
}

/* Sets the href of the 'a' element with id = 'special' to my de-obfuscated email */
function setHref() {
    /* Use your own email pre-encoded (ROT13 + html ascii entity) */
    var str1 = "&#122;&#110;&#118;&#121;&#103;&#98;&#58;";
    var str2 = "&#122;&#114;";
    var str3 = "&#64;";
    var str4 = "&#101;&#118;&#112;&#110;&#101;&#113;&#98;&#122;&#110;&#101;&#103;&#118;&#97;&#102;&#46;&#112;&#112";
    var str = deobfuscate(str1+str2+str3+str4);
    document.getElementById('special').href = str;
}

/* Use 'onload' the right way, use events! */
/* http://onlinetools.org/articles/unobtrusivejavascript/chapter4.html */
function addEvent(obj, evType, fn){
    if (obj.addEventListener){
        obj.addEventListener(evType, fn, false);
        return true;
    } else if (obj.attachEvent){
        var r = obj.attachEvent("on"+evType, fn);
        return r;
    } else {
        return false;
    }
}
addEvent(window, 'load', setHref);
