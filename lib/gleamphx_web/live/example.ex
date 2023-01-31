defmodule GleamphxWeb.Live.Example do
  use GleamphxWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <div id="ExampleGleamHook" phx-hook="Hello">Example Hooked Component</div>
    """
  end
end
