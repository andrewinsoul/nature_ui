let NatureInput = {
  mounted() {
    this.connHandler = this.handleMode.bind(this);
    window.addEventListener(
      "natureui:connection_changed",
      this.connHandler
    );

    this.input = this.el.querySelector("input");
    this.rules = JSON.parse(this.el.dataset.rules || "{}");
    this.errorEl = this.el.querySelector("[data-client-error]");
    this._fallbackAttached = false;

    this.onInput = () => {
      if (!window.NatureUI.isInteractive()) {
        this.validate();
      }
    };

    this.onBlur = () => {
      if (!window.NatureUI.isInteractive()) {
        this.validate();
      }
    };

    this.handleMode();
  },

  destroyed() {
    window.removeEventListener(
      "natureui:connection_changed",
      this.connHandler
    );
    this.enableLiveViewMode();
  },

  handleMode() {
    if (window.NatureUI.isInteractive()) {
      this.enableLiveViewMode();
    } else {
      this.enableFallbackMode();
    }
  },

  enableLiveViewMode() {
    if (!this.input) return;
    if (this._fallbackAttached) {
      this.input.removeEventListener("input", this.onInput);
      this.input.removeEventListener("blur", this.onBlur);
      this._fallbackAttached = false;
    }
    this.clearError();
  },

  enableFallbackMode() {
    if (!this.input || this._fallbackAttached) return;
    this.input.addEventListener("input", this.onInput);
    this.input.addEventListener("blur", this.onBlur);
    this._fallbackAttached = true;
  },

  validate() {
    if (!this.input) return;
    const value = this.input.value;

    if (this.rules.required && !value.trim()) {
      return this.showError("This field is required");
    }

    for (let rule of this.rules.rules || []) {
      if (!rule) continue;

      const emptyOptional = value === "" && !this.rules.required;

      if (rule.type === "length") {
        if (emptyOptional) continue;
        if (rule.min != null && value.length < rule.min) {
          return this.showError(
            rule.message || `Minimum ${rule.min} characters`
          );
        }
        if (rule.max != null && value.length > rule.max) {
          return this.showError(
            rule.message || `Maximum ${rule.max} characters`
          );
        }
      }

      if (rule.type === "format") {
        if (emptyOptional) continue;
        try {
          const regex = new RegExp(rule.pattern);
          if (!regex.test(value)) {
            return this.showError(rule.message || "Invalid format");
          }
        } catch (_) {
          return this.showError(rule.message || "Invalid format");
        }
      }

      if (rule.type === "inclusion" && rule.values) {
        if (emptyOptional) continue;
        if (!rule.values.includes(value)) {
          return this.showError(rule.message || "Invalid value");
        }
      }

      if (rule.type === "number") {
        if (value === "") {
          continue;
        }
        const n = Number(value);
        if (Number.isNaN(n)) {
          return this.showError(rule.message || "Must be a number");
        }
        if (rule.min != null && n < rule.min) {
          return this.showError(
            rule.message || `Must be greater than or equal to ${rule.min}`
          );
        }
        if (rule.max != null && n > rule.max) {
          return this.showError(
            rule.message || `Must be less than or equal to ${rule.max}`
          );
        }
      }
    }

    this.clearError();
  },

  showError(message) {
    if (!this.errorEl || !this.input) return;
    this.errorEl.classList.remove("hidden");
    this.errorEl.innerHTML = `<p class="text-red-600 text-xs">${message}</p>`;
  },

  clearError() {
    if (!this.errorEl) return;
    this.errorEl.classList.add("hidden");
    this.errorEl.innerHTML = "";
  }
};

export default NatureInput;
