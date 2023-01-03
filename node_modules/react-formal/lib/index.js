"use strict";

exports.__esModule = true;
exports.default = exports.statics = void 0;

var _Form = _interopRequireDefault(require("./Form"));

var _Field = _interopRequireDefault(require("./Field"));

var _FieldArray = _interopRequireDefault(require("./FieldArray"));

var _Message = _interopRequireDefault(require("./Message"));

var _Summary = _interopRequireDefault(require("./Summary"));

var _errToJSON = _interopRequireDefault(require("./utils/errToJSON"));

var _FormSubmit = _interopRequireDefault(require("./FormSubmit"));

var _config = _interopRequireDefault(require("./config"));

var _invariant = _interopRequireDefault(require("invariant"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

var statics = {
  Field: _Field.default,
  FieldArray: _FieldArray.default,
  Message: _Message.default,
  Summary: _Summary.default,
  Submit: _FormSubmit.default,
  setDefaults: function setDefaults(defaults) {
    if (defaults === void 0) {
      defaults = {};
    }

    _extends(_config.default, defaults);
  },
  toErrors: function toErrors(err) {
    !(err && err.name === 'ValidationError') ? process.env.NODE_ENV !== "production" ? (0, _invariant.default)(false, '`toErrors()` only works with ValidationErrors.') : invariant(false) : void 0;
    return (0, _errToJSON.default)(err);
  }
};
exports.statics = statics;

_extends(_Form.default, statics);

_Form.default.statics = statics;
var _default = _Form.default;
exports.default = _default;