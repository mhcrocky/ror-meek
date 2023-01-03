"use strict";

exports.__esModule = true;
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propTypes = _interopRequireDefault(require("prop-types"));

var _elementType = _interopRequireDefault(require("prop-types-extra/lib/elementType"));

var _Message = _interopRequireDefault(require("./Message"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function _inheritsLoose(subClass, superClass) { subClass.prototype = Object.create(superClass.prototype); subClass.prototype.constructor = subClass; subClass.__proto__ = superClass; }

/**
 * Display all Form validation `errors` in a single summary list.
 *
 * ```jsx { "editable": true }
 * <Form
 *   schema={modelSchema}
 *   defaultValue={modelSchema.default()}
 * >
 *   <Form.Summary/>
 *
 *   <Form.Field name='name.first' placeholder='first'/>
 *   <Form.Field name='name.last' placeholder='surname'/>
 *   <Form.Field name='dateOfBirth' placeholder='dob'/>
 *
 *   <Form.Submit>Validate</Form.Submit>
 * </Form>
 * ```
 */
var Summary =
/*#__PURE__*/
function (_React$PureComponent) {
  _inheritsLoose(Summary, _React$PureComponent);

  function Summary() {
    return _React$PureComponent.apply(this, arguments) || this;
  }

  var _proto = Summary.prototype;

  _proto.render = function render() {
    var _this$props = this.props,
        formatMessage = _this$props.formatMessage,
        props = _objectWithoutPropertiesLoose(_this$props, ["formatMessage"]);

    return _react.default.createElement(_Message.default, props, function (errors) {
      return errors.map(formatMessage);
    });
  };

  return Summary;
}(_react.default.PureComponent);

Summary.propTypes = {
  /**
   * An error message renderer, Should return a `ReactElement`
   * ```
   * function(
   *   message: string,
   *   idx: number,
   *   errors: array
   * ) -> ReactElement
   * ```
   */
  formatMessage: _propTypes.default.func.isRequired,

  /**
   * A DOM node tag name or Component class the Message should render as.
   */
  as: _elementType.default.isRequired,

  /**
   * A css class that should be always be applied to the Summary container.
   */
  errorClass: _propTypes.default.string,

  /**
   * Specify a group to show errors for, if empty all form errors will be shown in the Summary.
   */
  group: _propTypes.default.string
};
Summary.defaultProps = {
  as: 'ul',
  formatMessage: function formatMessage(message, idx) {
    return _react.default.createElement("li", {
      key: idx
    }, message);
  }
};
var _default = Summary;
exports.default = _default;
module.exports = exports["default"];