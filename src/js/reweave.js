/* eslint-env node */

"use strict";

const fs = require("fs-extra"),
    linkedom = require("linkedom");

require("../../index.js");

const modules = {
    maxwell: global.__basedir
};

const stringTemplate = function (template, values) {
    let newString = template;
    for (const key in values) {
        const searchStr = "%" + key;
        newString = newString.replace(searchStr, values[key]);
    }
    return newString;
};

const resolvePath = function (path) {
    return stringTemplate(path, modules);
};

const parseDocument = function (path) {
    const text = fs.readFileSync(path, "utf8");
    return linkedom.parseHTML(text).document;
};

const writeFile = function (filename, data) {
    fs.writeFileSync(filename, data, "utf8");
    const stats = fs.statSync(filename);
    console.log("Written " + stats.size + " bytes to " + filename);
};

const hideLeafletWidgets = function (container) {
    // Hide the divs which host the original leaflet maps
    const widgets = container.querySelectorAll(".html-widget.leaflet");
    widgets.forEach(function (widget) {
        widget.removeAttribute("style");
    });
};

const removeImageMaps = function (container) {
    // Remove old image maps which haven't yet been converted - these stick out
    const images = container.querySelectorAll("img");
    images.forEach(image => image.remove());
};

const reweaveFile = function (infile, outfile, options) {
    const document = parseDocument(infile);
    const container = document.querySelector(".main-container");
    hideLeafletWidgets(container);
    removeImageMaps(container);
    container.querySelector("h1").remove();
    const template = parseDocument(options.template);
    const target = template.querySelector(".mxcw-content");
    target.appendChild(container);
    const outMarkup = "<!DOCTYPE html>" + template.documentElement.outerHTML;
    writeFile(outfile, outMarkup);
};

const infile = resolvePath("%maxwell/docs/R-Markdown-Background.html");
const outfile = resolvePath("%maxwell/docs/R-Markdown-Background-Rewoven.html");
const template = resolvePath("%maxwell/src/html/template.html");

reweaveFile(infile, outfile, {
    template: template
});

/** Copy dependencies into docs directory for GitHub pages **/

const copyDep = function (source, target) {
    fs.copySync(resolvePath(source), resolvePath(target));
};

const deps = [{
    source: "%maxwell/src/js/client/reweave-client.js",
    target: "%maxwell/docs/js/reweave-client.js"
}, {
    source: "%maxwell/src/css/maxwell.css",
    target: "%maxwell/docs/css/maxwell.css"
}];

deps.forEach(function (dep) {
    copyDep(dep.source, dep.target);
});
