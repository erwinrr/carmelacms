class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, except: [:icon_select]
  before_action :set_group, except: [:icon_select]

  # GET /departments
  # GET /departments.json
  def index
    # @departments = Department.includes(:users).select("departments.*, COUNT('user.id') as user_count").group(:id)
    @departments = @organization.departments
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
    @customers = @group.users.with_role(:customer)
    @users = @group.users.where.not(id:@customers)
  end

  # GET /departments/1/edit
  def edit
    @customers = @group.users.with_role(:customer)
    @users = @group.users.where.not(id:@customers)
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to organization_group_departments_path(@organization, @group), notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to organization_group_departments_path(@organization, @group), notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        @customers = @group.users.with_role(:customer)
        @users = @group.users.where.not(id:@customers)
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to organization_group_departments_path(@organization, @group), notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #bootstrap modal for icon select on edit/create dep
  def icon_select
    # @ionic_icons=["add","add-circle","alarm","albums","alert","american-football","analytics","logo-android","logo-angular","aperture","logo-apple","apps","appstore","archive","arrow-back","arrow-down","arrow-dropdown","arrow-dropdown-circle","arrow-dropleft","arrow-dropleft-circle","arrow-dropright","arrow-dropright-circle","arrow-dropup","arrow-dropup-circle","arrow-forward","arrow-round-back","arrow-round-down","arrow-round-forward","arrow-round-up","arrow-up","at","attach","backspace","barcode","baseball","basket","basketball","battery-charging","battery-dead","battery-full","beaker","beer","bicycle","logo-bitcoin","bluetooth","boat","body","bonfire","book","bookmark","bookmarks","bowtie","briefcase","browsers","brush","logo-buffer","bug","build","bulb","bus","cafe","calculator","calendar","call","camera","car","card","cart","cash","chatboxes","chatbubbles","checkbox","checkbox-outline","checkmark","checkmark-circle","checkmark-circle-outline","logo-chrome","clipboard","clock","close","close-circle","cloud","cloud-circle","cloud-done","cloud-download","cloud-outline","cloud-upload","cloudy","cloudy-night","code","code-download","code-working","logo-codepen","cog","color-fill","color-filter","color-palette","color-wand","compass","construct","contact","contacts","contract","contrast","copy","create","crop","logo-css3","cube","cut","logo-designernews","desktop","disc","document","done-all","download","logo-dribbble","logo-dropbox","easel","egg","logo-euro","exit","expand","eye","eye-off","logo-facebook","fastforward","female","filing","film","finger-print","flag","flame","flash","flask","flower","folder","folder-open","football","logo-foursquare","logo-freebsd-devil","funnel","git-branch","git-commit","git-compare","git-merge","git-network","git-pull-request","logo-github","glasses","globe","logo-google","logo-googleplus","grid","logo-hackernews","hammer","hand","happy","headset","heart","help","help-buoy","help-circle","home","logo-html5","ice-cream","image","images","infinite","information","information-circle","logo-instagram","logo-javascript","jet","key","keypad","laptop","leaf","link","logo-linkedin","list","list-box","locate","lock","log-in","log-out","magnet","mail","mail-open","male","man","map","logo-markdown","medal","medical","medkit","megaphone","menu","mic","mic-off","microphone","moon","more","move","musical-note","musical-notes","navigate","logo-nodejs","notifications","notifications-off","notifications-outline","nuclear","nutrition","logo-octocat","open","options","outlet","paper","paper-plane","partly-sunny","pause","paw","people","person","person-add","phone-landscape","phone-portrait","photos","pie","pin","pint","logo-pinterest","pizza","planet","play","logo-playstation","podium","power","pricetag","pricetags","print","pulse","logo-python","qr-scanner","quote","radio","radio-button-off","radio-button-on","rainy","recording","logo-reddit","redo","refresh","refresh-circle","remove","remove-circle","reorder","repeat","resize","restaurant","return-left","return-right","reverse-camera","rewind","ribbon","rose","logo-rss","sad","logo-sass","school","search","send","settings","share","share-alt","shirt","shuffle","skip-backward","skip-forward","logo-skype","logo-snapchat","snow","speedometer","square","square-outline","star","star-half","star-outline","stats","logo-steam","stopwatch","subway","sunny","swap","switch","sync","tablet-landscape","tablet-portrait","tennisball","text","thermometer","thumbs-down","thumbs-up","thunderstorm","time","timer","train","transgender","trash","trending-down","trending-up","trophy","logo-tumblr","logo-twitch","logo-twitter","umbrella","undo","unlock","logo-usd","videocam","logo-vimeo","volume-mute","volume-off","walk","warning","watch","water","logo-whatsapp","wifi","logo-windows","wine","woman","logo-wordpress","logo-xbox","logo-yahoo","logo-yen","logo-youtube"]
    @ionic_icons = Icon.all.where(set:"ionic");
    @fontawesome_icons = Icon.all.where(set:"fontawesome")
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
    def set_group
      @group = Group.find(params[:group_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :icon_id, :group_id, user_ids: [])
    end
end
