defmodule NatureUI.Components.Input do
  alias NatureUi.Tw
  use Phoenix.Component

  @doc """
  Renders a text input with Tailwind defaults.
  - `error`: boolean (default: false) — when true, shows red border
  - `prefix_icon`: optional slot for an icon before the input
  - `suffix_icon`: optional slot for an icon after the input
  - `message`: optional helper or error message under the input
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (phx-change, phx-blur, name, value, etc.)
  """
  def text(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)
      |> assign_new(:prefix_icon, fn -> nil end)
      |> assign_new(:suffix_icon, fn -> nil end)

    assigns =
      assign(
        assigns,
        :input_base_class,
        "block w-full rounded-md shadow-sm sm:text-sm transition"
      )

    input_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "border-gray-300 focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :input_error_class,
        input_error_class
      )

    input_prefix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :input_prefix_class,
        input_prefix_class
      )

    input_suffix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :input_suffix_class,
        input_suffix_class
      )

    ~H"""
    <div class="space-y-1">
      <div class="relative flex items-center">
        <%= if @prefix_icon do %>
          <span class="absolute left-2 text-gray-400">
            <%= render_slot(@prefix_icon) %>
          </span>
        <% end %>

        <input
          type="text"
          data-nature-ui="text"
          class={Tw.merge("#{@input_base_class} #{@input_error_class} #{@input_prefix_class} #{@input_suffix_class} #{@class}")}
          {@rest}
        />

        <%= if @suffix_icon do %>
          <span class="absolute right-2 text-gray-400">
            <%= render_slot(@suffix_icon) %>
          </span>
        <% end %>
      </div>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a textarea with Tailwind defaults.
  - `error`: boolean (default: false) — when true, shows red border
  - `prefix_icon`: optional slot for an icon before the textarea
  - `suffix_icon`: optional slot for an icon after the textarea
  - `message`: optional helper or error message under the textarea
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (name, rows, cols, phx-change, etc.)
  """
  def textarea(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)

    assigns =
      assign(
        assigns,
        :textarea_base_class,
        "block w-full rounded-md shadow-sm sm:text-sm transition"
      )

    textarea_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "border-gray-300 focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :textarea_error_class,
        textarea_error_class
      )

    textarea_prefix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :textarea_prefix_class,
        textarea_prefix_class
      )

    textarea_suffix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :textarea_suffix_class,
        textarea_suffix_class
      )

    ~H"""
    <div class="space-y-1">
      <div class="relative flex items-start">
        <%= if @prefix_icon do %>
          <span class="absolute left-2 top-2 text-gray-400">
            <%= render_slot(@prefix_icon) %>
          </span>
        <% end %>

        <textarea
          data-nature-ui="textarea"
          class={Tw.merge("#{@textarea_base_class} #{@textarea_error_class} #{@textarea_prefix_class} #{@textarea_suffix_class} #{@class}")}
          {@rest}
        ><%= render_slot(@inner_block) %></textarea>

        <%= if @suffix_icon do %>
          <span class="absolute right-2 top-2 text-gray-400">
            <%= render_slot(@suffix_icon) %>
          </span>
        <% end %>
      </div>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a select dropdown with Tailwind defaults.
  - `error`: boolean (default: false)
  - `prefix_icon`: optional slot for an icon before the select
  - `suffix_icon`: optional slot for an icon after the select
  - `message`: optional helper or error message under the select
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (name, phx-change, etc.)
  - `options`: slot for <.option> tags only
  """
  slot(:options)

  def select(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)

    assigns =
      assign(
        assigns,
        :select_base_class,
        "block w-full rounded-md shadow-sm sm:text-sm transition"
      )

    select_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "border-gray-300 focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :select_error_class,
        select_error_class
      )

    select_prefix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :select_prefix_class,
        select_prefix_class
      )

    select_suffix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :select_suffix_class,
        select_suffix_class
      )

    ~H"""
    <div class="space-y-1">
      <div class="relative flex items-center">
        <%= if @prefix_icon do %>
          <span class="absolute left-2 text-gray-400">
            <%= render_slot(@prefix_icon) %>
          </span>
        <% end %>

        <select
          data-nature-ui="select"
          class={Tw.merge("#{@select_base_class} #{@select_error_class} #{@select_prefix_class} #{@select_suffix_class} #{@class}")}
          {@rest}
        >
          <%= render_slot(@options) %>
        </select>

        <%= if @suffix_icon do %>
          <span class="absolute right-2 text-gray-400">
            <%= render_slot(@suffix_icon) %>
          </span>
        <% end %>
      </div>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Helper for rendering an <option> tag inside <.select>.
  - `value`: the option value
  - `class`: custom Tailwind classes to override or extend defaults
  - `inner_block`: the visible label
  """
  def option(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)

    assigns =
      assign(
        assigns,
        :option_base_class,
        "px-2 py-1 text-sm text-gray-700 hover:bg-gray-100"
      )

    ~H"""
    <option
      value={@value}
      class={Tw.merge("#{@option_base_class} #{@class}")}
    >
      <%= render_slot(@inner_block) %>
    </option>
    """
  end

  @doc """
  Renders a checkbox with Tailwind defaults.
  - `error`: boolean (default: false) — when true, shows red border
  - `message`: optional helper or error message under the checkbox
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (name, phx-change, checked, etc.)
  - `label`: slot for descriptive text or icon next to the checkbox
  """
  slot(:label)

  def checkbox(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)

    assigns =
      assign(
        assigns,
        :checkbox_base_class,
        "rounded border-gray-300 text-green-600 focus:ring-green-500 transition"
      )

    checkbox_error_class =
      if assigns[:error] do
        "border-red-500 focus:ring-red-500"
      else
        ""
      end

    assigns = assign(assigns, :checkbox_error_class, checkbox_error_class)

    ~H"""
    <div class="space-y-1">
      <label class="flex items-center gap-2">
        <input
          type="checkbox"
          data-nature-ui="checkbox"
          class={Tw.merge("#{@checkbox_base_class} #{@checkbox_error_class} #{@class}")}
          {@rest}
        />
        <%= render_slot(@label) %>
      </label>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a radio button with Tailwind defaults.
  - `error`: boolean (default: false) — when true, shows red border
  - `message`: optional helper or error message under the radio
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (name, value, phx-change, checked, etc.)
  - `label`: slot for descriptive text or icon next to the radio
  """
  slot(:label)

  def radio(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)

    assigns =
      assign(
        assigns,
        :radio_base_class,
        "h-4 w-4 rounded-full border-gray-300 text-green-600 focus:ring-green-500 transition"
      )

    radio_error_class =
      if assigns[:error] do
        "border-red-500 focus:ring-red-500"
      else
        ""
      end

    assigns = assign(assigns, :radio_error_class, radio_error_class)

    ~H"""
    <div class="space-y-1">
      <label class="flex items-center gap-2">
        <input
          type="radio"
          data-nature-ui="radio"
          class={Tw.merge("#{@radio_base_class} #{@radio_error_class} #{@class}")}
          {@rest}
        />
        <%= render_slot(@label) %>
      </label>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Autocomplete input.

  Flavours:
  - Static options: pass `options` as either:
    • list of strings (value = label)
    • list of maps with `:value` and `:label`
  - API-driven: pass `fetch_url` (string endpoint).

  Props:
  - `error`: boolean (default: false)
  - `client`: boolean (default: false)
  - `message`: optional helper or error message
  - `class`: Tailwind classes to override defaults
  - `options`: list of strings or maps
  - `fetch_url`: API endpoint for dynamic options
  - `rest`: other attributes (name, phx-change, etc.)
  """
  def autocomplete(assigns) do
    assigns =
      assigns
      |> assign_new(:client, fn -> false end)
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)
      |> assign_new(:options, fn -> [] end)
      |> assign_new(:fetch_url, fn -> nil end)
      |> assign_new(:param, fn -> "q" end)
      |> assign_new(:debounce, fn -> 300 end)

    assigns =
      assign(
        assigns,
        :autocomplete_base_class,
        "block w-full rounded-md border-gray-300 shadow-sm sm:text-sm transition"
      )

    autocomplete_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :autocomplete_error_class,
        autocomplete_error_class
      )

    autocomplete_prefix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :autocomplete_prefix_class,
        autocomplete_prefix_class
      )

    autocomplete_suffix_class =
      if assigns[:prefix_icon] do
        "pl-8"
      else
        ""
      end

    assigns =
      assign(
        assigns,
        :autocomplete_suffix_class,
        autocomplete_suffix_class
      )

    ~H"""
    <div class="space-y-1">
      <div class="relative">
        <input
          type="text"
          data-nature-ui={
            cond do
              @client -> "autocomplete-client"
              true -> "autocomplete"
            end
          }
          data-fetch-url={@fetch_url}
          data-param={@param}
          phx-debounce={@debounce}
          class={Tw.merge("#{@autocomplete_base_class} #{@autocomplete_error_class} #{@autocomplete_prefix_class} #{@autocomplete_suffix_class} #{@class}")}
          {@rest}
        />

        <!-- Static options dropdown -->
        <%= if Enum.any?(@options) do %>
          <ul class="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-md shadow-lg max-h-60 overflow-auto">
            <%= for opt <- @options do %>
              <% normalized =
                if is_map(opt),
                  do: %{value: opt.value, label: opt.label},
                  else: %{value: opt, label: opt} %>

              <li
                class="px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 cursor-pointer"
                phx-click="select-option"
                phx-value={normalized.value}
              >
                <%= normalized.label %>
              </li>
            <% end %>
          </ul>
        <% end %>
      </div>

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a datepicker input.

  Props:
  - `error`: boolean (default: false)
  - `client`: boolean (default: false)
  - `message`: optional helper or error message
  - `class`: Tailwind classes to override defaults
  - `rest`: other attributes (name, phx-change, etc.)
  """
  def datepicker(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> false end)
      |> assign_new(:client, fn -> false end)
      |> assign_new(:client, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)

    assigns =
      assign(
        assigns,
        :datepicker_base_class,
        "block w-full rounded-md border-gray-300 shadow-sm sm:text-sm transition"
      )

    datepicker_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :datepicker_error_class,
        datepicker_error_class
      )

    ~H"""
    <div class="space-y-1">
      <input
        type="date"
        data-nature-ui={
          cond do
            @client -> "datepicker-client"
            true -> "datepicker"
          end
        }
        class={Tw.merge("#{@datepicker_base_class} #{@datepicker_error_class} #{@class}")}
        {@rest}
      />

      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a file upload input.

  Props:
  - `multiple`: true | false (default: false) — allow multiple file uploads
  - `accept`: string (optional) — restrict file types (e.g. "image/*", ".pdf")
  - `error`: boolean (default: false)
  - `message`: optional helper or error message
  - `class`: Tailwind classes to override defaults
  - `rest`: other attributes (name, phx-change, etc.)
  """
  def file_upload(assigns) do
    assigns =
      assigns
      |> assign_new(:multiple, fn -> false end)
      |> assign_new(:accept, fn -> nil end)
      |> assign_new(:error, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:message, fn -> nil end)
      |> assign_new(:filenames, fn -> [] end)

    assigns =
      assign(
        assigns,
        :fileupload_base_class,
        "block w-full text-sm text-gray-700 file:mr-4 file:py-2 file:px-4
           file:rounded-md file:border-0 file:text-sm file:font-semibold
           file:bg-green-50 file:text-green-700 hover:file:bg-green-100"
      )

    fileupload_error_class =
      if assigns[:error] do
        "border-red-500 focus:border-red-500 focus:ring-red-500"
      else
        "border-gray-300 focus:border-green-500 focus:ring-green-500"
      end

    assigns =
      assign(
        assigns,
        :fileupload_error_class,
        fileupload_error_class
      )

    ~H"""
    <div class="space-y-1">
      <input
        type="file"
        data-nature-ui="file-upload"
        multiple={@multiple}
        accept={@accept}
       phx-change="files_selected"
        class={Tw.merge("#{@fileupload_base_class} #{@fileupload_error_class} #{@class}")}
        {@rest}
      />

      <!-- Error or helper message -->
      <%= if @message do %>
        <p class={[
          "text-sm mt-1",
          if(@error, do: "text-red-600", else: "text-gray-500")
        ]}>
          <%= @message %>
        </p>
      <% end %>

      <%= if Enum.any?(@filenames) do %>
        <ul class="mt-2 text-sm text-gray-600">
          <%= for name <- @filenames do %>
            <li><%= name %></li>
          <% end %>
        </ul>
      <% end %>
    </div>
    """
  end
end
