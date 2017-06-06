<!DOCTYPE html>
<html>
<link rel="stylesheet" media="all" type="text/css" href="styles/demoApp.css"/>
<body>
<div id="container">
	
	<cfif isDefined('SESSION.userID') AND SESSION.userID>
		You are IN.
		<div>
			<button id="user_out" type="button">Signout</button>
		</div>
	<cfelse>
		<center>
			<div id="message"></div>
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
	</cfif>
</div>	
<div class="loader" style="display:none"></div>
</body><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="scripts/demoApp.js"></script>
</html>
