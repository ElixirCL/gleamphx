defmodule GleamphxWeb.Live.Video do
  use GleamphxWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <div id="ExampleVideoGleamHook" phx-hook="Video">Example Video Hooked Component</div>
    """
  end
end
