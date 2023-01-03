import { all, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { angularCloseModal, angularShowModal } from '../helpers/angular'

function* show({ name, params }) {
  try {
    angularShowModal(name, params)

  } catch (e) { console.warn(e) }
}

function* close() {
  try {
    angularCloseModal()

  } catch (e) { console.warn(e) }
}

export function* modalSaga() {
  yield all([
    takeLatest(actions.modal.show, show),
    takeLatest(actions.modal.close, close)
  ])
}