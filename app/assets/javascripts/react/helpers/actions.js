export const actionName = name => join(actionName.scope, name)

actionName.scope = 'shared'

actionName.setScope = scope => actionName.scope = scope

actionName.async = name => ({
  request: join(actionName.scope, name, 'request'),
  success: join(actionName.scope, name, 'success'),
  fail: join(actionName.scope, name, 'fail')
})

const normalized = (str = '') => str.trim().replace(/\s+/g, '_').toUpperCase()

const join = (...arr) => arr.filter(a => !!a).map(normalized).join('__')