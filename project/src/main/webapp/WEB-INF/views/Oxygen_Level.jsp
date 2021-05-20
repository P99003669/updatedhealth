<!DOCTYPE HTML>
<html>
<head>
	<style>
		body{
			background-color:rgb(98, 245, 245);
		}
	</style>
<script>
window.onload = function() {

var dataPoints = [];

var options = {
	theme: "light2",
	title: {
		text: "Oxygen Level"
	},
	data: [{
		type: "line",
		dataPoints: dataPoints
	}]
};
$("#chartContainer").CanvasJSChart(options);
updateData("10:30:35 AM");


var xValue = 0;
var yValue = 10;
var newDataCount = 6;

function addData(data) {
	if(newDataCount != 1) {
		$.each(data, function(key, value) {
			dataPoints.push({x: value[0], y: parseInt(value[1])});
			xValue++;
			yValue = parseInt(value[1]);
		});
	}  else {
		
		dataPoints.push({x: data[0][0], y: parseInt(data[0][1])});
		xValue++;
		yValue = parseInt(data[0][1]);
	}
  
	newDataCount = 1;
  
	$("#chartContainer").CanvasJSChart().render()
	setTimeout(updateData, 5000);	
}

function updateData(data) {
	
	$.getJSON("https://canvasjs.com/services/data/datapoints.php?xstart="+xValue+"&ystart="+yValue+"&length="+newDataCount+"&type=json", addData);
}

}
</script>
</head>
<body>
	<header>
		<nav>
			<a href="home">Home</a>
		</nav>
	</header>
	<script>
		var source = new EventSource('/time');
		source.onmessage = function(e) {
		  document.getElementById("timeStamp").innerHTML += e.data + '<br>';
			updateData(e.data);
		};
	  </script>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<div id="timeStamp"></div>
</body>