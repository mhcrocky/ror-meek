import { call } from 'redux-saga/effects'
import { requestAPI } from './API'

export const callAPI = {

  get: function*(endpoint) {
    const result = yield call(requestAPI.get, endpoint)
    if (result.errors) { throw new Error(result) }
    return result
  },

  post: function*(endpoint, data) {
    const result = yield call(requestAPI.post, endpoint, data)
    if (result.errors) { throw new Error(result) }
    return result
  },

  put: function*(endpoint, data) {
    const result = yield call(requestAPI.put, endpoint, data)
    if (result.errors) { throw new Error(result) }
    return result
  },

  delete: function*(endpoint) {
    const result = yield call(requestAPI.delete, endpoint)
    if (result.errors) { throw new Error(result) }
    return result
  }

}
