let NatureModal = {
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

export default NatureModal;