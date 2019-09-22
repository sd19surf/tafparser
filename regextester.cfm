<!--- Kill extra output. --->
<cfsilent>

	<!--- Set page settings. --->
	<cfsetting
		showdebugoutput="false"
		/>


	<!--- Param form variables. --->
	<cfparam
		name="FORM.target_text"
		type="string"
		default="You have some sexy legs."
		/>

	<cfparam
		name="FORM.regex"
		type="string"
		default="(sexy)(?= legs)"
		/>

	<cfparam
		name="FORM.regex_replace"
		type="string"
		default="very $1"
		/>


	<!--- Set default result values. --->
	<cfset REQUEST.CFResult = "" />
	<cfset REQUEST.JavaResult = "" />
	<cfset REQUEST.CFRegex = "" />
	<cfset REQUEST.CFRegexReplace = "" />
	<cfset REQUEST.JavaRegex = "" />
	<cfset REQUEST.JavaRegexReplace = "" />


	<!--- Try to run the ColdFusion regex replace. --->
	<cftry>
		<!--- Try to clean the for CF. --->
		<cfset REQUEST.CFRegex = ToString( FORM.regex ).ReplaceAll( "(?<!\\)\$([\d]+)", "\\$1" ) />
		<cfset REQUEST.CFRegexReplace = ToString( FORM.regex_replace ).ReplaceAll( "(?<!\\)\$([\d]+)", "\\$1" ) />

		<!--- Run the replace. --->
		<cfset REQUEST.CFResult = REReplace( FORM.target_text, REQUEST.CFRegex, REQUEST.CFRegexReplace, "ALL" ) />

		<!--- Catch any errors. --->
		<cfcatch>
			<cfset REQUEST.CFResult = CFCATCH.Message />
		</cfcatch>
	</cftry>


	<!--- Try to run the Java regex replace. --->
	<cftry>
		<!--- Try to clean the for Java. --->
		<cfset REQUEST.JavaRegex = ToString( FORM.regex ).ReplaceAll( "(?<!\\)\$([\d]+)", "\\$1" ) />
		<cfset REQUEST.JavaRegexReplace = ToString( FORM.regex_replace ).ReplaceAll( "(?<!\\)\\([\d]+)", "\$$1" ) />

		<!--- Run the replace. --->
		<cfset REQUEST.JavaResult = ToString( FORM.target_text ).ReplaceAll( REQUEST.JavaRegex, REQUEST.JavaRegexReplace ) />

		<!--- Catch any errors. --->
		<cfcatch>
			<cfset REQUEST.JavaResult = CFCATCH.Message />
		</cfcatch>
	</cftry>

