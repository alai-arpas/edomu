defmodule Edomu.Files.Utilita do
  # alias Edomu.Files.Utilita, as: UtilFiles

  @doc """
  Directory condivisa tra windows e linux
  """
  def windows_share, do: Application.get_env(:arpos, :windows_share)

  def leggi_file_as_html(file) do
    estensione =
      Path.extname(file)
      |> String.downcase()

    case estensione do
      ".md" ->
        Earmark.from_file!(file)

      ".html" ->
        File.read!(file)

      ".svg" ->
        File.read!(file)

      ".txt" ->
        File.read!(file)

      _ ->
        "<div>Estenzione #{estensione} non prevista.</div>"
    end
  end
end
