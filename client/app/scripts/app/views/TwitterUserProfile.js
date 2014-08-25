define(function (require) {

    "use strict";

    var $                   = require('jquery'),
        _                   = require('underscore'),
        Backbone            = require('backbone'),
        Handlebars          = require('hbs!partials/TwitterUserProfile');

    return Backbone.View.extend({

        render: function () {
            this.$el.html(Handlebars(this.model.attributes));
            console.log(this.model.attributes);
            return this;
        },
        twitterListsCheck: function (user_id) {
            require(["app/views/TwitterLists", "app/models/TwitterList", 'app/models/TwitterUserInList', "app/views/TwitterUsersInList"], function (TwitterListsView, models, UserModel, TwitterUsersInListView) {
                $( "#lists" ).toggleClass("hidden");
                $( "#lists-header" ).toggleClass("hidden");
                if (!$( "#lists" ).hasClass( "hidden" )){
                    var twitterLists = new models.TwitterListCollection;
                    twitterLists.fetch({
                        success: function (data) {
                            var listView = new TwitterListsView({collection: twitterLists, el: $("#lists")});
                            listView.render();
                            _.each(twitterLists.models, function (twitterList) {
                                console.log(twitterList.attributes.id_str);
                                var twitterUsers = new UserModel.TwitterUserInListCollection([], {list_id: twitterList.attributes.id_str});
                                twitterUsers.fetch({
                                    success: function (data) {
                                        var usersInlistView = new TwitterUsersInListView({collection: twitterUsers, el: $("#"+twitterList.attributes.id_str)});
                                        usersInlistView.render();
                                    }
                                });
                            }, this);
                        }
                    }); 
                }
            });
        }
    });

});