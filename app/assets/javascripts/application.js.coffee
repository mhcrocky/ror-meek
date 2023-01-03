# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require babel-polyfill/dist/polyfill
#= require jquery
#= require angular
#= require angulartics
#= require angulartics/src/angulartics-gtm
#= require AngularDevise
#= require angular-ui-router/release/angular-ui-router
#= require angular-resource
#= require angular-rails-templates
#= require jplayer/dist/jplayer/jquery.jplayer.js
#= require jquery-debounce-throttle.js
#= require ng-dialog
#= require jquery.serializejson
#= require angularjs-toaster/toaster
#= require ngstorage/ngStorage
#= require angular-cookies/angular-cookies

#= require plyr/dist/plyr.js

#= require ./react/app.js

#= require_tree ./ng-app
#= require_tree ../templates

