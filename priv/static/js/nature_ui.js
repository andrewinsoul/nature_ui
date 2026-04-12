(() => {
  // assets/js/hooks/input.js
  var NatureInput = {
    mounted() {
      this.input = this.el.querySelector("input");
      this.rules = JSON.parse(this.el.dataset.rules || "{}");
      this.errorEl = this.el.querySelector("[data-client-error]");
      this.input.addEventListener("input", () => {
        if (!navigator.onLine) {
          this.validate();
        }
      });
      window.addEventListener("online", () => {
        this.clearError();
      });
    },
    validate() {
      const value = this.input.value;
      if (this.rules.required && !value) {
        return this.showError("This field is required");
      }
      for (let rule of this.rules.rules || []) {
        if (!rule) continue;
        if (rule.type === "length") {
          if (rule.min && value.length < rule.min) {
            return this.showError(`Minimum ${rule.min} characters`);
          }
          if (rule.max && value.length > rule.max) {
            return this.showError(`Maximum ${rule.max} characters`);
          }
        }
        if (rule.type === "format") {
          const regex = new RegExp(rule.pattern);
          if (!regex.test(value)) {
            return this.showError(rule.message || "Invalid format");
          }
        }
      }
      this.clearError();
    },
    showError(message) {
      this.errorEl.classList.remove("hidden");
      this.errorEl.innerHTML = `<p class="text-red-600 text-xs">${message}</p>`;
    },
    clearError() {
      this.errorEl.classList.add("hidden");
      this.errorEl.innerHTML = "";
    }
  };
  var input_default = NatureInput;

  // assets/js/hooks/modal.js
  var NatureModal = {
    mounted() {
      this.modal = this.el.querySelector("[data-modal]");
      this.overlay = this.el.querySelector("[data-overlay]");
      this.animated = this.el.dataset.animated === "true";
      window.addEventListener("open-modal", () => this.show());
      this.el.addEventListener("click", (e) => {
        if (e.target.closest("[data-close]") || e.target === this.overlay) {
          this.hide();
        }
      });
      window.addEventListener("keydown", (e) => {
        if (e.key === "Escape") this.hide();
      });
    },
    show() {
      if (this.animated) {
        this.modal.classList.remove("opacity-0", "scale-95");
        this.modal.classList.add("opacity-100", "scale-100");
        this.overlay.classList.remove("opacity-0", "pointer-events-none");
        this.overlay.classList.add("opacity-100");
      } else {
        this.modal.classList.remove("hidden");
        this.overlay.classList.remove("hidden");
      }
    },
    hide() {
      if (this.animated) {
        this.modal.classList.add("opacity-0", "scale-95");
        this.modal.classList.remove("opacity-100", "scale-100");
        this.overlay.classList.add("opacity-0", "pointer-events-none");
        this.overlay.classList.remove("opacity-100");
      } else {
        this.modal.classList.add("hidden");
        this.overlay.classList.add("hidden");
      }
    }
  };
  var modal_default = NatureModal;

  // assets/js/index.js
  window.NatureUIHooks = {
    NatureInput: input_default,
    NatureModal: modal_default
  };
})();
