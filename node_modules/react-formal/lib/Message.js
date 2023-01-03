"use strict";

exports.__esModule = true;
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propTypes = _interopRequireDefault(require("prop-types"));

var _uniqMessage = _interopRequireDefault(require("./utils/uniqMessage"));

var _ErrorUtils = require("./utils/ErrorUtils");

var _Contexts = require("./Contexts");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function _inheritsLoose(subClass, superClass) { subClass.prototype = Object.create(superClass.prototype); subClass.prototype.constructor = subClass; subClass.__proto__ = superClass; }

var flatten = function flatten(arr, next) {
  return arr.concat(next);
};
/**
 * Represents a Form validation error message. Only renders when the
 * value that it is `for` is invalid.
 *
 * @alias FormMessage
 */


var Message =
/*#__PURE__*/
function (_React$Component) {
  _inheritsLoose(Message, _React$Component);

  function Message() {
    return _React$Component.apply(this, arguments) || this;
  }

  var _proto = Message.prototype;

  _proto.render = function render() {
    var _this$props = this.props,
        errors = _this$props.errors,
        names = _this$props.for,
        className = _this$props.className,
        _this$props$extract = _this$props.extract,
        extract = _this$props$extract === void 0 ? function (error) {
      return error.message || error;
    } : _this$props$extract,
        _this$props$filter = _this$props.filter,
        filter = _this$props$filter === void 0 ? _uniqMessage.default : _this$props$filter,
        _this$props$children = _this$props.children,
        children = _this$props$children === void 0 ? function (errors, props) {
      return _react.default.createElement("span", props, errors.join(', '));
    } : _this$props$children,
        props = _objectWithoutPropertiesLoose(_this$props, ["errors", "for", "className", "extract", "filter", "children"]);

    errors = (0, _ErrorUtils.filterAndMapErrors)({
      errors: errors,
      names: names
    });
    if (!errors || !Object.keys(errors).length) return null;
    return children(Object.values(errors).reduce(flatten, []).filter(function () {
      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
        args[_key] = arguments[_key];
      }

      return filter.apply(void 0, args.concat([extract]));
    }).map(extract), _extends({}, props, {
      className: className
    }));
  };

  return Message;
}(_react.default.Component);

Message.propTypes = {
  for: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.arrayOf(_propTypes.default.string)]),
  formKey: _propTypes.default.string,

  /**
   * A function that maps an array of message strings
   * and returns a renderable string or ReactElement.
   *
   * ```js
   * <Message>
   *  {errors => errors.join(', ')}
   * </Message>
   * ```
   */
  children: _propTypes.default.func,

  /**
   * Map the passed in message object for the field to a string to display
   */
  extract: _propTypes.default.func,
  filter: _propTypes.default.func
};

var _default = (0, _Contexts.withState)(function (_ref, props) {
  var errors = _ref.errors;
  return _react.default.createElement(Message, _extends({
    errors: errors
  }, props));
}, _Contexts.FORM_DATA.errors);

exports.default = _default;
module.exports = exports["default"];