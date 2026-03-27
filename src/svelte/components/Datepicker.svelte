<script>
  import { onMount } from "svelte";
  import { twMerge } from "tailwind-merge";

  export let el;

  let selectedDate = null;
  let showCalendar = false;
  let error = "";
  let message = "";
  let extraClasses = "";

  let today = new Date();
  let currentMonth = today.getMonth();
  let currentYear = today.getFullYear();

  onMount(() => {
    error = el.dataset.error || "";
    message = el.dataset.message || "";
    extraClasses = el.className;
  });

  $: mergedClasses = twMerge(
    `block w-full rounded-md border-gray-300 shadow-sm sm:text-sm transition
       ${
         error
           ? "border-red-500 focus:border-red-500 focus:ring-red-500"
           : "focus:border-green-500 focus:ring-green-500"
       }`,
    extraClasses,
  );

  function toggleCalendar() {
    showCalendar = !showCalendar;
  }

  function selectDate(day) {
    selectedDate = new Date(currentYear, currentMonth, day);
    el.value = selectedDate.toISOString().split("T")[0]; // sync with hidden input
    showCalendar = false;
  }

  function prevMonth() {
    if (currentMonth === 0) {
      currentMonth = 11;
      currentYear--;
    } else {
      currentMonth--;
    }
  }

  function nextMonth() {
    if (currentMonth === 11) {
      currentMonth = 0;
      currentYear++;
    } else {
      currentMonth++;
    }
  }

  function daysInMonth(year, month) {
    return new Date(year, month + 1, 0).getDate();
  }
</script>

<div class="space-y-1 relative">
  <!-- Input field -->
  <input
    type="text"
    readonly
    class={mergedClasses}
    value={selectedDate ? selectedDate.toDateString() : ""}
    on:click={toggleCalendar}
  />

  <!-- Calendar popup -->
  {#if showCalendar}
    <div
      class="absolute z-10 mt-1 bg-white border border-gray-200 rounded-md shadow-lg p-2"
    >
      <div class="flex justify-between items-center mb-2">
        <button on:click={prevMonth}>&lt;</button>
        <span class="font-semibold">
          {new Date(currentYear, currentMonth).toLocaleString("default", {
            month: "long",
          })}
          {currentYear}
        </span>
        <button on:click={nextMonth}>&gt;</button>
      </div>
      <div class="grid grid-cols-7 gap-1 text-center">
        {#each Array(daysInMonth(currentYear, currentMonth))
          .fill(0)
          .map((_, i) => i + 1) as day}
          <button
            class="px-2 py-1 hover:bg-green-100 rounded"
            on:click={() => selectDate(day)}
          >
            {day}
          </button>
        {/each}
      </div>
    </div>
  {/if}

  <!-- Error or helper message -->
  {#if message}
    <p class="text-sm mt-1 {error ? 'text-red-600' : 'text-gray-500'}">
      {message}
    </p>
  {/if}
</div>
