define(function (require) {

    "use strict";

    var $                   = require('jquery'),
        _                   = require('underscore'),
        Backbone            = require('backbone'),
        Handlebars          = require('hbs!partials/TwitterList');

    return Backbone.View.extend({

        tagName: "div",

        initialize: function () {
            this.model.on("change", this.render, this);
        },

        render: function () {
            console.log(this.model.attributes);
            this.$el.html(Handlebars(this.model.attributes));
            return this;
        }
        
    });

});