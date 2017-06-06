<cfcomponent displayname="users" output="yes" hint="It Handles User Accounts">
	
	<cffunction name="checkUser" access="remote" output="yes" returnFormat="json" returntype="struct">
		<cfargument name="username" type="string" required="true">
		<cfargument name="userpassword" type="string" required="true">
		
		<cfset returnStruct = StructNew()>
		<cfset returnStruct.success= 1>
		<cfset returnStruct.userID= 0>
		<cfset returnStruct.html= ''>
		<cfset returnStruct.error= 0>
		<cfset returnStruct.message= ''>
		<cftry>
			<cfif NOT Len(Trim(ARGUMENTS.username))>
				<cfset returnStruct.message= returnStruct.message & 'User Name is required\n'>
			</cfif>
			<cfif NOT Len(Trim(ARGUMENTS.userpassword))>
				<cfset returnStruct.message= returnStruct.message & 'User Password is required\n'>
			</cfif>
			<cfif NOT Len(returnStruct.message)>
				<cfquery name="checkUserDetails" datasource="#Application.datasource#">
					SELECT tbl_user_id AS userID
					FROM tbl_user
					WHERE tbl_user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#">
					AND tbl_user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(Hash(ARGUMENTS.userPassword,'MD5'),'MD5')#">
				</cfquery>
				<cfif checkUserDetails.recordCount>
					<cfset returnStruct.userID= checkUserDetails.userID>
					<cfset SESSION.userID = returnStruct.userID>
					<cfsavecontent variable="html_body">
						You are IN.
						<div>
							<button id="user_out" type="button">Signout</button>
						</div>
					</cfsavecontent>
					<cfset returnStruct.html= html_body>
				<cfelse>
					<cfset returnStruct.message= 'Invalid Credentials'>
				</cfif>
			</cfif>	
			<cfcatch>
				<cfset returnStruct.message= 'Some Error Occured'>
				<cfset returnStruct.success= 0>
				<cfset returnStruct.error= 1>
				<cfreturn returnStruct>
			</cfcatch>
		</cftry>		
		<cfreturn returnStruct>
	</cffunction>
	
	<cffunction name="logout_user" access="remote" output="yes" returnFormat="json" returntype="struct">
		<cfargument name="userID" type="numeric" default="#SESSION.userID#">
		
		<cfset returnStruct = StructNew()>
		<cfset returnStruct.success= 1>
		<cfset returnStruct.userID= 0>
		<cfset returnStruct.html= ''>
		<cfset returnStruct.error= 0>
		<cfset returnStruct.message= ''>
		<cftry>
			<cfif isDefined('SESSION.userID') AND SESSION.userID>
				<cfsavecontent variable="html_body">
					<center>
						<h2>Login Page</h2>
					</center>
					<div class="login" id="loginForm">
						<center>
							<div class="field">Username:</div> 
							
							<div class="field_value"><input type="text" placeholder="Enter Username" name="uname"></div> 
						
						</center>
						<center>
							<div class="field">Password:</div>
							<div class="field_value">
								<input type="password" placeholder="Enter Password" name="pword">
							</div>
						</center>    
						<center>
							<button class="formDemo" id="user_in" type="button">Login</button>
							<button id="signUp" type="button">SignUp</button>
						</center>
					</div>
				</cfsavecontent>
				<cfset returnStruct.html= html_body>
				<cfset StructClear(SESSION)>
				<cfset StructDelete(COOKIE, 'CFID')>
				<cfset StructDelete(COOKIE, 'CFToken')>
			<cfelse>
				<cfset returnStruct.message= 'You are already logged out'>
			</cfif>	
			<cfcatch>
				<cfset returnStruct.message= 'Some Error Occured'>
				<cfset returnStruct.success= 0>
				<cfset returnStruct.error= 1>
				<cfreturn returnStruct>
			</cfcatch>
		</cftry>
		
		<cfreturn returnStruct>
	</cffunction>
	
	<cffunction name="addUser" access="remote" returnFormat="json" returntype="struct">
		<cfargument name="username" type="string" required="true">
		<cfargument name="userpassword" type="string" required="true">
		
		<cfset returnStruct = StructNew()>
		<cfset returnStruct.success= 1>
		<cfset returnStruct.userID= 0>
		<cfset returnStruct.error= 0>
		<cfset returnStruct.message= ''>
		<cftry>
			<cfif NOT Len(ARGUMENTS.username)>
				<cfset returnStruct.message= returnStruct.message & 'User Name is required\n'>
			</cfif>
			<cfif NOT Len(ARGUMENTS.userpassword)>
				<cfset returnStruct.message= returnStruct.message & 'User Password is required\n'>
			</cfif>
			<cfif NOT Len(returnStruct.message)>
				<cfquery name="checkUserDetails" datasource="#Application.datasource#">
					SELECT tbl_user_id
					FROM tbl_user
					WHERE tbl_user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#">
				</cfquery>
			
				<cfif checkUserDetails.recordCount>
					<cfset returnStruct.success= 0>
					<cfset returnStruct.userID= checkUserDetails.tbl_user_id>
					<cfset returnStruct.message= 'User already exists'>
				<cfelse>
					<cfquery result="addUserDetails" datasource="#Application.datasource#">
						INSERT INTO tbl_user
						(
							tbl_user_name,
							tbl_user_password,
							tbl_user_create_date
						)
						VALUES
						(
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(ARGUMENTS.username)#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(Hash(ARGUMENTS.userPassword,'MD5'),'MD5')#">,							
							now()
						);
					</cfquery>
					<cfset returnStruct.userID = addUserDetails.GENERATED_KEY>
					<cfset returnStruct.message= 'Successfully added'>
				</cfif>
			</cfif>
			<cfcatch>
				<cfset returnStruct.success= 0>
				<cfset returnStruct.error= 1>
				<cfset returnStruct.message= 'Some Error Occured'>
			</cfcatch>
		</cftry>
		<cfreturn returnStruct>
	</cffunction>
</cfcomponent>