"use strict";

exports.__esModule = true;
exports.default = isNativeType;
var types = /^(button|checkbox|color|date|datetime|datetime-local|email|file|month|number|password|radio|range|reset|search|submit|tel|text|time|url|w)$/;

function isNativeType(type) {
  return typeof type === 'string' && type.match(types);
}

module.exports = exports["default"];