</cfsilent>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Regular Expression Testing @ Kinky Solutions by Ben Nadel</title>

	<!-- Styles. -->
	<style type="text/css">
		body { background-image: url( "http://www.bennadel.com/images/global/background_logo.jpg" ) ; background-position: top right ; background-repeat: no-repeat ; margin: 20px 20px 20px 20px ; }
		body, td { font: 11px verdana ; }
		h2 { color: #FA3E0A ; font: 25px verdana ; margin: 0px 90px 15px 0px ; }
		h3 { color: #FA3E0A ; font: 16px verdana ; margin: 0px 0px 15px 0px ; }
		h4 { color: #333333 ; font: bold 13px verdana ; margin: 0px 0px 5px 0px ; }
		p, ul, ol, table { line-height: 18px ; margin: 0px 90px 12px 0px ; }
		a, a.red { color: #FA3E0A ; }
		form { margin: 0px 0px 0px 0px ; }
		input, select, textarea { font: 11px verdana ; vertical-align: middle ; }
		input, textarea { padding: 2px 2px 2px 2px ; }
		input.button { line-height: 11px ; }
		div.code, div.codefixed { border: 1px solid #999999 ; margin-bottom: 18px ; padding: 2px 2px 2px 2px ; overflow: auto ; width: 95% ; }
		div.codefixed { height: 200px ; }
		div.code ul, div.codefixed ul { font-family: monospace, verdana ; font-size: 11px ; list-style-type: none ; margin: 0px 0px 0px 0px ; padding-left: 0px ; }
		div.codefixed ul { width: 1200px ; }
		div.code ul li, div.codefixed ul li { background-color: #F5F5F5 ; margin-bottom: 1px ; padding: 1px 3px 1px 3px ; }
		div.code ul li.tab1, div.codefixed ul li.tab1 { padding-left: 30px ; }
		div.code ul li.tab2, div.codefixed ul li.tab2 { padding-left: 60px ; }
		div.code ul li.tab3, div.codefixed ul li.tab3 { padding-left: 90px ; }
		div.code ul li.tab4, div.codefixed ul li.tab4 { padding-left: 120px ; }
		div.code ul li.tab5, div.codefixed ul li.tab5 { padding-left: 150px ; }
		div.code ul li.tab6, div.codefixed ul li.tab6 { padding-left: 180px ; }
		div.code ul li.tab7, div.codefixed ul li.tab7 { padding-left: 210px ; }
		div.code ul li.tab8, div.codefixed ul li.tab8 { padding-left: 240px ; }
		div.code ul li.tab9, div.codefixed ul li.tab9 { padding-left: 270px ; }
		#pagefooter { color: #666666 ; font-size: 10px ; font-style: italic ; margin: 30px 0px 0px 0px ; }
		#pagefooter a { color: #666666 ; text-decoration: none ; }
		#pagefooter a:hover { color: #FA3E0A ; text-decoration: underline ; }


		form {
			padding-top: 20px ;
			}

		textarea.input {
			height: 100px ;
			width: 300px ;
			}

		textarea.output {
			height: 70px ;
			width: 300px ;
			}

		button.process {
			font-size: 16px ;
			margin: 0px 15px 0px 15px ;
			padding-bottom: 10px ;
			padding-top: 10px ;
			width: 120px ;
			}

		p.output {
			margin-bottom: 0px ;
			}

		p.translated {
			margin-bottom: 17px ;
			}

		span.translatedfrom {
			background-color: #ffCC66 ;
			}

		span.translatedto {
			background-color: #FCCCCC ;
			}

		td p {
			margin-right: 0px ;
			}

	</style>
</head>
<body>

	<cfoutput>

		<h2>
			Regular Expression Testing
		</h2>

		<p>
			Enter your target text and regular expression for a text REPLACE.
			See how this works in ColdFusion, Java, and Javascript. The regular
			expression will automatically be translated to use "\" or "$"
			depending on the language.
		</p>

		<form action="#CGI.script_name#" method="post">

			<table cellspacing="0" cellpadding="0" border="0">
			<tr valign="top">
				<td>

					<h4>
						Target Text:
					</h4>

					<p>
						<textarea name="target_text" class="input">#FORM.target_text#</textarea>
					</p>

					<h4>
						Regular Expression:
					</h4>

					<p>
						<textarea name="regex" class="input">#FORM.regex#</textarea>
					</p>

					<h4>
						Regular Expression Replace:
					</h4>

					<textarea name="regex_replace" class="input">#FORM.regex_replace#</textarea>

				</td>
				<td valign="middle">

					<button class="process">
						Process<br />
						Regular<br />
						Expression
					</button>

				</td>
				<td>

					<h4>
						ColdFusion Result - REReplace():
					</h4>

					<p class="output">
						<textarea name="cf_result" class="output">#REQUEST.CFResult#</textarea>
					</p>

					<p class="translated">
						Translated for CF: <br />
						<span class="translatedfrom"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.CFRegex )#</span>
						&nbsp;&raquo;&nbsp;
						<span class="translatedto"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.CFRegexReplace )#</span>
					</p>

					<h4>
						Java Result - ToString().ReplaceAll():
					</h4>

					<p class="output">
						<textarea name="java_result" class="output">#REQUEST.JavaResult#</textarea>
					</p>

					<p class="translated">
						Translated for Java:<br />
						<span class="translatedfrom"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.JavaRegex )#</span>
						&nbsp;&raquo;&nbsp;
						<span class="translatedto"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.JavaRegexReplace )#</span>
					</p>

					<h4>
						JavaScript Result - replace():
					</h4>

					<p class="output">
						<textarea name="javascript_result" class="output"></textarea>
					</p>

					<p class="translated">
						Translated for JavaScript: <br />
						<span class="translatedfrom"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.JavaRegex )#</span>
						&nbsp;&raquo;&nbsp;
						<span class="translatedto"
							onclick="prompt( 'RegEx:', this.innerHTML );"
							>#HtmlEditFormat( REQUEST.JavaRegexReplace )#</span>
					</p>


					<script type="text/javascript">

						var objForm = document.forms[ 0 ];
						var objJSResult = objForm.elements[ "javascript_result" ];

						try {

							objJSResult.value = objForm.elements[ "target_text" ].value.replace(
								new RegExp(
									"#JSStringFormat( REQUEST.JavaRegex )#",
									"g"
									),
								"#JSStringFormat( REQUEST.JavaRegexReplace )#"
								);

						} catch( objError ){

							objJSResult.value = objError.message;

						}

					</script>

				</td>
			</tr>
			</table>

		</form>


		<p id="pagefooter">
			Copyright Ben Nadel @ <a href="http://www.bennadel.com" target="_blank">Kinky Solutions</a><br />
			Updated on March 20, 2007
		</p>

	</cfoutput>

</body>
</html>