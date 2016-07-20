defmodule Typi.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Typi.{Repo, User}

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Repo.get(User, String.to_integer(id)) |> Repo.preload(:account) }
  def from_token(_), do: { :error, "Unknown resource type" }
end