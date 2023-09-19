defmodule Edomu.HisPtiAgolTest do
  use Edomu.DataCase

  alias Edomu.HisPtiAgol

  describe "hcsv_rows" do
    alias Edomu.HisPtiAgol.Hcsv_row

    import Edomu.HisPtiAgolFixtures

    @invalid_attrs %{carica_in_agol: nil, carica_in_table: nil, csv_item_id: nil, in_agol: nil, in_table: nil, nome: nil, ordine: nil, pti: nil, rows_singolo: nil, rows_totale: nil, rows_totale_check: nil}

    test "list_hcsv_rows/0 returns all hcsv_rows" do
      hcsv_row = hcsv_row_fixture()
      assert HisPtiAgol.list_hcsv_rows() == [hcsv_row]
    end

    test "get_hcsv_row!/1 returns the hcsv_row with given id" do
      hcsv_row = hcsv_row_fixture()
      assert HisPtiAgol.get_hcsv_row!(hcsv_row.id) == hcsv_row
    end

    test "create_hcsv_row/1 with valid data creates a hcsv_row" do
      valid_attrs = %{carica_in_agol: true, carica_in_table: true, csv_item_id: "some csv_item_id", in_agol: true, in_table: true, nome: "some nome", ordine: 42, pti: "some pti", rows_singolo: 42, rows_totale: 42, rows_totale_check: 42}

      assert {:ok, %Hcsv_row{} = hcsv_row} = HisPtiAgol.create_hcsv_row(valid_attrs)
      assert hcsv_row.carica_in_agol == true
      assert hcsv_row.carica_in_table == true
      assert hcsv_row.csv_item_id == "some csv_item_id"
      assert hcsv_row.in_agol == true
      assert hcsv_row.in_table == true
      assert hcsv_row.nome == "some nome"
      assert hcsv_row.ordine == 42
      assert hcsv_row.pti == "some pti"
      assert hcsv_row.rows_singolo == 42
      assert hcsv_row.rows_totale == 42
      assert hcsv_row.rows_totale_check == 42
    end

    test "create_hcsv_row/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HisPtiAgol.create_hcsv_row(@invalid_attrs)
    end

    test "update_hcsv_row/2 with valid data updates the hcsv_row" do
      hcsv_row = hcsv_row_fixture()
      update_attrs = %{carica_in_agol: false, carica_in_table: false, csv_item_id: "some updated csv_item_id", in_agol: false, in_table: false, nome: "some updated nome", ordine: 43, pti: "some updated pti", rows_singolo: 43, rows_totale: 43, rows_totale_check: 43}

      assert {:ok, %Hcsv_row{} = hcsv_row} = HisPtiAgol.update_hcsv_row(hcsv_row, update_attrs)
      assert hcsv_row.carica_in_agol == false
      assert hcsv_row.carica_in_table == false
      assert hcsv_row.csv_item_id == "some updated csv_item_id"
      assert hcsv_row.in_agol == false
      assert hcsv_row.in_table == false
      assert hcsv_row.nome == "some updated nome"
      assert hcsv_row.ordine == 43
      assert hcsv_row.pti == "some updated pti"
      assert hcsv_row.rows_singolo == 43
      assert hcsv_row.rows_totale == 43
      assert hcsv_row.rows_totale_check == 43
    end

    test "update_hcsv_row/2 with invalid data returns error changeset" do
      hcsv_row = hcsv_row_fixture()
      assert {:error, %Ecto.Changeset{}} = HisPtiAgol.update_hcsv_row(hcsv_row, @invalid_attrs)
      assert hcsv_row == HisPtiAgol.get_hcsv_row!(hcsv_row.id)
    end

    test "delete_hcsv_row/1 deletes the hcsv_row" do
      hcsv_row = hcsv_row_fixture()
      assert {:ok, %Hcsv_row{}} = HisPtiAgol.delete_hcsv_row(hcsv_row)
      assert_raise Ecto.NoResultsError, fn -> HisPtiAgol.get_hcsv_row!(hcsv_row.id) end
    end

    test "change_hcsv_row/1 returns a hcsv_row changeset" do
      hcsv_row = hcsv_row_fixture()
      assert %Ecto.Changeset{} = HisPtiAgol.change_hcsv_row(hcsv_row)
    end
  end
end
