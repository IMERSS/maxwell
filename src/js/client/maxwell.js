"use strict";

// noinspection ES6ConvertVarToLetConst // otherwise this is a duplicate on minifying
var maxwell = fluid.registerNamespace("maxwell");

fluid.defaults("maxwell.paneHandler.withMarkers", {
    members: {
        labelToMarker: {}
    },
    modelListeners: {
        selectedRegion: {
            namespace: "updateMarkers",
            func: "maxwell.updateMarkers",
            args: ["{change}.value", "{that}.labelToMarker"]
        }
    },
    invokers: {
        handleMarker: "maxwell.handleMarker({that}, {arguments}.0, {arguments}.1, {arguments}.2)"
    }
});

maxwell.updateMarkers = function (selectedRegion, labelToMarker) {
    fluid.each(labelToMarker, function (marker, label) {
        const full = selectedRegion === null || selectedRegion === label;
        marker.setOpacity(full ? 1.0 : 0.5);
    });
};

maxwell.handleMarker = function (paneHandler, marker, divIcon, label) {
    paneHandler.labelToMarker[label] = marker;
};

fluid.defaults("maxwell.sites.paneHandler", {
    gradeNames: ["maxwell.scrollyPaneHandler", "maxwell.paneHandler.withMarkers"],
    listeners: {
        "onCreate.loadResources": "maxwell.sites.loadResources",
        "markerClick.impl": "maxwell.sites.markerClick({that}, {arguments}.0)"
    }
});

maxwell.sites.loadResources = function (that) {
    // Would like to fetch from https://maxwell.mockupserver.com/sitedata.json but CORS headers are still wrong
    const sitedata_p = fetch("./json/sitedata.json").then((response) => response.json()).then(siteData => that.siteData = siteData);
    const site_p = fetch("./html/site.html").then(response => response.text()).then(text => that.siteMarkup = text);
    that.ready = Promise.all([sitedata_p, site_p]);
    that.ready.then(function () {
        const div = document.createElement("div");
        div.innerHTML = that.siteMarkup;
        document.querySelector(".mxcw-widgetPane-StudySites").appendChild(div);
    });
};

maxwell.sites.markerClick = function (that, data) {
    console.log("Click ", data);
    that.applier.change("selectedRegion", data);
    maxwell.displaySite(data, that.siteData[data]);
};

// Mixin grade for paneHandler
fluid.defaults("maxwell.vegPlots.siteSelection", {
    listeners: {
        "markerClick.impl": "maxwell.vegPlots.markerClick({that}, {arguments}.0)"
    },

});

maxwell.vegPlots.markerClick = function (paneHandler, label) {
    paneHandler.triggerRegionSelection(label);
};
