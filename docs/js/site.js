"use strict";

const instanceTemplate = `
			<tr>
				<td>[date]</td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[canopy]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[canopy]" /></a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[n]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[n]" /></a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[ne]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[ne]" /</a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[e]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[e]" /></a</td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[se]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[se]" /</a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[s]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[s]" /></a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[sw]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[sw]" /</a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[w]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[w]" /></a></td>
				<td class="gallery__item"><a class="gallery__itemLink" href="https://maxwell.mockupserver.com/images/large/[nw]" data-rel="aiLightbox"><img class="thumbnail" src="https://maxwell.mockupserver.com/images/thumbnail/[nw]" /</a></td>
			</tr>
`;

maxwell.displaySite = function (sitenumber, sitedata) {

    let griddataHTML = "";

    document.getElementById("longitude").innerHTML = sitedata.longitude;
    document.getElementById("latitude").innerHTML = sitedata.latitude;
    document.querySelector(".mxcw-sitenumber").innerHTML = sitenumber;

    document.querySelector(".mxcw-site").style.display = "block";



    // go through each instance
    for (let instancedate in sitedata.instances) {

        console.log('building row of thumbnails for ' + instancedate);

        let instanceHTML = instanceTemplate;

        const instancedata = sitedata.instances[instancedate];
        console.log("instance data: ");
        console.log(instancedata);

        instanceHTML = instanceHTML.replace("[date]", instancedate);
        if(typeof instancedata['canopy'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[canopy]", instancedata['canopy']['name']);
            instanceHTML = instanceHTML.replace("[canopy]", instancedata['canopy']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[canopy]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[canopy]", 'noimage.jpg');
        }

        if(typeof instancedata['n'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[n]", instancedata['n']['name']);
            instanceHTML = instanceHTML.replace("[n]", instancedata['n']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[n]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[n]", 'noimage.jpg');
        }

        if(typeof instancedata['s'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[s]", instancedata['s']['name']);
            instanceHTML = instanceHTML.replace("[s]", instancedata['s']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[s]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[s]", 'noimage.jpg');
        }

        if(typeof instancedata['e'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[e]", instancedata['e']['name']);
            instanceHTML = instanceHTML.replace("[e]", instancedata['e']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[e]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[e]", 'noimage.jpg');
        }

        if(typeof instancedata['w'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[w]", instancedata['w']['name']);
            instanceHTML = instanceHTML.replace("[w]", instancedata['w']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[w]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[w]", 'noimage.jpg');
        }

        if(typeof instancedata['ne'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[ne]", instancedata['ne']['name']);
            instanceHTML = instanceHTML.replace("[ne]", instancedata['ne']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[ne]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[ne]", 'noimage.jpg');
        }

        if(typeof instancedata['nw'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[nw]", instancedata['nw']['name']);
            instanceHTML = instanceHTML.replace("[nw]", instancedata['nw']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[nw]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[nw]", 'noimage.jpg');
        }

        if(typeof instancedata['se'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[se]", instancedata['se']['name']);
            instanceHTML = instanceHTML.replace("[se]", instancedata['se']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[se]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[se]", 'noimage.jpg');
        }

        if(typeof instancedata['sw'] !== 'undefined') {
            instanceHTML = instanceHTML.replace("[sw]", instancedata['sw']['name']);
            instanceHTML = instanceHTML.replace("[sw]", instancedata['sw']['name']);
        } else {
            instanceHTML = instanceHTML.replace("[sw]", 'noimage.jpg');
            instanceHTML = instanceHTML.replace("[sw]", 'noimage.jpg');
        }

        griddataHTML += instanceHTML;

    }

    document.getElementById("gridbody").innerHTML = griddataHTML;

};