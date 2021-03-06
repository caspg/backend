defmodule Re.OwnerContactsTest do
  use Re.ModelCase

  alias Re.{
    OwnerContact,
    OwnerContacts
  }

  import Re.Factory

  describe "all/0" do
    test "get all owners contacts available" do
      %{uuid: uuid_1} = insert(:owner_contact)
      %{uuid: uuid_2} = insert(:owner_contact)

      result = Enum.map(OwnerContacts.all(), & &1.uuid)

      assert Enum.member?(result, uuid_1)
      assert Enum.member?(result, uuid_2)
    end
  end

  describe "get/1" do
    test "get existing owner contact by uuid" do
      owner_contact = insert(:owner_contact)

      assert {:ok, fetched_owner_contact} = OwnerContacts.get(owner_contact.uuid)

      assert owner_contact == fetched_owner_contact
    end

    test "error when contact owner doesn't exist" do
      insert(:owner_contact)

      inexistent_uuid = UUID.uuid4()

      assert {:error, :not_found} = OwnerContacts.get(inexistent_uuid)
    end
  end

  describe "get_by_phone/1" do
    test "get existing owner contact by phone" do
      owner_contact = insert(:owner_contact)

      assert {:ok, fetched_owner_contact} = OwnerContacts.get_by_phone(owner_contact.phone)

      assert owner_contact == fetched_owner_contact
    end

    test "error when contact owner doesn't exist" do
      insert(:owner_contact, phone: "+5511876543210")

      inexistent_phone = "+5511987654321"

      assert {:error, :not_found} = OwnerContacts.get_by_phone(inexistent_phone)
    end
  end

  describe "upsert/1" do
    test "should insert an owner contact" do
      params = %{
        name: "Jon Snow",
        phone: "+5511987654321",
        email: "jon@snow.com",
        additional_phones: ["+5511654321098"],
        additional_emails: ["jon@snow2.com"]
      }

      assert {:ok, inserted_owner_contact} = OwnerContacts.upsert(params)

      assert inserted_owner_contact.uuid != nil
      assert inserted_owner_contact.name_slug == "jon-snow"
      assert inserted_owner_contact.name == params.name
      assert inserted_owner_contact.phone == params.phone
      assert inserted_owner_contact.email == params.email
      assert inserted_owner_contact.additional_phones == params.additional_phones
      assert inserted_owner_contact.additional_emails == params.additional_emails
    end

    test "should upsert existing owner contact" do
      owner_contact =
        insert(:owner_contact,
          name: "Jon Snow",
          name_slug: "jon-snow",
          phone: "+5511987654321",
          email: nil
        )

      params = %{
        name: "JON SNOW",
        phone: "+5511987654321",
        email: "jon@snow.com",
        additional_emails: ["jon@snow2.com"]
      }

      assert {:ok, updated_owner_contact} = OwnerContacts.upsert(params)

      assert updated_owner_contact.uuid == owner_contact.uuid
      assert updated_owner_contact.name_slug == owner_contact.name_slug
      assert updated_owner_contact.phone == owner_contact.phone
      assert updated_owner_contact.name == params.name
      assert updated_owner_contact.email == params.email
      assert updated_owner_contact.additional_emails == params.additional_emails
    end
  end

  describe "upsert/2" do
    test "should update an existing owner contact" do
      owner_contact =
        insert(:owner_contact,
          name: "Jon Snow",
          name_slug: "jon-snow",
          phone: "+5511987654321",
          email: "jon@snow.com"
        )

      params = %{name: "JON SNOW", phone: owner_contact.phone, email: "joan@snow.com"}

      assert {:ok, updated_owner_contact} = OwnerContacts.upsert(owner_contact, params)

      assert updated_owner_contact.uuid == owner_contact.uuid
      assert updated_owner_contact.name == params.name
      assert updated_owner_contact.phone == owner_contact.phone
      assert updated_owner_contact.email == params.email
      assert updated_owner_contact.name_slug == owner_contact.name_slug
    end

    test "should insert new contact if name changes" do
      owner_contact =
        insert(:owner_contact,
          name: "Jon Snow",
          name_slug: "jon-snow",
          phone: "+5511987654321"
        )

      params = %{name: "Aegon Targaryen", phone: owner_contact.phone}

      assert {:ok, inserted_owner_contact} = OwnerContacts.upsert(owner_contact, params)

      assert inserted_owner_contact.uuid != owner_contact.uuid
      assert inserted_owner_contact.name == params.name
      assert inserted_owner_contact.name_slug == "aegon-targaryen"
      assert inserted_owner_contact.phone == owner_contact.phone
    end

    test "should insert new contact if phone changes" do
      owner_contact =
        insert(:owner_contact,
          name: "Jon Snow",
          name_slug: "jon-snow",
          phone: "+5511987654321"
        )

      params = %{name: owner_contact.name, phone: "+5511876543210"}

      assert {:ok, inserted_owner_contact} = OwnerContacts.upsert(owner_contact, params)

      assert inserted_owner_contact.uuid != owner_contact.uuid
      assert inserted_owner_contact.name == owner_contact.name
      assert inserted_owner_contact.name_slug == owner_contact.name_slug
      assert inserted_owner_contact.phone == params.phone
    end
  end

  describe "data/1" do
    test "should fetch owner contact through dataloader" do
      owner_contact = insert(:owner_contact)

      loader =
        Dataloader.add_source(
          Dataloader.new(),
          :owner_contacts,
          OwnerContacts.data(%{})
        )

      loader =
        loader
        |> Dataloader.load(
          :owner_contacts,
          OwnerContact,
          owner_contact.uuid
        )
        |> Dataloader.run()

      owner_contact_fetched =
        Dataloader.get(loader, :owner_contacts, OwnerContact, owner_contact.uuid)

      assert owner_contact == owner_contact_fetched
    end
  end
end
