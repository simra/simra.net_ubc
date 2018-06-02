function initShowHide() {
	if (document.getElementById && document.getElementsByTagName && document.createTextNode) {
		hide();
		var toggle = document.getElementById('toggle');
		var as = toggle.getElementsByTagName('a');
		for (var i = 0; i < as.length; i++) {
			as[i].onclick = function() {
				show(this);
				return false;
			}
		}
		show(as[0]);			
	}
}

function show(s) {
	hide();
	var id = s.href.match(/#(\w.+)/)[1];
	var elem = document.getElementById(id);
	if (elem) {
	  elem.style.display = "block";
	}
}

function hide() {
	var toggleable1 = document.getElementById('toggleable');
	var toggleable=toggleable1.getElementsByTagName('div');
	for (var i = 0; i < toggleable.length; i++) {
		toggleable[i].style.display = 'none';
	}
}

window.onload = initShowHide;
