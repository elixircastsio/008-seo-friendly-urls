defmodule Teacher.Post do
  use Teacher.Web, :model

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :title, :string
    field :body, :string
    field :slug, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    params = Map.merge(params, slug_map(params))

    struct
    |> cast(params, [:title, :body, :slug])
    |> validate_required([:title, :body])
  end

  defp slug_map(%{"title" => title}) do
    slug = String.downcase(title) |> String.replace(" ", "-")
    %{"slug" => slug}
  end
  defp slug_map(_params) do
    %{}
  end
end
