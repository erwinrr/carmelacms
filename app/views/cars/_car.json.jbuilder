json.extract! car, :id, :title, :vin_number, :stock_number, :msrp_price, :finance_payment, :lease_payment, :engine, :transmission, :drivetrain, :exterior, :interior, :hwy_mpg, :city_mpg, :was_scraped, :scraped_url, :carinfo_url, :is_new, :is_used, :modelcode, :created_at, :updated_at
json.url car_url(car, format: :json)
