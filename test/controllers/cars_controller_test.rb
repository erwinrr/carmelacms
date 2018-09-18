require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { carinfo_url: @car.carinfo_url, city_mpg: @car.city_mpg, drivetrain: @car.drivetrain, engine: @car.engine, exterior: @car.exterior, finance_payment: @car.finance_payment, hwy_mpg: @car.hwy_mpg, interior: @car.interior, is_new: @car.is_new, is_used: @car.is_used, lease_payment: @car.lease_payment, modelcode: @car.modelcode, msrp_price: @car.msrp_price, scraped_url: @car.scraped_url, stock_number: @car.stock_number, title: @car.title, transmission: @car.transmission, vin_number: @car.vin_number, was_scraped: @car.was_scraped } }
    end

    assert_redirected_to car_url(Car.last)
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  test "should update car" do
    patch car_url(@car), params: { car: { carinfo_url: @car.carinfo_url, city_mpg: @car.city_mpg, drivetrain: @car.drivetrain, engine: @car.engine, exterior: @car.exterior, finance_payment: @car.finance_payment, hwy_mpg: @car.hwy_mpg, interior: @car.interior, is_new: @car.is_new, is_used: @car.is_used, lease_payment: @car.lease_payment, modelcode: @car.modelcode, msrp_price: @car.msrp_price, scraped_url: @car.scraped_url, stock_number: @car.stock_number, title: @car.title, transmission: @car.transmission, vin_number: @car.vin_number, was_scraped: @car.was_scraped } }
    assert_redirected_to car_url(@car)
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end
end
