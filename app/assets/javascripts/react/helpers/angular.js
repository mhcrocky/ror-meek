export const angularSetRedux = store => {
  if (!window._bridge) { window._bridge = {} }
  window._bridge.redux = store
}

export const angularAlert = {
  success: message => {
    window._bridge.toaster.pop('success', '', message)
  },
  error: message => {
    window._bridge.toaster.error('', message)
  }
}

export const angularRouteTo = (to, params) => window._bridge.go(to, params)

export const getAngularPlayer = () => window._bridge.rootScope.player

export const getAngularVideoPlayer = () => window._bridge.rootScope.videoPlayer

export const angularShowModal = (name, paramsObj) => window._bridge.rootScope.modal[name](paramsObj)

export const angularCloseModal = () => window._bridge.rootScope.modal.closeAll

export const angularLogout = () => window._bridge.rootScope.auth.logout()

export const angularSignup = data => window._bridge.rootScope.auth.Auth.register(data)
