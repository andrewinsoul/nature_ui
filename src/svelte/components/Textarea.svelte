<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el;

  let value = "";
  let error = "";
  let message = "";
  let extraClasses = "";

  function handleInput(e) {
    value = e.target.value;
  }

  onMount(() => {
    value = el.value;
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;

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


<textarea bind:value class={mergedClasses}></textarea>


{#if message}
  <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
    {message}
  </p>
{/if}
