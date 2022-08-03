"use strict";

/* global L, HTMLWidgets */

window.HTMLWidgets = window.HTMLWidgets || {};

// Taken from https://github.com/ramnathv/htmlwidgets/blob/master/inst/www/htmlwidgets.js
window.HTMLWidgets.dataframeToD3 = function (df) {
    var names = [];
    var length;
    for (var name in df) {
        if (df.hasOwnProperty(name)) {
            names.push(name);
        }
        if (typeof(df[name]) !== "object" || typeof(df[name].length) === "undefined") {
            throw new Error("All fields must be arrays");
        } else if (typeof(length) !== "undefined" && length !== df[name].length) {
            throw new Error("All fields must be arrays of the same length");
        }
        length = df[name].length;
    }
    var results = [];
    var item;
    for (var row = 0; row < length; row++) {
        item = {};
        for (var col = 0; col < names.length; col++) {
            item[names[col]] = df[names[col]][row];
        }
        results.push(item);
    }
    return results;
};

var maxwell = {};

maxwell.findLeafletWidgets = function () {
    var widgets = [...document.querySelectorAll(".html-widget.leaflet")];
    console.log("Found " + widgets.length + " widgets");
    return widgets.map(function (widget) {
        var id = widget.id;
        var dataNode = document.querySelector("[data-for=\"" + id + "\"");
        console.log("Got data node ", dataNode);
        var data = JSON.parse(dataNode.innerHTML);
        console.log("Got data ", data);
        var section = widget.closest(".section.level2");
        var heading = section.querySelector("h2");
        return {
            node: widget,
            data: data,
            section: section,
            heading: heading
        };
    });
};

maxwell.leafletiseCoords = function (coords) {
    return coords.map(poly => poly.map(HTMLWidgets.dataframeToD3));
};

// Undo bizarre "multiplexing" which is achieved by the HTMLWidgets "dataFrame" system
maxwell.resolveVectorOptions = function (options, index) {
    var entries = Object.entries(options).map(([key, val]) =>
        [key, Array.isArray(val) ? val[index] : val]
    );
    return Object.fromEntries(entries);
};

maxwell.leafletPolyMethods = {
    addPolygons: "polygon",
    addPolylines: "polyline"
};

maxwell.widgetToPane = function (map, calls, index) {
    var paneName = "maxwell-pane-" + index;
    var pane = map.createPane(paneName);
    pane.classList.add("mxcw-mapPane");
    var paneOptions = {
        pane: paneName
    };
    var group = L.layerGroup(paneOptions).addTo(map);
    calls.forEach(function (call) {
        var shapes = call.args[0],
            options = Object.assign({}, call.args[3], paneOptions);
        // See https://github.com/rstudio/leaflet/blob/main/javascript/src/methods.js#L550
        var leafletMethod = maxwell.leafletPolyMethods[call.method];
        if (leafletMethod) {
            shapes.forEach((shape, index) =>
                L[leafletMethod](maxwell.leafletiseCoords(shape),
                    maxwell.resolveVectorOptions(options, index)).addTo(group));
        }
    });
    return pane;
};

// Search through an HTMLWidgets "calls" structure for a method with particular name
maxwell.findCall = function (calls, method) {
    return calls.find(call => call.method === method);
};

maxwell.addDocumentListeners = function (instance) {
    var widgets = instance.widgets;
    widgets.forEach(function (widget, i) {
        widget.heading.addEventListener("click", () => instance.updateActiveGroup(i));
    });
    var content = document.querySelector(".mxcw-content");
    content.addEventListener("scroll", function () {
        var scrollTop = content.scrollTop;
        var offsets = widgets.map(widget => widget.section.offsetTop);
        console.log("Got offsets ", instance.offsets, " with scrollTop " + scrollTop);
        var index = offsets.findIndex(offset => offset > (scrollTop - 200));
        if (index === -1) {
            index = widgets.length - 1;
        }
        console.log("Chosen index ", index);
        instance.updateActiveGroup(index);
    });
};

maxwell.registerListeners = function (instance) {
    instance.addEventListener("updateActiveGroup", function (event) {
        instance.activeGroup = event.detail.activeGroup;
    });
    instance.addEventListener("updateActiveGroup", function (event) {
        instance.panes.forEach(function (pane, i) {
            if (i === event.detail.activeGroup) {
                pane.classList.add("mxcw-activeMapPane");
            } else {
                pane.classList.remove("mxcw-activeMapPane");
            }
        });
        instance.widgets.forEach(function (widget, i) {
            if (i === event.detail.activeGroup) {
                widget.section.classList.add("mxcw-activeSection");
            } else {
                widget.section.classList.remove("mxcw-activeSection");
            }
        });
    });
};

// Pattern explained at https://medium.com/@zandaqo/eventtarget-the-future-of-javascript-event-systems-205ae32f5e6b
class maxwell_Leaflet extends EventTarget {
    constructor(options) {
        super();
        Object.assign(this, options);
        maxwell.registerListeners(this);
    }
    updateActiveGroup(activeGroup) {
        if (activeGroup !== this.activeGroup) {
            this.dispatchEvent(new CustomEvent("updateActiveGroup", {
                detail: { activeGroup: activeGroup }
            }));
        }
    }
}

maxwell.instantiateLeaflet = function (selector) {
    var widgets = maxwell.findLeafletWidgets();
    var node = document.querySelector(selector);
    var map = L.map(node);

    var data0 = widgets[0].data.x;
    var bounds = data0.fitBounds;
    map.fitBounds([[bounds[0], bounds[1]], [bounds[2], bounds[3]]]);

    var tiles = maxwell.findCall(data0.calls, "addTiles");
    L.tileLayer(tiles.args[0], tiles.args[3]).addTo(map);

    var panes = widgets.map((widget, i) => maxwell.widgetToPane(map, widget.data.x.calls, i));
    var instance = new maxwell_Leaflet({
        container: node,
        map: map,
        widgets: widgets,
        panes: panes,
        activeGroup: null
    });
    maxwell.leafletInstance = instance;
    instance.updateActiveGroup(0);

    maxwell.addDocumentListeners(instance);

    return instance;
};
