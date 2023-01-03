"use strict";

exports.__esModule = true;
exports.default = void 0;

var _propTypes = _interopRequireDefault(require("prop-types"));

var _react = _interopRequireDefault(require("react"));

var _warning = _interopRequireDefault(require("warning"));

var _memoizeOne = _interopRequireDefault(require("memoize-one"));

var _elementType = _interopRequireDefault(require("prop-types-extra/lib/elementType"));

var _createEventHandler = _interopRequireDefault(require("./utils/createEventHandler"));

var _ErrorUtils = require("./utils/ErrorUtils");

var _Contexts = require("./Contexts");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function _inheritsLoose(subClass, superClass) { subClass.prototype = Object.create(superClass.prototype); subClass.prototype.constructor = subClass; subClass.__proto__ = superClass; }

/**
 * A Form submit button, for triggering validations for the entire form or specific fields.
 */
var FormSubmit =
/*#__PURE__*/
function (_React$Component) {
  _inheritsLoose(FormSubmit, _React$Component);

  function FormSubmit() {
    var _this;

    for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
      args[_key] = arguments[_key];
    }

    _this = _React$Component.call.apply(_React$Component, [this].concat(args)) || this;
    _this.eventHandlers = {};
    _this.getEventHandlers = (0, _createEventHandler.default)(function (event) {
      return function () {
        for (var _len2 = arguments.length, args = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
          args[_key2] = arguments[_key2];
        }

        _this.props[event] && _this.props[event](args);

        _this.handleSubmit();
      };
    });
    _this.memoFilterAndMapErrors = (0, _memoizeOne.default)(_ErrorUtils.filterAndMapErrors, function (_ref, _ref2) {
      var a = _ref[0];
      var b = _ref2[0];
      return a.errors === b.errors && a.names === b.names && a.maperrors === b.maperrors;
    });
    return _this;
  }

  var _proto = FormSubmit.prototype;

  _proto.handleSubmit = function handleSubmit(event, args) {
    var _this$props = this.props,
        actions = _this$props.actions,
        triggers = _this$props.triggers;

    if (!actions) {
      return process.env.NODE_ENV !== "production" ? (0, _warning.default)(false, 'A Form submit event ' + 'was triggered from a component outside the context of a Form. ' + 'The Button should be wrapped in a Form component') : void 0;
    }

    if (triggers && triggers.length) actions.onValidate(triggers, event, args);else actions.onSubmit();
  };

  _proto.render = function render() {
    var _this$props2 = this.props,
        events = _this$props2.events,
        triggers = _this$props2.triggers,
        children = _this$props2.children,
        errors = _this$props2.errors,
        submits = _this$props2.submits,
        Component = _this$props2.as,
        _1 = _this$props2.actions,
        props = _objectWithoutPropertiesLoose(_this$props2, ["events", "triggers", "children", "errors", "submits", "as", "actions"]);

    var partial = triggers && triggers.length;

    if (partial) {
      errors = this.memoFilterAndMapErrors({
        errors: errors,
        names: triggers
      });
    }

    props = _extends(props, this.getEventHandlers(events));
    return typeof children === 'function' ? children(_extends({
      errors: errors,
      props: props
    }, submits)) : _react.default.createElement(Component, _extends({
      type: partial ? 'button' : 'submit'
    }, props), children);
  };

  return FormSubmit;
}(_react.default.Component);

FormSubmit.propTypes = {
  /**
   * The `<button/>` type
   */
  type: _propTypes.default.oneOf(['button', 'submit']),

  /**
   * Specify particular fields to validate in the related form. If empty the entire form will be validated.
   */
  triggers: _propTypes.default.arrayOf(_propTypes.default.string.isRequired),

  /**
   * Provide a render function to completely override the rendering behavior
   * of FormSubmit (`as` will be ignored). In addition to passing through props some
   * additional form submission metadata is injected to handle loading and disabled behaviors.
   *
   * ```js
   * <Form.Submit>
   *   {({ errors, props, submitting, submitCount, submitAttempts }) =>
   *     <button {...props} disabled={submitCount > 1}>
   *       submitting ? 'Saving…' : 'Submit'}
   *     </button>
   * </Form.Submit>
   * ```
   */
  children: _propTypes.default.oneOfType([_propTypes.default.node, _propTypes.default.func]),

  /**
   * Control the rendering of the Form Submit component when not using
   * the render prop form of `children`.
   */
  as: _elementType.default,

  /**
   * A string or array of event names that trigger validation.
   *
   * @default 'onClick'
   */
  events: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.arrayOf(_propTypes.default.string)]),

  /** @private */
  errors: _propTypes.default.object,

  /** @private */
  actions: _propTypes.default.object,

  /** @private */
  submits: _propTypes.default.object
};
FormSubmit.defaultProps = {
  as: 'button',
  events: ['onClick']
};

var _default = (0, _Contexts.withState)(function (ctx, props, ref) {
  return _react.default.createElement(_Contexts.FormActionsContext.Consumer, null, function (actions) {
    return _react.default.createElement(FormSubmit, _extends({}, props, {
      ref: ref,
      actions: actions,
      submits: ctx.submits,
      errors: ctx.errors
    }));
  });
}, _Contexts.FORM_DATA.errors | _Contexts.FORM_DATA.SUBMITS);

exports.default = _default;
module.exports = exports["default"];