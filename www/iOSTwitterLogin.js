var exec = require('cordova/exec');

var iOSTwitterLogin = function(callback) {
  var iOSTwitterLoginReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(data.error, null);

    return callback(null, data.sessionToken);
  }

  exec(iOSTwitterLoginReturn, iOSTwitterLoginReturn, 'iOSTwitterLogin', 'iOSTwitterLogin', []);
};

module.exports = iOSTwitterLogin;
