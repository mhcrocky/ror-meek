"use strict";

exports.__esModule = true;
exports.default = errorManager;

var _errToJSON = _interopRequireDefault(require("./utils/errToJSON"));

var _paths = require("./utils/paths");

var _ErrorUtils = require("./utils/ErrorUtils");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

var isValidationError = function isValidationError(err) {
  return err && err.name === 'ValidationError';
};

function errorManager(handleValidation) {
  return {
    collect: function collect(paths, pristineErrors, options) {
      if (pristineErrors === void 0) {
        pristineErrors = _ErrorUtils.EMPTY_ERRORS;
      }

      paths = (0, _paths.reduce)([].concat(paths));

      var errors = _extends({}, pristineErrors);

      var nextErrors = errors;
      var workDone = false;
      paths.forEach(function (path) {
        nextErrors = (0, _paths.trim)(path, nextErrors);
        if (errors !== nextErrors) workDone = true;
      });
      var validations = paths.map(function (path) {
        return Promise.resolve(handleValidation(path, options)).then(function (validationError) {
          if (!validationError) return true;
          if (!isValidationError(validationError)) throw validationError;
          (0, _errToJSON.default)(validationError, nextErrors);
        });
      });
      return Promise.all(validations).then(function (results) {
        if (!workDone && results.every(Boolean)) return pristineErrors;
        return nextErrors;
      });
    }
  };
}

module.exports = exports["default"];