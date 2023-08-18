defmodule Edomu.WebLinkTest do
  use Edomu.DataCase

  alias Edomu.WebLink

  describe "wlinks" do
    alias Edomu.WebLink.Wlink

    import Edomu.WebLinkFixtures

    @invalid_attrs %{descrizione: nil, intranet: nil, url: nil}

    test "list_wlinks/0 returns all wlinks" do
      wlink = wlink_fixture()
      assert WebLink.list_wlinks() == [wlink]
    end

    test "get_wlink!/1 returns the wlink with given id" do
      wlink = wlink_fixture()
      assert WebLink.get_wlink!(wlink.id) == wlink
    end

    test "create_wlink/1 with valid data creates a wlink" do
      valid_attrs = %{descrizione: "some descrizione", intranet: true, url: "some url"}

      assert {:ok, %Wlink{} = wlink} = WebLink.create_wlink(valid_attrs)
      assert wlink.descrizione == "some descrizione"
      assert wlink.intranet == true
      assert wlink.url == "some url"
    end

    test "create_wlink/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WebLink.create_wlink(@invalid_attrs)
    end

    test "update_wlink/2 with valid data updates the wlink" do
      wlink = wlink_fixture()
      update_attrs = %{descrizione: "some updated descrizione", intranet: false, url: "some updated url"}

      assert {:ok, %Wlink{} = wlink} = WebLink.update_wlink(wlink, update_attrs)
      assert wlink.descrizione == "some updated descrizione"
      assert wlink.intranet == false
      assert wlink.url == "some updated url"
    end

    test "update_wlink/2 with invalid data returns error changeset" do
      wlink = wlink_fixture()
      assert {:error, %Ecto.Changeset{}} = WebLink.update_wlink(wlink, @invalid_attrs)
      assert wlink == WebLink.get_wlink!(wlink.id)
    end

    test "delete_wlink/1 deletes the wlink" do
      wlink = wlink_fixture()
      assert {:ok, %Wlink{}} = WebLink.delete_wlink(wlink)
      assert_raise Ecto.NoResultsError, fn -> WebLink.get_wlink!(wlink.id) end
    end

    test "change_wlink/1 returns a wlink changeset" do
      wlink = wlink_fixture()
      assert %Ecto.Changeset{} = WebLink.change_wlink(wlink)
    end
  end
end
