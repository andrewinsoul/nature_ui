const NatureUIPasswordToggle = {
  mounted() {
    const button = this.el;
    const input = document.getElementById(button.dataset.inputId);
    if (!input) return;

    const eyeClosed = button.querySelector('[data-eye-closed]');
    const eyeOpen = button.querySelector('[data-eye-open]');

    const toggle = (e) => {
      e.preventDefault();

      input.type = input.type === 'password' ? 'text' : 'password';

      eyeClosed?.classList.toggle('hidden');
      eyeOpen?.classList.toggle('hidden');
    };

    button.addEventListener('click', toggle);
  }
};

export default NatureUIPasswordToggle;