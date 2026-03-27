<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el;

  let value = "";
  let error = "";
  let message = "";
  let extraClasses = "";

  function handleChange(e) {
    value = e.target.value;
  }

  onMount(() => {
    value = el.value;
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;
    el.addEventListener("change", handleChange);
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

  const optionClasses = "text-gray-900 bg-white hover:bg-gray-100";
</script>

<select bind:value class={mergedClasses}>
  {#each Array.from(el.options) as opt}
    <option value={opt.value} selected={opt.selected} class={optionClasses}>
      {opt.text}
    </option>
  {/each}
</select>

{#if message}
  <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
    {message}
  </p>
{/if}
