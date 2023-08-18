defmodule Edomu.WebLinkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.WebLink` context.
  """

  @doc """
  Generate a wlink.
  """
  def wlink_fixture(attrs \\ %{}) do
    {:ok, wlink} =
      attrs
      |> Enum.into(%{
        descrizione: "some descrizione",
        intranet: true,
        url: "some url"
      })
      |> Edomu.WebLink.create_wlink()

    wlink
  end
end
