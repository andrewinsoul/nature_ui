import NatureButton from "./hooks/button";
import NatureInput from "./hooks/input";
import NatureModal from "./hooks/modal";
import NatureUIPasswordToggle from "./hooks/passwordToggle";

const coreHooks = {
  NatureInput,
  NatureModal,
  NatureButton,
  NatureUIPasswordToggle
};

(function () {
  window.NatureUI.state = {
    liveviewConnected: true,
    browserOnline: navigator.onLine
  }
})()

window.addEventListener("phx:disconnected", () => {
  console.info("[NatureUI] Liveview disconnected")
  window.NatureUI.state.liveviewConnected = false
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  )
})

window.addEventListener("phx:reconnected", () => {
  console.info("[NatureUI] Liveview reconnected")
  window.NatureUI.state.liveviewConnected = true
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  )
})

window.addEventListener("offline", () => {
  console.info("[NatureUI] Browser offline")
  window.NatureUI.state.browserOnline = false
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  )
})

window.addEventListener("online", () => {
  console.info("[NatureUI] Browser online")
  window.NatureUI.state.browserOnline = true
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  )
})

window.NatureUI.isInteractive = function () {
  const state = window.NatureUI.state

  return state.browserOnline && state.liveviewConnected
}

window.NatureUI.actions = {}

window.NatureUI.registerAction = function (name, handler) {
  this.actions[name] = handler
}

NatureUI.install = (liveSocket, opts = {}) => {
  const {
    hooks: appHooks = {}
  } = opts

  const mergedHooks = {
    ...coreHooks,
    ...appHooks
  }

  liveSocket.hooks = {
    ...liveSocket.hooks,
    ...mergedHooks
  }
}
