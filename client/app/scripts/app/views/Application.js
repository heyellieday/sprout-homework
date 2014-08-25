define(function (require) {

    "use strict";

    var $                   = require('jquery'),
        Backbone            = require('backbone'),
        TwitterUsersView    = require('app/views/TwitterUsers'),
        TwitterUserModel    = require('app/models/TwitterUser'),
        Handelbars          = require('hbs!partials/application')
        SproutUserModel     = require('app/models/SproutUser');

    return Backbone.View.extend({

        initialize: function () {
            this.TwitterUsers = new TwitterUserModel.TwitterUserCollection();
            this.SproutUser = new SproutUserModel.SproutUser();
        },

        render: function () {
            this.$el.empty();
            this.$el.html(Handelbars());
            var usersView = new TwitterUsersView({collection: this.TwitterUsers, el: $(".users", this.el)});
            usersView.render();
            return this;
        },

        events: {
            
        },

    });

});