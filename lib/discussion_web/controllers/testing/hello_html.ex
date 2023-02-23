defmodule DiscussionWeb.HelloHTML do
  use DiscussionWeb, :html

  embed_templates "hello_html/*"

  attr :messenger, :string, required: true

  def greet(assigns) do
    ~H"""
    <h1>
      Hello from messenger: <%= @messenger %>
    </h1>
    """
  end

  #   def index(assigns) do
  #     ~H"""
  #     <section>
  #       <h1>Hello from Phoenix</h1>

  #       <div class="mt-6">
  #         <.link href={~p"/"}>back home</.link>
  #       </div>

  #       <div class="mt-6">
  #         <.link href={~p"/hello/#{:mica}"}>messenger route</.link>
  #       </div>
  #     </section>
  #     """
  #   end

  #   def show(assigns) do
  #     # I tried to change assigns to something else
  #     # ~H requires a variable named "assigns" to exist and be set to a map
  #     ~H"""
  #     <section>
  #       <%!-- special HEEx tags for executing Elixir expressions: <%= %> --%>
  #       <h1>
  #         Hello from messenger: <%= @messenger %>
  #       </h1>

  #       <div class="mt-6">
  #         <.link href={~p"/hello"}>back to hello</.link>
  #       </div>
  #     </section>
  #     """
  #   end
end
