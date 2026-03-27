<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el;

  let files = [];
  let error = "";
  let message = "";
  let extraClasses = "";

  function handleChange(e) {
    files = Array.from(e.target.files);
  }

  onMount(() => {
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;

    el.addEventListener("change", handleChange);
  });

  $: mergedClasses = twMerge(
    `block w-full rounded-md shadow-sm sm:text-sm transition
       file:mr-4 file:py-2 file:px-4
       file:rounded-md file:border-0
       file:text-sm file:font-semibold
       file:bg-green-50 file:text-green-700
       hover:file:bg-green-100
       ${
         error
           ? "border-red-500 focus:border-red-500 focus:ring-red-500"
           : "border-gray-300 focus:border-green-500 focus:ring-green-500"
       }`,
    extraClasses,
  );
</script>


<input type="file" class={mergedClasses} multiple={el.multiple} />

{#if files.length > 0}
  <ul class="mt-2 text-sm text-gray-600">
    {#each files as f}
      <li>{f.name}</li>
    {/each}
  </ul>
{/if}

{#if message}
  <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
    {message}
  </p>
{/if}
