<cfcomponent name="TAF" hint="class of functions to return a parsed taf">

    <cfset validStartTime = 0>


    <cffunction name="getVis" access="public" output="no" returntype ="string" hint="returns vis as string">
        <cfargument name="tafLine" required="true" type="any">
        <cfparam name="vis" type="string" default="">
        <cfscript>
            // when start=1, returnSubexpressions=true, and scope="one"
            tafLine = tafLine.Split(' ');
            for (element in tafLine){
                if (REFind("^[0-9]{4}$|^[0-9]{4}V[0-9]{4}$", element,1,false,"one")){
                    vis = (REFind("^[0-9]{4}$|^[0-9]{4}V[0-9]{4}$", element,1,true,"one"));
                }
            }
        </cfscript>
        <cfreturn metersToMiles(vis.match[1])>
    </cffunction>

    <cffunction name="getClouds" access="public" output="no" returntype="array" hint="returns clouds as string">
        <cfargument name="tafLine" required="true" type="any">
        <cfset clouds = []>
        <cfscript>
            // when start=1, returnSubexpressions=true, and scope="one"
            tafLine = tafLine.Split(' ');
            for (element in tafLine){                
                if (REFind("^[A-Z]{3}[0-9]{3}$|^[V]{2}[0-9]{3}$|^SKC", trim(element),1,false,"one")){
                    cloudMatch = (REFind("^[A-Z]{3}[0-9]{3}$|^[V]{2}[0-9]{3}$|SKC", trim(element),1,true,"one"));
                    ArrayAppend(clouds,cloudMatch.match[1],"true");
                }
            }
        </cfscript>
        <cfreturn clouds>
    </cffunction>

    <cffunction name="getCeiling" access="public" output="no" returntype="string" hint="passed array of clouds returns numerical ceiling">
        <cfargument name="cloudLayers" type="array" required="true">
        <cfparam name="ceiling" type="numeric" default="999">
        <!---add ceiling and cloud logic--->
        <cfscript>
            for (cloudLayer in cloudLayers){
              if (cloudLayer != "SKC"){ // no levels when Sky is clear
               level = right(cloudLayer,3)*1;
                if (len(cloudLayer) lt 6 ){  //checks for the VV length
                    layer = left(cloudLayer,2);
                }else{
                    layer = left(cloudLayer,3);
                }

                if(layer == "BKN" || layer == "OVC" || layer == "VV"){
                    if (level < ceiling){  // if less than the greatest value found so far
                        ceiling = level;
                    }
                }
              }
            }

        </cfscript>

        <cfreturn ceiling>
    </cffunction>  
    
    <cffunction name="metersToMiles" access="private" output="no" returnType="numeric" hint="passed meters returns statue miles">
        <cfargument name="meters" type="string" required="true">
        <cfreturn val(meters) * 0.000621371>
    </cffunction>

    <cffunction name="getTime" access="public" output="no" returnType="string" hint="passed taf line return validtime of line">
        <cfargument name="tafLine" type="string" required="true">
        <cfset validTime = "">
        <cfscript>
            tafLine = tafLine.Split(' ');
            for (element in tafLine){
                if (REFind("^[0-9]{4}/[0-9]{4}$", element,1,false,"one")){
                    validTime = (REFind("^[0-9]{4}/[0-9]{4}$", element,1,true,"one"));
                }
            }

        </cfscript>
        <cfreturn validTime.match[1]>
    </cffunction>

    <cffunction name="startTime" access="public" output="no" returnType="any" hint="passed taf line returns how many hours from taf validtime of the line">
        <cfargument name="tafLine" type="string" required="true">
        <cfset startIndex = 0>
        <cfscript>
            //add logic to determine how many hours past taf start this line is valid

        </cfscript>

        <cfreturn startIndex>
    </cffunction>


</cfcomponent> 