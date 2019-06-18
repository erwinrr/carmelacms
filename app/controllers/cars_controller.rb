class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, except: [:scrape, :unknown]
  skip_before_action :verify_authenticity_token, only: :scrape
  skip_before_action :authenticate_user!, only: :scrape
  # GET /cars
  # GET /cars.json
  def index
    @q = @organization.cars.ransack(params[:q])
    @cars = @q.result
    respond_to do |format|
      format.html { render :index }
      format.json {
        @car_likes = current_user.likes.pluck(:car_id)
        render json: {
          :cars => @cars,
          :car_likes => @car_likes,
          :max_price => Car.maximum('msrp_price'),
          :min_price => Car.minimum('msrp_price')
        }
      }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def scrape
    pages_string = params[:pages]
    is_new = params[:is_new]
    is_used = params[:is_used]
    pages_obj = JSON.parse(pages_string)
    group_ids = Group.where(scrape_url: params[:url]).pluck(:id)
    new_cars_ids = [];
    case params[:url]
    when 'https://www.mbofbakersfield.com'
      pages_obj.each do |page|
        newdoc = Nokogiri::HTML(page['page_html']);
        newdoc.css('table#results-page tr.hidden-xs div.vehicle').each do |vehicle|
          group_ids.each do |gid|
            @group = Group.find(gid);
            vin = vehicle.css('div.vehicle-overview div.vinstock span:nth-child(1)').text.strip.chomp.sub('VIN: ', '')
            car = @group.cars.find_or_initialize_by(vin_number: vin)
            car.title = vehicle.css('div.vehicle-title h2 a').text.chomp
            car.msrp_price = vehicle.css('div.our-price span.price').text.strip.chomp.delete('$,').to_i
            car.stock_number = vehicle.css('div.vinstock span:nth-child(2)').text.strip.chomp.sub('STOCK #: ', '')
            car.finance_payment = vehicle.css('div.finance span.price').text.strip.chomp.delete('$,').to_i
            car.lease_payment = vehicle.css('div.leasepayment span.price').text.strip.chomp.delete('$,').to_i
            car.hwy_mpg = vehicle.css('div.options ul li:nth-child(6) span:nth-child(2)').text.strip.chomp.delete('MPG')
            car.city_mpg = vehicle.css('div.options ul li:nth-child(6) span.detail-content:nth-child(4)').text.strip.chomp.delete('MPG')
            car.main_image = vehicle.css('div.vehicle-leftcol div.vehicle-image img').attr('data-src')
            car.was_scraped = true
            car.scraped_url = page['page_url']
            element = vehicle.at_css('div.vehicle-title h2 a[href]')
            car.carinfo_url = element['href']
            car.is_new = is_new
            car.is_used = is_used
            car_options = vehicle.css('div.vehicle-content div.options ul li')
            car_options.each do |option|
              if option.css('span.detail-label').text.strip.downcase.include? 'engine'
                car.engine = option.css('span.detail-content').text.strip.chomp
              elsif option.css('span.detail-label').text.strip.downcase.include? 'trans'
                car.transmission = option.css('span.detail-content').text.strip.chomp
              elsif option.css('span.detail-label').text.strip.downcase.include? 'drivetrain'
                car.drivetrain = option.css('span.detail-content').text.strip.chomp
              elsif option.css('span.detail-label').text.strip.downcase.include? 'exterior'
                car.exterior = option.css('span.detail-content').text.strip.chomp
              elsif option.css('span.detail-label').text.strip.downcase.include? 'interior'
                car.interior = option.css('span.detail-content').text.strip.chomp
              elsif option.css('span.detail-label').text.strip.downcase.include? 'mileage'
                car.mileage = option.css('span.detail-content').text.strip.delete(',').to_i
              end
            end
            car.group_id = gid
            car.year = set_year(car.title)
            car.model = set_model(car.title)
            car.make = set_make(car.title)
            car.save
            new_cars_ids.push(car.id)
          end
        end
      end
    when 'https://www.sangerasubaru.com'
      #to do: still need to follow link into car page and scrape hwy & city MPG
      pages_obj.each do |page|
        newdoc = Nokogiri::HTML(page['page_html']);
        newdoc.css('ul.inventoryList li.item').each do |vehicle|
          car = Car.new()
          car.was_scraped = true
          car.is_new = is_new
          car.is_used = is_used
          car.title = vehicle.css('h3 a').text.strip.chomp
          car.msrp_price = vehicle.css('span.final-price span.value').text.strip.chomp.delete('$,').to_i
          car.vin_number = vehicle.css('dl.vin dd').text.strip.chomp
          car.finance_payment = vehicle.css('span.paymentLoan span.value').text.strip.chomp.delete('$,').to_i
          car.lease_payment = vehicle.css('span.paymentLease span.value').text.strip.chomp.delete('$,').to_i
          car.scraped_url = page['page_url']
          car.carinfo_url = vehicle.at_css('h3 a')['href']
          vehicle.css('div.description dl dt').each do | dl_element |
            if dl_element.text.strip.downcase.include? 'stock'
              car.stock_number = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'engine'
              car.engine = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'transmission'
              car.transmission = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'exterior color'
              car.exterior = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'interior color'
              car.interior = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'model code'
              car.modelcode = dl_element.next_element.text.strip.chomp.delete(',')
            end
          end
          car.main_image = vehicle.css('div.media a img').attr('src').value
          car.group_id = group_id_found
          car.save
        end
      end
    when 'https://www.volvocarsbakersfield.com'
      pages_obj.each do |page|
        newdoc = Nokogiri::HTML(page['page_html']);
        newdoc.css('ul.inventoryList li.item').each do |vehicle|
          car = Car.new()
          car.was_scraped = true
          car.is_new = is_new
          car.is_used = is_used
          car.title = vehicle.css('h3 a').text.strip.chomp
          car.msrp_price = vehicle.css('span.final-price span.value').text.strip.chomp.delete('$,').to_i
          car.vin_number = vehicle.css('dl.vin dd').text.strip.chomp
          car.finance_payment = vehicle.css('span.paymentLoan span.value').text.strip.chomp.delete('$,').to_i
          car.lease_payment = vehicle.css('span.paymentLease span.value').text.strip.chomp.delete('$,').to_i
          car.scraped_url = page['page_url']
          car.carinfo_url = vehicle.at_css('h3 a')['href']
          vehicle.css('div.description dl dt').each do | dl_element |
            if dl_element.text.strip.downcase.include? 'stock'
              car.stock_number = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'engine'
              car.engine = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'transmission'
              car.transmission = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'exterior color'
              car.exterior = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'interior color'
              car.interior = dl_element.next_element.text.strip.chomp.delete(',')
            elsif dl_element.text.strip.downcase.include? 'model code'
              car.modelcode = dl_element.next_element.text.strip.chomp.delete(',')
            end
          end
          car.group_id = group_id_found
          car.save
        end
      end
    end
    # after scraping new cars basically adding new cars and updating cars that match by vin.
    # delete the diff or all the ones that were not created or updated for new or used.
    # this leaves the ones that were manually added via the dashboard.
    Car.all.where("was_scraped = ? and is_new = ? and id not in (?) and group_id in (?)", true, is_new, new_cars_ids, group_ids).destroy_all
  end

  def models
    group = current_user.groups.first
    @models = group.cars.where.not(model:nil).pluck(:model).uniq.sort

    respond_to do |format|
      format.json {
        render json: {:models => @models}
      }
    end

  end

  def set_year(title)
    matches = title.scan(/\b\d{4}\b/)
    matches.each do |string|
      if string.to_i > 1950 && string.to_i < 2025
        return string.to_i
      end
    end
  end
  
  def set_model(title)
    models = Model.all.pluck(:name)
    models.map!(&:downcase)
    r = Regexp.union models 
    if title.downcase.match? r
      str = title.downcase.match r
      return str[0]
    end
  end


  def set_make(title)
    makes = Make.all.pluck(:name)
    makes.map!(&:downcase)
    r = Regexp.union makes 
    if title.downcase.match? r
      str = title.downcase.match r
      return str[0]
    end
  end

  def unknown 
    @organization = current_user.organizations.first
    @unknown_makes = Car.all.where(make:nil)
    @unknown_models = Car.all.where(model:nil)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:title, :vin_number, :stock_number, :msrp_price, :finance_payment, :lease_payment, :engine, :transmission, :drivetrain, :exterior, :interior, :hwy_mpg, :city_mpg, :was_scraped, :scraped_url, :carinfo_url, :is_new, :is_used, :modelcode)
    end

    #params for scraper html page as string
    def htmlpage_params
      params.permit(:htmlpage)
    end

end
