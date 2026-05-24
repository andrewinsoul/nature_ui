let NatureUIPasswordToggle = {
  mounted() {
    const button = this.el
    const inputId = button.dataset.inputId
    const input = document.getElementById(inputId)
    if (!input) return

    const eyeClosed = button.querySelector('[data-eye-closed]')
    const eyeOpen = button.querySelector('[data-eye-open]')

    const toggle = (event) => {
      event.preventDefault()
      const isPassword = input.type === 'password'
      input.type = isPassword ? 'text' : 'password'
      if (eyeClosed && eyeOpen) {
        eyeClosed.classList.toggle('hidden', !isPassword)
        eyeOpen.classList.toggle('hidden', isPassword)
      }
    }

    button.addEventListener('click', toggle)
  }
}

export default NatureUIPasswordToggle;