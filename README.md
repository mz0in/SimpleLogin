SimpleLogin
===========

IOS APP(submit user&device info to a web api, facebook login)

Application Flow:
		
		As a user, I will see an input field for my username in which I can input text.
		There will be a text field below the user name input field for results from server or program.
		A user can not input text into this field. 
		There will be a Submit Button at the bottom of the application. Clicking this button will call
		the backend to record information.

The Backend will be written in the Rails framework using mysql lite3 to persist the data.
  	
  	The Backend:
  		Will record the user id.
  		Will record a unique device identifier (a key)
  		Will record the device type.
  		Will not allow duplicate user ids.
  		Will return one of the following messages:
  		Success (record creation is successful)
  		Duplicate Record (record already exists)
  		Error
  		The result from the Backend will show up on UI results textfield.
  		A successful result will cause the submit button to deactivate.
  		A Duplicate record will cause the selection of the input field.

Facebook Login with SDK

		The user will now see an additional Connect with Facebook Button
		When the user clicks on the Connect button, you will call the FB Mobile SDK to login the user.
		The Flow will be slightly different depending on how the SDK handles the call. Show the result in the 
		result text field area.
		Show the facebook user name in the input field, and the image of the facebook user profile in an new image 
		box somewhere in the application.
