"use strict";

exports.__esModule = true;
exports.default = void 0;

var _propTypes = _interopRequireDefault(require("prop-types"));

var _react = _interopRequireDefault(require("react"));

var _Form = _interopRequireDefault(require("./Form"));

var _Field = _interopRequireDefault(require("./Field"));

var _ErrorUtils = require("./utils/ErrorUtils");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function _inheritsLoose(subClass, superClass) { subClass.prototype = Object.create(superClass.prototype); subClass.prototype.constructor = subClass; subClass.__proto__ = superClass; }

/**
 * A `Form` component that takes a `name` prop. Functions exactly like a normal
 * Form, except that when a `name` is present it will defer errors up to the parent `<Form>`,
 * functioning like a `<Form.Field>`.
 *
 * This is useful for encapsulating complex input groups into self-contained
 * forms without having to worry about `"very.long[1].paths[4].to.fields"` for names.
 */
var NestedForm =
/*#__PURE__*/
function (_React$Component) {
  _inheritsLoose(NestedForm, _React$Component);

  function NestedForm() {
    return _React$Component.apply(this, arguments) || this;
  }

  var _proto = NestedForm.prototype;

  _proto.render = function render() {
    var _this$props = this.props,
        name = _this$props.name,
        schema = _this$props.schema,
        errors = _this$props.errors,
        props = _objectWithoutPropertiesLoose(_this$props, ["name", "schema", "errors"]);

    return _react.default.createElement(_Field.default, {
      name: name,
      noResolveType: true,
      noValidate: true,
      events: "onChange"
    }, function (_ref) {
      var meta = _ref.meta,
          value = _ref.value,
          onChange = _ref.onChange;
      return _react.default.createElement(_Form.default, _extends({
        as: "div"
      }, props, {
        value: value,
        onChange: onChange,
        onError: function onError(errors) {
          return meta.onError((0, _ErrorUtils.prefix)(errors, name));
        },
        errors: (0, _ErrorUtils.unprefix)(name ? meta.errors : errors, name),
        schema: schema || meta.schema,
        context: name ? _extends({}, meta.context, props.context) : props.context
      }));
    });
  };

  return NestedForm;
}(_react.default.Component);

NestedForm.propTypes = {
  name: _propTypes.default.string.isRequired,
  schema: _propTypes.default.object,
  errors: _propTypes.default.object,
  meta: _propTypes.default.shape({
    errors: _propTypes.default.object.isRequired,
    onError: _propTypes.default.func.isRequired
  })
};
var _default = NestedForm;
exports.default = _default;
module.exports = exports["default"];