( function() {
	"use strict";
	$( document ).ready( () => {
		const Twine = function() {
			let userName = '';
			let userDob = '';
			let userImg = '';
			let userGender = '';
			let userPref = '';
			let userID = '872';
			let twinerID = '';
			let twinerName = '';
			let twinerGender = '';
			let twinerImage = '';
			let url = '';

			function bindEvents() {

				$( '.user-form' ).on( 'submit', function() {
					event.preventDefault();
					event.stopImmediatePropagation();
					userName = $( '.user-name' ).val();
					userDob = $( '.user-dob' ).val();
					userImg = $( '.user-photo' ).val();
					userGender = $( '.user-gender' ).val();
					userPref = $( '.user-pref' ).val();
					$( '.front' ).hide();
					$( '.profiles' ).fadeIn( 'slow' );
					submitUser( userName, userDob, userImg, userGender );
					getTwine( userPref = 'female' );
				} ); //end user-form

				$( '.snag' ).unbind( 'click' ).bind( 'click', function() {
					event.preventDefault();
					console.log( 'snag twine id', twinerID );
					onSnag( twinerID, twinerName, twinerGender, twinerImage );
				} ); //end snag button

				$( '.knot' ).unbind( 'click' ).bind( 'click', function() {
					event.preventDefault();
					console.log( 'knot twine id', twinerID );
					$( '.profile-section' ).html( '' );
					getTwine( userPref = 'all' );
				} ); //end snag button

				$( '.show-all-snags-button' ).unbind( 'click' ).bind( 'click', function() {
					event.preventDefault();
					console.log( 'click' );
					$( '.front' ).hide();
					$( '.profile-section' ).hide();
					$( '.likes-section' ).hide();
					$( '.show-all-snags-button' ).hide();
					$( '.rate-again' ).show();
					$( '.all-my-snags' ).show();
					getUserSnags();
				} ); //end show-all-snags-button

				$( '.rate-again' ).unbind( 'click' ).bind( 'click', function() {
					event.preventDefault();
					$( '.profile-section' ).show();
					$( '.likes-section' ).show();
					$( '.show-all-snags-button' ).show();
					$( '.rate-again' ).hide();
					$( '.all-my-snags' ).hide();
					$( '.mini-profile' ).remove();
				} ); //end snag button

			} //end bindEvents

			//     function makeBase64(image) {
			//       let reader = new FileReader();
			//       reader.readAsDataURL(image);
			//     }//end makeBase64

			function submitUser( name, dob, image, gender ) {
				console.log( 'submit user' );
				dob = moment( dob ).format( 'M/DD/YY' );
				// image = makeBase64(image);
				console.log( 'name: ', name );
				console.log( 'mdob: ', dob );
				console.log( 'img64: ', image );
				console.log( 'gender: ', gender );
				const url = `https://twine-dating-site.herokuapp.com/api/users?name=${name}&dob=${dob}&image=${image}&gender=${gender}`;
				event.preventDefault();
				event.stopImmediatePropagation();
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
				} ).then( () => {
					console.log( 'sent!' );
					getTwine( userPref );
					//     getUserID();
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

			function getTwine( userPref ) {
				if ( userPref === 'all' ) {
					url = `https://twine-dating-site.herokuapp.com/api/users?&results=1`;
				} else {
					url = `https://twine-dating-site.herokuapp.com/api/users?gender=${userPref}&results=1`;
				}
				$.get( url )
					.then( ( twine10 ) => {
						twine10 = JSON.parse( twine10 );
						//  twine10[0] = JSON.parse(twine10);
						//buildProfile(twine10);
						let twiner = twine10[ 0 ];
						console.log( twiner );
						buildProfile( twiner );
					} )
					.catch( function( status ) {
						console.log( 'damnit', status );
					} );
			} //end getTwine

			function buildProfile( twiner ) {
				$( '.profile-section' ).html( '' );
				twinerID = twiner.id;
				twinerName = twiner.name;
				twinerGender = twiner.gender;
				twinerImage = twiner.image;
				const source = $( '#profile-template' ).html();
				const template = Handlebars.compile( source );
				const context = {
					name: twiner.name,
					id: twiner.id,
					gender: twiner.gender,
					dob: twiner.dob,
					image: twiner.image
				};
				const html = template( context );
				$( '.profile-section' ).hide().prepend( html ).fadeIn( 'slow' );
				$( '.show-all-snags' ).show();
				bindEvents();
			} //end buildProfile

			function onSnag( twinerID, name, gender, image ) {
				submitSnag( userID, twinerID );
				const source = $( '#snag-template' ).html();
				const template = Handlebars.compile( source );
				const context = {
					name: name,
					gender: gender,
					image: image
				};
				const html = template( context );
				$( '.five-latest' ).prepend( html );
				toggleThumb();

				$( '.profile-section' ).html( '' );
				if ( $( '.mini-profile' ).length > 5 ) {
					$( '.mini-profile' ).last().remove();
					getTwine( 'all' );
				} else {
					getTwine( 'all' );
				}
			} //onSnag

			function submitSnag( userID, twinerID ) {
				console.log( 'uid ', userID, 'tid ', twinerID );
				const url = `https://twine-dating-site.herokuapp.com/api/users/${userID}/likes/${twinerID}`;
				$.ajax( {
					type: 'POST',
					url: url,
					dataType: 'json',
					crossDomain: 'true',
					data: {
						id: userID,
						crush_id: twinerID
					}
				} ).then( () => {
					console.log( 'sent!' );
				} ).catch( function( status ) {
					console.log( 'damnit !', status );
				} );
			} //end submitSnag

			function getUserSnags() {
				event.preventDefault();
				event.stopImmediatePropagation();
				url = `https://twine-dating-site.herokuapp.com/api/users/${userID}/crushes`;
				$.get( url )
					.then( ( mySnags ) => {
						mySnags = JSON.parse( mySnags );
						displayAllSnags( mySnags );
					} ).catch( function( status ) {
						console.log( 'damnit! ', status );
					} );
			} //end getUserSnags

			function displayAllSnags( allSnags ) {
				console.log( 'were in the function ', allSnags );
				$.each( allSnags, function() {
					const source = $( '#snag-template' ).html();
					const template = Handlebars.compile( source );
					const context = {
						name: this.name,
						gender: this.gender,
						image: this.image
					};
					const html = template( context );
					$( '.all-snags-container' ).prepend( html );

				} ); //end each
				toggleThumb();
			} //end displayAllSnags

			function toggleThumb() {
				$( '.mini-profile' ).hover(
					function() {
						$( this ).find( '.icon' ).toggleClass( 'is-hidden' );
					},
					function() {
						$( this ).find( '.icon' ).toggleClass( 'is-hidden' );
					} );
			}

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
