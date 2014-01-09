SimplyBetterApplication.Utils = {
    userSignedIn: function(){
        if (window.SimplyBetterApplication.config.userEmail){
          return true;
        }
        return false;
    }
}
