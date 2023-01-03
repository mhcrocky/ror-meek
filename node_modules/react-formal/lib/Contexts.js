"use strict";

exports.__esModule = true;
exports.withState = exports.FormDataContext = exports.FormActionsContext = exports.FORM_DATA = exports.initial = exports.DEFAULT_CHANNEL = void 0;

var _react = _interopRequireDefault(require("react"));

var _forwardRef = _interopRequireDefault(require("react-context-toolbox/forwardRef"));

var _shallowequal = _interopRequireDefault(require("shallowequal"));

var _ErrorUtils = require("./utils/ErrorUtils");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var DEFAULT_CHANNEL = '@@parent';
exports.DEFAULT_CHANNEL = DEFAULT_CHANNEL;

var isEqualOrNullish = function isEqualOrNullish(a, b) {
  return a === b || a == null && b == null;
};

var initial = {
  errors: _ErrorUtils.EMPTY_ERRORS,
  touched: {},
  submits: {
    submitCount: 0,
    submitAttempts: 0,
    submitting: false
  }
};
exports.initial = initial;
var FORM_DATA = {
  VALUE: 1,
  ERRORS: 2,
  TOUCHED: 4,
  SUBMITS: 8,
  YUP_CONTEXT: 16,
  NO_VALIDATE: 32
};
exports.FORM_DATA = FORM_DATA;

var FormActionsContext = _react.default.createContext(null);

exports.FormActionsContext = FormActionsContext;

var FormDataContext = _react.default.createContext(initial, function (prev, next) {
  var changed = 0;
  if (!(0, _shallowequal.default)(prev.errors, next.errors)) changed |= FORM_DATA.ERRORS;
  if (!(0, _shallowequal.default)(prev.submits, next.submits)) changed |= FORM_DATA.SUBMITS;
  if (!isEqualOrNullish(prev.value, next.value)) changed |= FORM_DATA.VALUE;
  return changed;
});

exports.FormDataContext = FormDataContext;

var withState = function withState(render, bits, opts) {
  return (0, _forwardRef.default)(function (props, ref) {
    return _react.default.createElement(FormDataContext.Consumer, {
      unstable_observedBits: bits
    }, function (context) {
      return render(context, props, ref);
    });
  }, opts || {});
};

exports.withState = withState;