import prop from 'property-expr';
import uniq from 'lodash/uniq';
export function inPath(basePath, childPath) {
  if (basePath === childPath) return true;
  var partsA = prop.split(basePath) || [],
      partsB = prop.split(childPath) || [];
  if (partsA.length > partsB.length) return false;
  return partsA.every(function (part, idx) {
    return clean(part) === clean(partsB[idx]);
  });
}
export function clean(part) {
  return isQuoted(part) ? part.substr(1, part.length - 2) : part;
}
export function isQuoted(str) {
  return typeof str === 'string' && str && (str[0] === '"' || str[0] === "'");
}
export function reduce(paths) {
  paths = uniq(paths == null ? [] : [].concat(paths));
  if (paths.length <= 1) return paths;
  return paths.reduce(function (paths, current) {
    paths = paths.filter(function (p) {
      return !inPath(current, p);
    });
    if (!paths.some(function (p) {
      return inPath(p, current);
    })) paths.push(current);
    return paths;
  }, []);
}
export function trim(rootPath, pathHash, exact) {
  if (exact === void 0) {
    exact = false;
  }

  var workDone = false;
  var result = {};
  var matches = exact ? function (p) {
    return p === rootPath;
  } : function (p) {
    return inPath(rootPath, p);
  };
  Object.keys(pathHash).forEach(function (path) {
    if (matches(path)) {
      return workDone = true;
    }

    result[path] = pathHash[path];
  });
  return workDone ? result : pathHash;
}