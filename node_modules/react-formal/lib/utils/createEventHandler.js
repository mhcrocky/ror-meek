"use strict";

exports.__esModule = true;
exports.default = createEventHandler;

var _memoizeOne = _interopRequireDefault(require("memoize-one"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// create a set of handlers with a stable identity so as not to
// thwart SCU checks
function createEventHandler(getHandler) {
  var getter = (0, _memoizeOne.default)(getHandler);
  var handlers = {};
  return function (events) {
    var newHandlers = {};

    if (events) {
      for (var _iterator = [].concat(events), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
        var _ref;

        if (_isArray) {
          if (_i >= _iterator.length) break;
          _ref = _iterator[_i++];
        } else {
          _i = _iterator.next();
          if (_i.done) break;
          _ref = _i.value;
        }

        var event = _ref;
        newHandlers[event] = handlers[event] || getter(event);
      }
    }

    return handlers = newHandlers;
  };
}

module.exports = exports["default"];