"use strict";

exports.__esModule = true;
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propTypes = _interopRequireDefault(require("prop-types"));

var _Input = _interopRequireDefault(require("./Input"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function _inheritsLoose(subClass, superClass) { subClass.prototype = Object.create(superClass.prototype); subClass.prototype.constructor = subClass; subClass.__proto__ = superClass; }

var isValid = function isValid(num) {
  return typeof num === 'number' && !isNaN(num);
};

var isAtDelimiter = function isAtDelimiter(num, str) {
  var next = str.length <= 1 ? false : parseFloat(str.substr(0, str.length - 1));
  return typeof next === 'number' && !isNaN(next) && next === num;
};

var NumberInput =
/*#__PURE__*/
function (_React$Component) {
  _inheritsLoose(NumberInput, _React$Component);

  function NumberInput() {
    var _this;

    for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
      args[_key] = arguments[_key];
    }

    _this = _React$Component.call.apply(_React$Component, [this].concat(args)) || this;
    _this.state = {};

    _this.handleChange = function (value) {
      var current = _this.props.value,
          number = parseFloat(value);
      if (value == null || value.trim() === '' || !isValid(number)) return _this.props.onChange(null);
      if (isValid(number) && number !== current && !isAtDelimiter(number, value)) return _this.props.onChange(number);

      _this.setState({
        value: value
      });
    };

    return _this;
  }

  var _proto = NumberInput.prototype;

  _proto.componentWillReceiveProps = function componentWillReceiveProps(nextProps) {
    var value = nextProps.value;
    value = value == null || isNaN(value) ? '' : '' + value;
    this.setState({
      value: value
    });
  };

  _proto.render = function render() {
    var _this$props = this.props,
        value = _this$props.value,
        props = _objectWithoutPropertiesLoose(_this$props, ["value"]);

    value = this.state.value || value;
    return _react.default.createElement(_Input.default, _extends({}, props, {
      type: "number",
      value: value,
      onChange: this.handleChange
    }));
  };

  return NumberInput;
}(_react.default.Component);

NumberInput.propTypes = {
  value: _propTypes.default.number,
  onChange: _propTypes.default.func
};
var _default = NumberInput;
exports.default = _default;
module.exports = exports["default"];