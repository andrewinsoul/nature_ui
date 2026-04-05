defmodule NatureUI.Theme do
  @moduledoc false

  @sizes %{
    sm: %{
      input: "text-sm py-1 px-2",
      icon: "text-sm",
      modal: "w-[300px]"
    },
    md: %{
      input: "text-base py-2 px-3",
      modal: "w-[400px]",
      icon: "text-base"
    },
    lg: %{
      input: "text-lg py-3 px-4",
      modal: "w-[600px]",
      icon: "text-lg"
    }
  }

  @variants %{
    default: "border-gray-300 focus-within:border-blue-500",
    error: "border-red-500 focus-within:border-red-500",
    success: "border-green-500 focus-within:border-green-500",
    disabled: "bg-gray-100 cursor-not-allowed opacity-70"
  }

  @modal %{
    container: "bg-white rounded-lg shadow-lg overflow-hidden",
    header: "px-4 py-3 border-b flex justify-between items-center",
    body: "p-4",
    footer: "px-4 py-3 border-t flex justify-end gap-2",
    overlay: "fixed inset-0 bg-black/50",
    wrapper: "fixed inset-0 flex items-center justify-center"
  }

  def size(component, size), do: @sizes[size][component]

  def variant(name), do: @variants[name]

  def modal(key), do: @modal[key]
end
