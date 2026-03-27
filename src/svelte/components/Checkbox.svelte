<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el;

  let checked = false;
  let error = "";
  let message = "";
  let extraClasses = "";

  function handleChange(e) {
    checked = e.target.checked;
  }

  onMount(() => {
    checked = el.checked;
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;

    el.addEventListener("change", handleChange);
  });

  $: mergedClasses = twMerge(
    `h-4 w-4 text-green-600 border-gray-300 rounded focus:ring-green-500 ${
      error ? "border-red-500 focus:ring-red-500" : ""
    }`,
    extraClasses,
  );
</script>

<input type="checkbox" bind:checked class={mergedClasses} />

{#if message}
  <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
    {message}
  </p>
{/if}
