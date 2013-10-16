


var FacebookAuth = {
  REQUIRED_PERMISSIONS: [],
  // server-side user authentication
  _onAuthenticated: function(trigger, response, callback, session){
    callback ? callback(response, session) : FacebookAuth._triggerDefaultBehaviour(trigger);
  },
  _triggerDefaultBehaviour: function(trigger){
    if(trigger.is('a')){
      document.location = trigger.data('href') ? trigger.data('href') : trigger.attr('href');
    }
    if(trigger.is('form')){
      trigger.off('submit').submit();
    }
  },
  _authenticate: function(session, callback, trigger, onPermsDeclined){
    var grantedPermissionsCallback = function(){
      // fetch additionnal data
      FB.api('/', 'post', { batch: JSON.stringify([
          { method: 'get', relative_url: '/me' },
          { method: 'get', relative_url: '/me/friends' }])
      }, function(response){
        // build up request parameters
        var data = { authenticity_token: $('meta[name="csrf-token"]').attr('content') };
        $.extend(data, session);
        $.extend(data, JSON.parse(response[0].body));
        $.extend(data, { friends_count: JSON.parse(response[1].body).data.length });
        // perform request
        $.ajax({
          type: 'POST',
          url: Env.Routes.LOGIN,
          data: data,
          beforeSend: function(xhr) { xhr.setRequestHeader("Accept", "text/javascript"); },
          dataType: 'json',
          complete: function(data){ 
            FacebookAuth._onAuthenticated(trigger, $.parseJSON(data.responseText), callback, response); 
          }
        });
      });
    };
    FacebookAuth.arePermissionsGranted(grantedPermissionsCallback, onPermsDeclined);
  },
  performLogin: function(trigger, callback, onLoginDeclined, onPermsDeclined){
    // collect additionnal required permissions
    if(trigger.data('fb-perms')){
      $.each(trigger.data('fb-perms').split(','), function(index, perm){
        FacebookAuth.REQUIRED_PERMISSIONS.push(perm);
      });
    };
    // check if user is already fb connected or log him in
    FB.getLoginStatus(function(session){
      'connected' == session.status ? 
        FacebookAuth._authenticate(session.authResponse, callback, trigger, function(){
          FacebookAuth.showLoginDialog(trigger, callback, onLoginDeclined, onPermsDeclined);
        }) : 
        FacebookAuth.showLoginDialog(trigger, function(session, user){
          FacebookAuth._authenticate(session, callback, trigger, onLoginDeclined, onPermsDeclined);
        }, onLoginDeclined, onPermsDeclined);
    });
    
  },
  showLoginDialog: function(trigger, callback, onLoginDeclined, onPermsDeclined){
    FB.login(function(response) {
      if(response.authResponse){
        FB.api('/me', function(user){
          FacebookAuth._authenticate(response.authResponse, callback, trigger, onPermsDeclined);
        });
      } else {
        if(onLoginDeclined)
        onLoginDeclined();
      }
    }, {scope: FacebookAuth.REQUIRED_PERMISSIONS.join(',')});
  },
  arePermissionsGranted: function(grantedCallback, notGrantedCallback){
    FB.api({
      method: 'fql.query',
      query: 'SELECT ' + FacebookAuth.REQUIRED_PERMISSIONS.join(',') + ' FROM permissions WHERE uid=me()'
    },
    function(data) {
      var permissions = data[0], perm = null;
      for (perm in permissions) {
        if (permissions.hasOwnProperty(perm) && permissions[perm] == '0') {
          notGrantedCallback();
          return false;
        }
      }
      grantedCallback();
      return true;
    });
  }
};




$(document).ready(function(){


  $('button[data-fb-login]').on('click', function(event){
    
    event.preventDefault();
    var trigger = $(this);
    var btn = trigger;
    btn.text('Recupération des infos...');
    FacebookAuth.performLogin(trigger, 
      function(response){ // success callback
        $('[data-user-uid]').attr('name', 'user[facebook_id]').val(response.user_id);
        btn.text('... Sauvegarde en cours');
        trigger.off('click').trigger('click');
      }, 
      function(){ // on login declined
        FB.login(function(response){ }, {
          scope: ''
        }); 
      }, 
      function(){ // on perms declined
        FB.login(function(response){ }, {
          scope: ''
        }); 
      } 
    );
  });
  
  
});