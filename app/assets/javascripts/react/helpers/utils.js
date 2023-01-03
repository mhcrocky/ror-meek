export const isEmpty = obj => typeof obj !== 'object' || Object.keys(obj).length < 1

export const truncate = (value, limit) => {
  if (!value) { return '' }
  if (!limit || value.length <= limit) { return value }

  return value
           .slice(0, limit)
           .replace(/[^\s]+$/g, '')
           .slice(0, -1) + '...'
}

export const deSnakeCased = (text = '') => text.replace(/_/g, ' ')

export const deCamelCased = (text = '') => text.replace(/([a-z0-9])([A-Z])/g, '$1 $2').toLowerCase()

export const capitalised = (text = '') => text.split(' ').map(w => w[0].toUpperCase() + w.slice(1)).join(' ')

export const indexedObject = (array, key) => {
  const obj = {}
  for (let item of array) { obj[item[key]] = item }
  return obj
}
