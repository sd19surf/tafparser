<!DOCtype html>
<head>
<title>TAF Parsing Cf</title>
<cfset TAF = CreateObject('component','taf')>
<cfset tafInput = "BECMG 3105/3106 30009KT 0800 HZ BKN017CB BKN030 QNH2946INS">
</head>
<cfoutput>#tafInput#</cfoutput>
<cfset vis = TAF.getVis(tafInput,true)>
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