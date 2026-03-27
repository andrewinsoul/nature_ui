// import the svelte files
import TextInput from "./svelte/components/TextInput.svelte"
import Select from "./svelte/components/Select.svelte"
import Radiobutton from "./svelte/components/RadioButton.svelte"
import Autocomplete from "./svelte/components/Autocomplete.svelte"
import Datepicker from "./svelte/components/Datepicker.svelte"
import Checkbox from "./svelte/components/Checkbox.svelte"
import Fileupload from "./svelte/components/FileUpload.svelte"
import Textarea from "./svelte/components/Textarea.svelte"


function mount(Component, el) {
    new Component({
        target: el.parentNode,
        props: { el }
    })
}

document.querySelectorAll("[data-nature-ui]").forEach(el => {
    const type = el.dataset.natureUi;

    if (navigator.onLine) {
        console.log(`Liveview active for: ${type}`);
    } else {
        switch (type) {
            case "text":
                mount(TextInput, el)
                break;
            case "file-upload":
                mount(Fileupload, el)
                break
            case "select":
                mount(Select, el)
                break;
            case "radio":
                mount(Radiobutton, el)
                break
            case "checkbox":
                mount(Checkbox, el)
                break
            case "textarea":
                mount(Textarea, el);
                break;
            case "autocomplete":
            case "autocomplete-client":
                mount(Autocomplete, el)
                break
            case "datepicker":
            case "datepicker-client":
                mount(Datepicker, el)
                break
            default:
                console.warn(`No offline Svelte component for: ${type}`)
        }
    }
})