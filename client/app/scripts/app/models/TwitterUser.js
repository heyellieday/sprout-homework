define(function (require) {

    "use strict";

    var $           = require('jquery'),
        Backbone    = require('backbone'),
        serverUrl   = require('app/serverUrl');

    var TwitterUser = Backbone.Model.extend({

        urlRoot: serverUrl + "/api/users/lookup",

        initialize: function () {
            
        }

    }),

    TwitterUserCollection = Backbone.Collection.extend({

        model: TwitterUser,

        url: function() {
            return serverUrl + '/api/users/lookup';
        },
        parse: function(response) {
            var twitterUsers= [];
            for(var user in response){
                    twitterUsers.push(response[user]);
            }
            return twitterUsers;
        }   

    });

    var originalSync = Backbone.sync;

    Backbone.sync = function (method, model, options) {
        if (method === "read") {
            options.dataType = "jsonp";
            return originalSync.apply(Backbone, arguments);
        }
    };

    return {
        TwitterUser: TwitterUser,
        TwitterUserCollection: TwitterUserCollection
    };

});