let NatureInput = {
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

        // Required
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
        this.errorEl.innerHTML =
            `<p class="text-red-600 text-xs">${message}</p>`;
    },

    clearError() {
        this.errorEl.classList.add("hidden");
        this.errorEl.innerHTML = "";
    }
};

export default NatureInput;