import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { LOCAL_STORAGE, VIEW_MODES } from '../config/strings'

function* restoreMode() {
  const mode = JSON.parse(localStorage.getItem(LOCAL_STORAGE.VIEW_MODE) || '""') || VIEW_MODES.LIST
  yield put({ type: actions.switches.setViewMode, mode })
}

function* setViewMode({ mode }) {
  localStorage.setItem(LOCAL_STORAGE.VIEW_MODE, `"${mode}"`)
}

export function* switchesSaga() {
  yield all([
    takeLatest(actions.application.init, restoreMode),
    takeLatest(actions.switches.setViewMode, setViewMode)
  ])
}
