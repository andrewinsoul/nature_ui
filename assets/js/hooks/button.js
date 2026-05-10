let NatureButton = {
    mounted() {
        this.handleClick = (e) => {
            if (!window.NatureUI.isInteractive()) {
                e.preventDefault()

                const fallback = this.el.dataset.fallback

                if (fallback === "submit") {
                    this.submitFallback()
                }

                if (fallback === "toggle") {
                    this.toggleFallback()
                }
            }
        }

        this.el.addEventListener("click", this.handleClick)
    },

    destroyed() {
        this.el.removeEventListener("click", this.handleClick)
    }
}

export default NatureButton