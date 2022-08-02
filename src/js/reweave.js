/* eslint-env node */

"use strict";

var fs = require("fs-extra"),
    linkedom = require("linkedom");

require("../../index.js");

var modules = {
    maxwell: global.__basedir
};

var stringTemplate = function (template, values) {
    var newString = template;
    for (var key in values) {
        var searchStr = "%" + key;
        newString = newString.replace(searchStr, values[key]);
    }
    return newString;
};

var resolvePath = function (path) {
    return stringTemplate(path, modules);
};

var parseDocument = function (path) {
    var text = fs.readFileSync(path, "utf8");
    return linkedom.parseHTML(text).document;
};

var writeFile = function (filename, data) {
    fs.writeFileSync(filename, data, "utf8");
    var stats = fs.statSync(filename);
    console.log("Written " + stats.size + " bytes to " + filename);
};

var hideLeafletWidgets = function (container) {
    // Hide the divs which host the original leaflet maps
    var widgets = container.querySelectorAll(".html-widget.leaflet");
    widgets.forEach(function (widget) {
        widget.removeAttribute("style");
    });
};

var removeImageMaps = function (container) {
    // Remove old image maps which haven't yet been converted - these stick out
    var images = container.querySelectorAll("img");
    images.forEach(image => image.remove());
};

var reweaveFile = function (infile, outfile, options) {
    var document = parseDocument(infile);
    var container = document.querySelector(".main-container");
    hideLeafletWidgets(container);
    removeImageMaps(container);
    container.querySelector("h1").remove();
    var template = parseDocument(options.template);
    var target = template.querySelector(".mxcw-content");
    target.appendChild(container);
    var outMarkup = "<!DOCTYPE html>" + template.documentElement.outerHTML;
    writeFile(outfile, outMarkup);
};

var infile = resolvePath("%maxwell/docs/R-Markdown-Background.html");
var outfile = resolvePath("%maxwell/docs/R-Markdown-Background-Rewoven.html");
var template = resolvePath("%maxwell/src/html/template.html");

reweaveFile(infile, outfile, {
    template: template
});

/** Copy dependencies into docs directory for GitHub pages **/

var copyDep = function (source, target) {
    fs.copySync(resolvePath(source), resolvePath(target));
};

var deps = [{
    source: "%maxwell/src/js/client/reweave-client.js",
    target: "%maxwell/docs/js/reweave-client.js"
}, {
    source: "%maxwell/src/css/maxwell.css",
    target: "%maxwell/docs/css/maxwell.css"
}];

deps.forEach(function (dep) {
    copyDep(dep.source, dep.target);
});
