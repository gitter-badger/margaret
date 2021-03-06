defmodule Margaret.Stars do
  @moduledoc """
  The Stars context.
  """

  import Ecto.Query
  alias Margaret.Repo

  alias Margaret.Stars.Star

  @doc """
  Gets a star.
  """
  def get_star(%{user_id: user_id, story_id: story_id}) do
    Repo.get_by(Star, user_id: user_id, story_id: story_id)
  end

  def get_star(%{user_id: user_id, comment_id: comment_id}) do
    Repo.get_by(Star, user_id: user_id, comment_id: comment_id)
  end

  def has_starred(args), do: !!get_star(args)

  @doc """
  Inserts a star.
  """
  def insert_star(attrs) do
    %Star{}
    |> Star.changeset(attrs)
    |> Repo.insert()
  end

  def delete_star(id) when not is_list(id), do: Repo.delete(%Star{id: id})

  def delete_star(args) do
    case get_star(args) do
      %Star{id: id} -> delete_star(id)
      nil -> nil
    end
  end

  def delete_star(args) do
    case get_star(args) do
      %Star{id: id} -> delete_star(id)
      nil -> nil
    end
  end

  def get_star_count(%{story_id: story_id}) do
    query = from s in Star,
      join: u in User, on: u.id == s.user_id,
      where: s.story_id == ^story_id,
      where: u.is_active == true,
      select: count(s.id)

    Repo.one!(query)
  end

  def get_star_count(%{comment_id: comment_id}) do
    query = from s in Star,
      join: u in User, on: u.id == s.user_id,
      where: s.comment_id == ^comment_id,
      where: u.is_active == true,
      select: count(s.id)

    Repo.one!(query)
  end

  def get_starred_count(user_id) do
    Repo.one!(from s in Star, where: s.user_id == ^user_id, select: count(s.id))
  end
end
