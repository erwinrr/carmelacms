require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    fill_in "Carinfo Url", with: @car.carinfo_url
    fill_in "City Mpg", with: @car.city_mpg
    fill_in "Drivetrain", with: @car.drivetrain
    fill_in "Engine", with: @car.engine
    fill_in "Exterior", with: @car.exterior
    fill_in "Finance Payment", with: @car.finance_payment
    fill_in "Hwy Mpg", with: @car.hwy_mpg
    fill_in "Interior", with: @car.interior
    fill_in "Is New", with: @car.is_new
    fill_in "Is Used", with: @car.is_used
    fill_in "Lease Payment", with: @car.lease_payment
    fill_in "Modelcode", with: @car.modelcode
    fill_in "Msrp Price", with: @car.msrp_price
    fill_in "Scraped Url", with: @car.scraped_url
    fill_in "Stock Number", with: @car.stock_number
    fill_in "Title", with: @car.title
    fill_in "Transmission", with: @car.transmission
    fill_in "Vin Number", with: @car.vin_number
    fill_in "Was Scraped", with: @car.was_scraped
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    fill_in "Carinfo Url", with: @car.carinfo_url
    fill_in "City Mpg", with: @car.city_mpg
    fill_in "Drivetrain", with: @car.drivetrain
    fill_in "Engine", with: @car.engine
    fill_in "Exterior", with: @car.exterior
    fill_in "Finance Payment", with: @car.finance_payment
    fill_in "Hwy Mpg", with: @car.hwy_mpg
    fill_in "Interior", with: @car.interior
    fill_in "Is New", with: @car.is_new
    fill_in "Is Used", with: @car.is_used
    fill_in "Lease Payment", with: @car.lease_payment
    fill_in "Modelcode", with: @car.modelcode
    fill_in "Msrp Price", with: @car.msrp_price
    fill_in "Scraped Url", with: @car.scraped_url
    fill_in "Stock Number", with: @car.stock_number
    fill_in "Title", with: @car.title
    fill_in "Transmission", with: @car.transmission
    fill_in "Vin Number", with: @car.vin_number
    fill_in "Was Scraped", with: @car.was_scraped
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
