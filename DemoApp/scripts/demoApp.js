$(document).ready(function(){
	
	$('#container').on("click", "button#signUp", function(){
		document.location.href="/demoApp/signUp.cfm";
	});
	
	//code for login button 
	$('#container').on("click", "button#user_in", function(){
			$('#message').html('');
			var username = $("#loginForm input[name='uname']").val();
			var userpassword = $("#loginForm input[name='pword'").val();
			
			var validateString = '';
			if(typeof(username)!='undefined' && typeof(userpassword)!='undefined'){
				if(!username.trim().length){
					validateString = validateString + 'Username is required\n';
				}
				if(!userpassword.trim().length){
					validateString = validateString + 'Password is required\n';
				}
			}else{
				validateString = validateString + 'Invalid Fields Entered\n';
			}
			
			if(validateString.length){
				$('#message').html(validateString);
			}else{
				$.ajax({
					cache: false,
					type: "post",
					url : 'components/users.cfc',
					data: {
						method: "checkUser",
						username: username,
						userpassword : userpassword
					},
					dataType : 'json',
					beforeSend:function(){
						$('.loader').show();
						
					},
					success : function(data) {
						if(typeof(data)!='undefined' && data.HTML.length){
							$('#container').html(data.HTML);
						}else{
							$('#message').html(data.MESSAGE);
						}
						$('.loader').hide();
					},
					error : function(error){
						$('.loader').hide();
						$('#message').html("Some Error Occured");
					}
				});
			}
		});
		
		//code for signout button 
		$('#container').on("click", "button#user_out", function(){
			
			$.ajax({
				cache: false,
				type: "post",
				url : 'components/users.cfc',
				data: {
					method: "logout_user"
				},
				dataType : 'json',
				beforeSend:function(){
					$('.loader').show();
				},
				success : function(data) {
					if(typeof(data)!='undefined' && data.HTML.length){
						$('#container').html(data.HTML);
					}else{
						$('#message').html(data.MESSAGE);						
					}
					$('.loader').hide();
				},
				error : function(error){
					$('.loader').hide();
					$('#message').html("Some Error Occured");
				}
			});
		});
	
	(function() {	
		$('input').keyup(function() {

        var empty = false;
			$('input').each(function() {
				if ($(this).val() == '') {
					empty = true;
				}
			});

			if (empty) {
				$('.formDemo').attr('disabled', 'disabled');
			} else {
				$('.formDemo').removeAttr('disabled');
			}
		});
	})();	
	
	//code for signup button 
	$('#container').on("click", "button#user_su", function(){
		var username = $("#signUpForm input[name='uname']").val();
		var userpassword = $("#signUpForm input[name='pword'").val();
		var validateString = '';
		if(typeof(username)!='undefined' && typeof(userpassword)!='undefined'){
			if(!username.trim().length){
				validateString = validateString + 'Invalid Username\n';
			}
			if(!userpassword.trim().length){
				validateString = validateString + 'Invalid Password\n';
			}
		}else{
			validateString = validateString + 'Invalid Fields Entered\n';
		}
		
		if(validateString.length){
			$('#message').html(validateString);
		}else{
			$.ajax({
				cache: false,
				type: "post",
				url : 'components/users.cfc',
				data: {
					method: "addUser",
					username:username,
					userpassword : userpassword
				},
				dataType : 'json',
				beforeSend:function(){
					$('.loader').show();
					
				},
				success : function(data) {
					if(typeof(data)!='undefined' && data.MESSAGE.length){
						$('#message').html(data.MESSAGE);
						
						if(data.SUCCESS && data.USERID){
							setTimeout(function(){ 
							document.location.href="/demoApp/";
							}, 1000);
						}		
					}
					$('.loader').hide();
				},
				error : function(error){
					$('.loader').hide();
					$('#message').html("Some Error Occured");
				}
			});
		}	
	});
		
	$('.formDemo').attr('disabled', 'disabled');	
	
	$('#container').keypress(function (e) {
	 var key = e.which;
	 if(key == 13)  // the enter key code
	  {
		$('button#user_in').click();
		return false;  
	  }
	});   
});