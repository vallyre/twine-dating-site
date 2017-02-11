 ( function() {
 	"use strict";

 	$( document ).ready( () => {
 		const Twine = function() {

 			let userName = '';
 			let userDob = '';
 			let userImg = '';
 			let userGender = '';
 			let userPref = '';
 			let userID = '';
      let url = '';

 			function bindEvents() {
 				console.clear();

 				$( '.user-form' ).on( 'submit', function() {
 					event.preventDefault();
 					userName = $( '.user-name' ).val();
 					userDob = $( '.user-dob' ).val();
 					userImg = $( '.user-photo' ).val();
 					userGender = $( '.user-gender' ).val();
 					userPref = $( '.user-pref' ).val();


          $('.front').hide();
          $('.profiles').fadeIn('100000');
          // console.log( 'in' );
          get10Twine( 'all' );//will be userPref

 				// 	submitUser( userName, userDob, userImg, userGender );
 				} );//end user-form

 			} //end bindEvents

 		// 	function makeBase64(image) {
 		// 	  let reader = new FileReader();
 		// 	  reader.readAsDataURL(image);
 		// 	}//end makeBase64

 			function submitUser( name, dob, image, gender ) {
 				console.log( 'submit user' );

 				dob = moment( dob ).format( 'M/DD/YY' );
 				// image = makeBase64(image);

 				console.log( 'name: ', name );
 				console.log( 'mdob: ', dob );
 				console.log( 'img64: ', image );
 				console.log( 'gender: ', gender );

 				const url = `https://twine-dating-site.herokuapp.com/api/users?name=${name}&dob=${dob}&image=${image}&gender=${gender}`;

 				$.ajax( {
 					type: 'POST',
 					url: url,
 					dataType: 'json',
 					crossDomain: 'true',
 					data: {
 						name: name,
 						dob: dob,
 						gender: gender,
 						image: image
 					}
 				} ).then(() => {
 					console.log( 'sent!' );
          // get10Twine( userPref );
 				// 	getUserID();
 				} ).catch( function( status ) {
 					console.log( status );
 				} );

 			} //end submitUser


 			function getUserID( name ) {

 				// const url = `https://twine-dating-site.herokuapp.com/api/users?name=${name}`;
 				$.ajax( getSettings )
        // const url = `https://twine-dating-site.herokuapp.com/api/users?name=${name}&dob=${dob}&image=${image}&gender=${gender}`;
 					.then( function( response ) {
 						userID =
 							getUserSnags();
 					} );
 			} //end getUserID


 			function get10Twine( userPref ) {

        if (userPref === 'all') {
          url = `https://twine-dating-site.herokuapp.com/api/users?&results=10`;
        } else {
          url = `https://twine-dating-site.herokuapp.com/api/users?gender=${userPref}&results=10`;
        }

 				$.get(url)
        .then((twine10) => {
          console.log('twine10', JSON.parse(twine10));
        })
        .catch( function( status ) {
        			console.log( 'damnit', status );
 				});
 			} //end get10Twine



      function buildProfile() {
        const source = $('#profile=template').html();
        const template = Handlebars.compile(source);
        const context = {
          name: name,

        };
        const html = template(context);
        $('.profile-container').prepend(html);
      }//end buildProfile


 			function getUserSnags( id ) {

 			} //end getUserSnags


 			function init() {
 				bindEvents();

 			} // end init

 			return {
 				init: init
 			};

 		}; //end APP

 		const twine = Twine();
 		twine.init();

 	} ); //end docready


 } )(); //end iife
