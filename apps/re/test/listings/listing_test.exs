defmodule Re.ListingTest do
  use Re.ModelCase

  alias Re.Listing

  import Re.Factory

  @valid_attrs %{
    type: "Apartamento",
    complement: "100",
    description: "some content",
    price: 1_000_000,
    property_tax: 500.00,
    maintenance_fee: 300.00,
    floor: "3",
    rooms: 4,
    bathrooms: 4,
    restrooms: 4,
    suites: 1,
    dependencies: 1,
    balconies: 1,
    has_elevator: true,
    area: 150,
    garage_spots: 2,
    garage_type: "contract",
    score: 4,
    matterport_code: "",
    is_exclusive: false,
    is_release: false,
    is_exportable: true
  }
  @invalid_attrs %{
    type: "ApartmentApartmentApartmentApartmentApartment",
    complement: "complementcomplementcomplementcomplement",
    price: -1,
    property_tax: -500.00,
    maintenance_fee: -300.00,
    bathrooms: -1,
    restrooms: -1,
    suites: -1,
    dependencies: -1,
    balconies: -1,
    garage_spots: -1,
    garage_type: "mine",
    score: 5,
    is_exclusive: "banana",
    is_release: "banana",
    is_exportable: "banana"
  }

  describe "user" do
    test "changeset with valid attributes" do
      address = insert(:address)
      user = insert(:user)

      attrs =
        @valid_attrs
        |> Map.put(:address_id, address.id)
        |> Map.put(:user_id, user.id)

      changeset = Listing.changeset(%Listing{}, attrs, "user")
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Listing.changeset(%Listing{}, @invalid_attrs, "user")
      refute changeset.valid?

      assert Keyword.get(changeset.errors, :type) ==
               {"should be one of: [Apartamento Casa Cobertura]", [validation: :inclusion]}

      assert Keyword.get(changeset.errors, :property_tax) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :maintenance_fee) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :bathrooms) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :restrooms) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :suites) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :dependencies) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :balconies) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :garage_spots) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :garage_type) ==
               {"should be one of: [contract condominium]", [validation: :inclusion]}

      assert Keyword.get(changeset.errors, :is_exclusive) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      assert Keyword.get(changeset.errors, :is_release) ==
               {"is invalid", [type: :boolean, validation: :cast]}
    end
  end

  describe "admin" do
    test "changeset with valid attributes" do
      address = insert(:address)
      user = insert(:user)

      attrs =
        @valid_attrs
        |> Map.put(:address_id, address.id)
        |> Map.put(:user_id, user.id)

      changeset = Listing.changeset(%Listing{}, attrs, "admin")
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Listing.changeset(%Listing{}, @invalid_attrs, "admin")
      refute changeset.valid?

      assert Keyword.get(changeset.errors, :type) ==
               {"should be one of: [Apartamento Casa Cobertura]", [validation: :inclusion]}

      assert Keyword.get(changeset.errors, :score) ==
               {"must be less than %{number}", [validation: :number, kind: :less_than, number: 5]}

      assert Keyword.get(changeset.errors, :price) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 250_000]}

      assert Keyword.get(changeset.errors, :property_tax) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :maintenance_fee) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :bathrooms) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :restrooms) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :suites) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :dependencies) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :balconies) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :garage_spots) ==
               {"must be greater than or equal to %{number}",
                [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

      assert Keyword.get(changeset.errors, :is_exclusive) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      assert Keyword.get(changeset.errors, :is_release) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      assert Keyword.get(changeset.errors, :is_exportable) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      changeset = Listing.changeset(%Listing{}, %{score: 0, price: 110_000_000}, "admin")
      refute changeset.valid?

      assert Keyword.get(changeset.errors, :score) ==
               {"must be greater than %{number}",
                [validation: :number, kind: :greater_than, number: 0]}

      assert Keyword.get(changeset.errors, :price) ==
               {"must be less than or equal to %{number}",
                [validation: :number, kind: :less_than_or_equal_to, number: 100_000_000]}
    end
  end

  describe "development_changeset/2" do
    @valid_development_attrs %{
      type: "Apartamento",
      description: "some content",
      has_elevator: true,
      matterport_code: "",
      is_exclusive: nil,
      is_release: nil
    }

    @invalid_development_attrs %{
      type: "invalid",
      description: "",
      has_elevator: "apple",
      is_exclusive: "apple",
      is_release: "apple"
    }

    test "is valid with required params" do
      address = insert(:address)
      user = insert(:user)
      development = insert(:development)

      attrs =
        @valid_development_attrs
        |> Map.put(:address_id, address.id)
        |> Map.put(:user_id, user.id)
        |> Map.put(:development_uuid, development.uuid)

      changeset = Listing.development_changeset(%Listing{}, attrs)
      assert changeset.valid?
    end

    test "is invalid without required attrs" do
      changeset = Listing.development_changeset(%Listing{}, @invalid_development_attrs)
      refute changeset.valid?

      assert Keyword.get(changeset.errors, :type) ==
               {"should be one of: [Apartamento Casa Cobertura]", [validation: :inclusion]}

      assert Keyword.get(changeset.errors, :description) ==
               {"can't be blank", [validation: :required]}

      assert Keyword.get(changeset.errors, :address_id) ==
               {"can't be blank", [validation: :required]}

      assert Keyword.get(changeset.errors, :user_id) ==
               {"can't be blank", [validation: :required]}

      assert Keyword.get(changeset.errors, :development_uuid) ==
               {"can't be blank", [validation: :required]}

      assert Keyword.get(changeset.errors, :has_elevator) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      assert Keyword.get(changeset.errors, :is_exclusive) ==
               {"is invalid", [type: :boolean, validation: :cast]}

      assert Keyword.get(changeset.errors, :is_release) ==
               {"is invalid", [type: :boolean, validation: :cast]}
    end
  end

  describe "price per area" do
    test "calculate when price and area set to proper value" do
      attrs = Map.merge(@valid_attrs, %{address_id: 1, user_id: 1})
      changeset = Listing.changeset(%Listing{}, attrs, "admin")

      assert changeset.valid?
      assert changeset.changes.price_per_area == @valid_attrs.price / @valid_attrs.area
    end

    test "set to nil when price or area are nil" do
      attrs = Map.merge(@valid_attrs, %{addres_id: 1, user_id: 1})

      nil_price_attrs = %{attrs | price: nil}

      changeset = Listing.changeset(%Listing{}, nil_price_attrs, "user")

      assert changeset.valid?
      refute Map.get(changeset.changes, :price_per_area)

      nil_area_attrs = %{attrs | area: nil}

      changeset = Listing.changeset(%Listing{}, nil_area_attrs, "admin")

      assert changeset.valid?
      refute Map.get(changeset.changes, :price_per_area)
    end

    test "set to nil when price or area are zero" do
      attrs = Map.merge(@valid_attrs, %{address_id: 1, user_id: 1})

      zero_price_attrs = %{attrs | price: 0}

      changeset = Listing.changeset(%Listing{}, zero_price_attrs, "user")

      assert changeset.valid?
      refute Map.get(changeset.changes, :price_per_area)

      zero_area_attrs = %{attrs | area: 0}

      changeset = Listing.changeset(%Listing{}, zero_area_attrs, "user")

      assert changeset.valid?
      refute Map.get(changeset.changes, :price_per_area)
    end
  end
end
