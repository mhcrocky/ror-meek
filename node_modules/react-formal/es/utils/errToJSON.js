export default function errToJSON(error, target) {
  if (target === void 0) {
    target = {};
  }

  if (error.inner.length) {
    error.inner.forEach(function (inner) {
      errToJSON(inner, target, inner.path);
    });
    return target;
  }

  var path = error.path || '';
  var existing = target[path];
  var json = {
    message: error.message,
    values: error.params,
    type: error.type
  };
  target[path] = existing ? existing.concat([json]) : [json];
  return target;
}