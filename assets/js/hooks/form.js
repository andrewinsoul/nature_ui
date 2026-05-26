const NatureForm = {
  mounted() {
    this.handleSubmit = this.handleSubmit.bind(this)

    this.el.addEventListener(
      "submit",
      this.handleSubmit
    )

    window.addEventListener(
      "natureui:connection_changed",
      () => {
        this.syncConnectionState()
      }
    )

    this.syncConnectionState()
  },

  destroyed() {
    this.el.removeEventListener(
      "submit",
      this.handleSubmit
    )
  },

  handleSubmit(e) {
    if (window.NatureUI.isInteractive()) {
      return
    }

    const fallback =
      this.el.dataset.fallback || "prevent"

    if (fallback === "prevent") {
      e.preventDefault()
    }

    this.showDisconnectedState()
  },

  syncConnectionState() {
    if (window.NatureUI.isInteractive()) {
      this.el.dataset.connected = "true"
    } else {
      this.el.dataset.connected = "false"
    }
  },

  showDisconnectedState() {
    this.el.dispatchEvent(
      new CustomEvent("natureui:form_disconnected", {
        bubbles: true
      })
    )
  }
}

export default NatureForm