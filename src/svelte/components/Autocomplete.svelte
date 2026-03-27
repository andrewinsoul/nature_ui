<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el; // raw DOM <input type="text">

  let value = "";
  let error = "";
  let message = "";
  let extraClasses = "";
  let suggestions = [];
  let filtered = [];
  let showDropdown = false;
  let url = "";
  let param = "q";
  let debounceMs = 300;

  let debounceTimer;

  function handleInput(e) {
    value = e.target.value;
    if (url) {
      debouncedFetch();
    } else {
      filterSuggestions();
    }
  }

  function filterSuggestions() {
    if (!value) {
      filtered = [];
      showDropdown = false;
      return;
    }
    filtered = suggestions.filter((s) =>
      s.toLowerCase().includes(value.toLowerCase()),
    );
    showDropdown = filtered.length > 0;
  }

  function debouncedFetch() {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(fetchSuggestions, debounceMs);
  }

  async function fetchSuggestions() {
    if (!value) {
      filtered = [];
      showDropdown = false;
      return;
    }
    try {
        const res = await fetch(`${url}?${param}=${encodeURIComponent(value)}`);
      const data = await res.json();
      suggestions = Array.isArray(data) ? data : [];
      filtered = suggestions;
      showDropdown = filtered.length > 0;
    } catch (err) {
      console.error("Autocomplete fetch failed", err);
      filtered = [];
      showDropdown = false;
    }
  }

  function selectSuggestion(s) {
    value = s;
    showDropdown = false;
  }

  onMount(() => {
    value = el.value;
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;
    url = el.dataset.url || "";
    debounceMs = parseInt(el.dataset.debounce) || 300;
    param = el.dataset.param || "q";

    const raw = el.dataset.suggestions || "";
    suggestions = raw
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean);

    el.addEventListener("input", handleInput);
  });

  $: mergedClasses = twMerge(
    `block w-full rounded-md shadow-sm sm:text-sm transition
       ${
         error
           ? "border-red-500 focus:border-red-500 focus:ring-red-500"
           : "border-gray-300 focus:border-green-500 focus:ring-green-500"
       }`,
    extraClasses,
  );
</script>

<!-- Input field styled like LiveView -->
<input type="text" bind:value class={mergedClasses} />

<!-- Dropdown suggestions -->
{#if showDropdown}
  <ul
    class="absolute z-10 mt-1 w-full bg-white shadow-lg rounded-md border border-gray-200"
  >
    {#each filtered as s}
      <li>
        <button
          type="button"
          class="cursor-pointer px-3 py-2 hover:bg-green-50 hover:text-green-700"
          on:click={() => selectSuggestion(s)}
        >
          {s}
        </button>
      </li>
    {/each}
  </ul>
{/if}

<!-- Error or helper message -->
{#if message}
  <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
    {message}
  </p>
{/if}
