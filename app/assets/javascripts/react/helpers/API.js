import { angularAlert } from '../helpers/angular'

const SERVER_ERRORS = [500, 404]

const responseHandler = async response => {
  if (SERVER_ERRORS.includes(response.status)) {
    console.warn('Error', response.statusText)
    angularAlert.error(response.statusText)
    throw new Error(response.statusText)
  }
  const text = await response.text()
  return JSON.parse(text || '{}')
}

const _request = (path, options) => (
  fetch(path, {
    ...options,
    credentials: 'include',
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
      Accept: 'application/json'
    }
  }).then(responseHandler))

export const requestAPI = {

  post: (path, data) => _request(path, {
    method: 'POST',
    body: JSON.stringify(data)
  }),

  get: path => _request(path, {
    method: 'GET'
  }),

  delete: path => _request(path, {
    method: 'DELETE'
  }),

  put: (path, data) => _request(path, {
    method: 'PUT',
    body: JSON.stringify(data)
  })
}
