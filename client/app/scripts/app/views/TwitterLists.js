define(function (require) {

    "use strict";

    var $                   = require('jquery'),
        _                   = require('underscore'),
        Backbone            = require('backbone'),
        TwitterListView     = require('app/views/TwitterList');

    return Backbone.View.extend({

        render: function () {
            this.$el.empty();
            _.each(this.collection.models, function (twitterList) {
                this.$el.append(new TwitterListView({model: twitterList}).render().el);
            }, this);
            return this;
        }
    });

});