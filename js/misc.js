function deobfuscate(email) {
    var s = "";
    var bleh = email.replace(/&#/g, "").split(";");
    for (i = 0; i < bleh.length; i++)
    s += (String.fromCharCode(bleh[i]));
    s = s.replace(/[a-zA-Z]/g,
    function(c) {
        return String.fromCharCode((c <= "Z" ? 90: 122) >= (c = c.charCodeAt(0) + 13) ? c: c - 26);
    });
    return s;
}

$(document).ready(function() {
    // google-code-prettify
    prettyPrint();

    $('a#about-toggle').click(function() {
        $('#about').slideToggle(400);
        return false;
    });

    $("a.lightbox").fancybox();

    var s1 = "&#122;&#110;&#118;&#121;&#103;&#98;&#58;";
    var s2 = "&#101;&#118;&#112;&#110;&#101;&#113;&#98;";
    var s3 = "&#64;";
    var s4 = "&#102;&#112;&#110;&#101;&#108;&#111;&#98;&#107;&#46;&#97;&#114;&#103";
    var s = deobfuscate(s1 + s2 + s3 + s4);
    $("a#email").text(deobfuscate(s2 + s3 + s4)).attr("href", s);
});