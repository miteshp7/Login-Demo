<cfcomponent displayname="demoApplication" output="false" hint="Define and Configure the Application">

  <!--- Set up the application +++++++++++++++++++++++++++++++++++++ --->
  <cfset THIS.Name							 = "Demo App #CGI.SERVER_NAME#" />
  <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 60, 0 ) />
  <cfset THIS.SessionManagement	 = true />
  <cfset THIS.SessionTimeout		 = CreateTimeSpan( 0, 0, 2, 0 ) />
  <cfset THIS.SetClientCookies	 = true />
  

  <cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
    <cfset Application.developerName = 'Mitesh' >
	<cfset Application.datasource	 = 'test_dsn' />
	
    <cfreturn true />
  </cffunction>

	
  <!--- Error Handling +++++++++++++++++++++++++++++++++++++++++++++ --->
  <cffunction name="OnError" access="public" returntype="void" output="false" hint="Fires when an exception occures that is not caught by a try/catch.">
    
	<cflocation url="error.html" addtoken="false">
    <cfreturn />
  </cffunction>
 
</cfcomponent>
