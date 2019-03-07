defmodule ReWeb.Listing.MutationHelpers do
  @moduledoc """
  Helper module for absinthe tests
  """

  import Re.Factory

  def insert_listing_variables(listing, address) do
    %{
      "input" => %{
        "type" => listing.type,
        "address" => %{
          "city" => address.city,
          "state" => address.state,
          "lat" => address.lat,
          "lng" => address.lng,
          "neighborhood" => address.neighborhood,
          "street" => address.street,
          "streetNumber" => address.street_number,
          "postalCode" => address.postal_code
        },
        "price" => listing.price,
        "complement" => listing.complement,
        "description" => listing.description,
        "propertyTax" => listing.property_tax,
        "maintenanceFee" => listing.maintenance_fee,
        "floor" => listing.floor,
        "rooms" => listing.rooms,
        "bathrooms" => listing.bathrooms,
        "restrooms" => listing.restrooms,
        "area" => listing.area,
        "garageSpots" => listing.garage_spots,
        "garageType" => String.upcase(listing.garage_type),
        "suites" => listing.suites,
        "dependencies" => listing.dependencies,
        "balconies" => listing.balconies,
        "hasElevator" => listing.has_elevator,
        "matterportCode" => listing.matterport_code,
        "isExclusive" => listing.is_exclusive,
        "isRelease" => listing.is_release,
        "score" => listing.score
      }
    }
  end

  def update_listing_variables(id, listing, address) do
    %{
      "id" => id,
      "input" => %{
        "type" => listing.type,
        "address" => %{
          "city" => address.city,
          "state" => address.state,
          "lat" => address.lat,
          "lng" => address.lng,
          "neighborhood" => address.neighborhood,
          "street" => address.street,
          "streetNumber" => address.street_number,
          "postalCode" => address.postal_code
        },
        "price" => listing.price,
        "complement" => listing.complement,
        "description" => listing.description,
        "propertyTax" => listing.property_tax,
        "maintenanceFee" => listing.maintenance_fee,
        "floor" => listing.floor,
        "rooms" => listing.rooms,
        "bathrooms" => listing.bathrooms,
        "restrooms" => listing.restrooms,
        "area" => listing.area,
        "garageSpots" => listing.garage_spots,
        "garageType" => String.upcase(listing.garage_type),
        "suites" => listing.suites,
        "dependencies" => listing.dependencies,
        "balconies" => listing.balconies,
        "hasElevator" => listing.has_elevator,
        "matterportCode" => listing.matterport_code,
        "isExclusive" => listing.is_exclusive,
        "isRelease" => listing.is_release,
        "score" => listing.score
      }
    }
  end

  def insert_listing_mutation do
    """
      mutation InsertListing ($input: ListingInput!) {
        insertListing(input: $input) {
          id
          type
          address {
            city
            state
            lat
            lng
            neighborhood
            street
            streetNumber
            postalCode
          }
          owner {
            id
          }
          price
          complement
          description
          propertyTax
          maintenanceFee
          floor
          rooms
          bathrooms
          restrooms
          area
          garageSpots
          garageType
          suites
          dependencies
          balconies
          hasElevator
          matterportCode
          isActive
          isExclusive
          isRelease
          score
        }
      }
    """
  end

  def update_listing_mutation do
    """
      mutation UpdateListing ($id: ID!, $input: ListingInput!) {
        updateListing(id: $id, input: $input) {
          id
          type
          address {
            city
            state
            lat
            lng
            neighborhood
            street
            streetNumber
            postalCode
          }
          owner {
            id
          }
          price
          complement
          description
          propertyTax
          maintenanceFee
          floor
          rooms
          bathrooms
          restrooms
          area
          garageSpots
          garageType
          suites
          dependencies
          balconies
          hasElevator
          matterportCode
          isActive
          isExclusive
          isRelease
          score
        }
      }
    """
  end

  def insert_development_variables(development, address) do
    %{
      "input" => %{
        "name" => development.name,
        "title" => development.title,
        "phase" => development.phase,
        "builder" => development.builder,
        "description" => development.description,
        "address" => %{
          "city" => address.city,
          "state" => address.state,
          "lat" => address.lat,
          "lng" => address.lng,
          "neighborhood" => address.neighborhood,
          "street" => address.street,
          "streetNumber" => address.street_number,
          "postalCode" => address.postal_code
        }
      }
    }
  end

  def update_development_variables(id, development, address) do
    %{
      "id" => id,
      "input" => %{
        "name" => development.name,
        "title" => development.title,
        "phase" => development.phase,
        "builder" => development.builder,
        "description" => development.description,
        "address" => %{
          "city" => address.city,
          "state" => address.state,
          "lat" => address.lat,
          "lng" => address.lng,
          "neighborhood" => address.neighborhood,
          "street" => address.street,
          "streetNumber" => address.street_number,
          "postalCode" => address.postal_code
        }
      }
    }
  end

  def insert_development_mutation do
    """
      mutation InsertDevelopment ($input: DevelopmentInput!) {
        insertDevelopment(input: $input) {
          id
          address {
            city
            state
            lat
            lng
            neighborhood
            street
            streetNumber
            postalCode
          }
          name
          title
          phase
          builder
          description
        }
      }
    """
  end

  def update_development_mutation do
    """
      mutation UpdateDevelopment ($id: ID!, $input: DevelopmentInput!) {
        updateDevelopment(id: $id, input: $input) {
          id
          address {
            city
            state
            lat
            lng
            neighborhood
            street
            streetNumber
            postalCode
          }
          name
          title
          phase
          builder
          description
        }
      }
    """
  end
end
