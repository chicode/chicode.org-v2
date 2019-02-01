defmodule ChicodeWeb.ErrorView do
  use ChicodeWeb, :view

  def render("404.html", assigns) do
    render("error.html", Map.merge(assigns, %{type: 404}))
  end

  def render("500.html", assigns) do
    render("error.html", Map.merge(assigns, %{type: 500}))
  end

  def render(_name, assigns) do
    render("error.html", Map.merge(assigns, %{type: :other}))
  end
end
