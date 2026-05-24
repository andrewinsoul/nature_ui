var __defProp = Object.defineProperty;
var __getOwnPropSymbols = Object.getOwnPropertySymbols;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __propIsEnum = Object.prototype.propertyIsEnumerable;
var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
var __spreadValues = (a, b) => {
  for (var prop in b || (b = {}))
    if (__hasOwnProp.call(b, prop))
      __defNormalProp(a, prop, b[prop]);
  if (__getOwnPropSymbols)
    for (var prop of __getOwnPropSymbols(b)) {
      if (__propIsEnum.call(b, prop))
        __defNormalProp(a, prop, b[prop]);
    }
  return a;
};

// assets/js/hooks/button.js
var NatureButton = {
  mounted() {
    this.handleClick = (e) => {
      if (!window.NatureUI.isInteractive()) {
        e.preventDefault();
        const fallback = this.el.dataset.fallback;
        if (fallback === "submit") {
          this.submitFallback();
        }
        if (fallback === "toggle") {
          this.toggleFallback();
        }
      }
    };
    this.el.addEventListener("click", this.handleClick);
  },
  destroyed() {
    this.el.removeEventListener("click", this.handleClick);
  }
};
var button_default = NatureButton;

// assets/js/hooks/input.js
var NatureInput = {
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

// assets/js/hooks/passwordToggle.js
var NatureUIPasswordToggle = {
  mounted() {
    const button = this.el;
    const inputId = button.dataset.inputId;
    const input = document.getElementById(inputId);
    if (!input) return;
    const eyeClosed = button.querySelector("[data-eye-closed]");
    const eyeOpen = button.querySelector("[data-eye-open]");
    const toggle = (event) => {
      event.preventDefault();
      const isPassword = input.type === "password";
      input.type = isPassword ? "text" : "password";
      if (eyeClosed && eyeOpen) {
        eyeClosed.classList.toggle("hidden", !isPassword);
        eyeOpen.classList.toggle("hidden", isPassword);
      }
    };
    button.addEventListener("click", toggle);
  }
};
var passwordToggle_default = NatureUIPasswordToggle;

// assets/js/index.js
var coreHooks = {
  NatureInput: input_default,
  NatureModal: modal_default,
  NatureButton: button_default,
  NatureUIPasswordToggle: passwordToggle_default
};
window.NatureUI = window.NatureUI || {};
var NatureUI = window.NatureUI(function() {
  NatureUI.state = {
    liveviewConnected: true,
    browserOnline: navigator.onLine
  };
})();
window.addEventListener("phx:disconnected", () => {
  console.info("[NatureUI] Liveview disconnected");
  NatureUI.state.liveviewConnected = false;
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  );
});
window.addEventListener("phx:reconnected", () => {
  console.info("[NatureUI] Liveview reconnected");
  NatureUI.state.liveviewConnected = true;
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  );
});
window.addEventListener("offline", () => {
  console.info("[NatureUI] Browser offline");
  NatureUI.state.browserOnline = false;
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  );
});
window.addEventListener("online", () => {
  console.info("[NatureUI] Browser online");
  NatureUI.state.browserOnline = true;
  window.dispatchEvent(
    new Event("natureui:connection_changed")
  );
});
NatureUI.isInteractive = function() {
  const state = NatureUI.state;
  return state.browserOnline && state.liveviewConnected;
};
NatureUI.actions = {};
NatureUI.registerAction = function(name, handler) {
  this.actions[name] = handler;
};
NatureUI.install = (liveSocket, opts = {}) => {
  const {
    hooks: appHooks = {}
  } = opts;
  const mergedHooks = __spreadValues(__spreadValues({}, coreHooks), appHooks);
  liveSocket.hooks = __spreadValues(__spreadValues({}, liveSocket.hooks), mergedHooks);
};
