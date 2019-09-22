<!DOCtype html>
<head>
<title>TAF Parsing Cf</title>
<cfset TAF = CreateObject('component','taf')>
<cfset tafInput = "BECMG 3105/3106 30009KT 0800 HZ SKC SCT180 SCT190 BKN250 OVC300 QNH2946INS">
</head>
<cfoutput>#tafInput#</cfoutput>
<cfset vis = TAF.getVis(tafInput)>
<cfset clouds = TAF.getClouds(tafInput)>
<cfset ceiling = TAF.getCeiling(clouds)>
<cfset validTime = TAF.getTime(tafInput)>
<p>Vis: <cfdump var="#vis#"></p>
<p>Clouds: <cfdump var="#clouds#"></p>
<p>Lowest Ceiling: <cfdump var="#ceiling#"></p>
<p> ValidTime: <cfdump var="#validTime#"></p>
<body>

</body>



</html>