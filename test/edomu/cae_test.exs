defmodule Edomu.CaeTest do
  use Edomu.DataCase

  alias Edomu.Cae

  describe "csv_files" do
    alias Edomu.Cae.CsvRow

    import Edomu.CaeFixtures

    @invalid_attrs %{anno_mese: nil, nome: nil, sensore: nil}

    test "list_csv_files/0 returns all csv_files" do
      csv_row = csv_row_fixture()
      assert Cae.list_csv_files() == [csv_row]
    end

    test "get_csv_row!/1 returns the csv_row with given id" do
      csv_row = csv_row_fixture()
      assert Cae.get_csv_row!(csv_row.id) == csv_row
    end

    test "create_csv_row/1 with valid data creates a csv_row" do
      valid_attrs = %{anno_mese: "some anno_mese", nome: "some nome", sensore: 42}

      assert {:ok, %CsvRow{} = csv_row} = Cae.create_csv_row(valid_attrs)
      assert csv_row.anno_mese == "some anno_mese"
      assert csv_row.nome == "some nome"
      assert csv_row.sensore == 42
    end

    test "create_csv_row/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cae.create_csv_row(@invalid_attrs)
    end

    test "update_csv_row/2 with valid data updates the csv_row" do
      csv_row = csv_row_fixture()
      update_attrs = %{anno_mese: "some updated anno_mese", nome: "some updated nome", sensore: 43}

      assert {:ok, %CsvRow{} = csv_row} = Cae.update_csv_row(csv_row, update_attrs)
      assert csv_row.anno_mese == "some updated anno_mese"
      assert csv_row.nome == "some updated nome"
      assert csv_row.sensore == 43
    end

    test "update_csv_row/2 with invalid data returns error changeset" do
      csv_row = csv_row_fixture()
      assert {:error, %Ecto.Changeset{}} = Cae.update_csv_row(csv_row, @invalid_attrs)
      assert csv_row == Cae.get_csv_row!(csv_row.id)
    end

    test "delete_csv_row/1 deletes the csv_row" do
      csv_row = csv_row_fixture()
      assert {:ok, %CsvRow{}} = Cae.delete_csv_row(csv_row)
      assert_raise Ecto.NoResultsError, fn -> Cae.get_csv_row!(csv_row.id) end
    end

    test "change_csv_row/1 returns a csv_row changeset" do
      csv_row = csv_row_fixture()
      assert %Ecto.Changeset{} = Cae.change_csv_row(csv_row)
    end
  end

  describe "cae_ss_grand" do
    alias Edomu.Cae.CaeSsGrand

    import Edomu.CaeFixtures

    @invalid_attrs %{grand: nil, nome: nil, sensore: nil, stazione: nil, usa: nil}

    test "list_cae_ss_grand/0 returns all cae_ss_grand" do
      cae_ss_grand = cae_ss_grand_fixture()
      assert Cae.list_cae_ss_grand() == [cae_ss_grand]
    end

    test "get_cae_ss_grand!/1 returns the cae_ss_grand with given id" do
      cae_ss_grand = cae_ss_grand_fixture()
      assert Cae.get_cae_ss_grand!(cae_ss_grand.id) == cae_ss_grand
    end

    test "create_cae_ss_grand/1 with valid data creates a cae_ss_grand" do
      valid_attrs = %{grand: "some grand", nome: "some nome", sensore: 42, stazione: 42, usa: true}

      assert {:ok, %CaeSsGrand{} = cae_ss_grand} = Cae.create_cae_ss_grand(valid_attrs)
      assert cae_ss_grand.grand == "some grand"
      assert cae_ss_grand.nome == "some nome"
      assert cae_ss_grand.sensore == 42
      assert cae_ss_grand.stazione == 42
      assert cae_ss_grand.usa == true
    end

    test "create_cae_ss_grand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cae.create_cae_ss_grand(@invalid_attrs)
    end

    test "update_cae_ss_grand/2 with valid data updates the cae_ss_grand" do
      cae_ss_grand = cae_ss_grand_fixture()
      update_attrs = %{grand: "some updated grand", nome: "some updated nome", sensore: 43, stazione: 43, usa: false}

      assert {:ok, %CaeSsGrand{} = cae_ss_grand} = Cae.update_cae_ss_grand(cae_ss_grand, update_attrs)
      assert cae_ss_grand.grand == "some updated grand"
      assert cae_ss_grand.nome == "some updated nome"
      assert cae_ss_grand.sensore == 43
      assert cae_ss_grand.stazione == 43
      assert cae_ss_grand.usa == false
    end

    test "update_cae_ss_grand/2 with invalid data returns error changeset" do
      cae_ss_grand = cae_ss_grand_fixture()
      assert {:error, %Ecto.Changeset{}} = Cae.update_cae_ss_grand(cae_ss_grand, @invalid_attrs)
      assert cae_ss_grand == Cae.get_cae_ss_grand!(cae_ss_grand.id)
    end

    test "delete_cae_ss_grand/1 deletes the cae_ss_grand" do
      cae_ss_grand = cae_ss_grand_fixture()
      assert {:ok, %CaeSsGrand{}} = Cae.delete_cae_ss_grand(cae_ss_grand)
      assert_raise Ecto.NoResultsError, fn -> Cae.get_cae_ss_grand!(cae_ss_grand.id) end
    end

    test "change_cae_ss_grand/1 returns a cae_ss_grand changeset" do
      cae_ss_grand = cae_ss_grand_fixture()
      assert %Ecto.Changeset{} = Cae.change_cae_ss_grand(cae_ss_grand)
    end
  end
end
