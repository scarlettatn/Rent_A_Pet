class DesksController < ApplicationController
  before_action :set_desk, only: [:show, :edit, :update, :destroy]

  def index
    # @desks = Desk.all
    if params[:query].present?
      @query = params[:query]
      @desks = Desk.where("lower(name) LIKE ? or lower(description) LIKE ? or lower(title) LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @desks = Desk.all
    end

    @markers = Desk.all.geocoded.map do |desk|
      {
        lat: desk.latitude,
        lng: desk.longitude,
        info_window: render_to_string(partial: "info_window", locals: { desk: desk }),
        image_url: helpers.asset_url("pin_vector.png")
      }
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @desk = Desk.new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def update
    @desk.update(desk_params)
    redirect_to desk_path(@desk)
  end

  def create

    @desk = Desk.new(desk_params)
    @desk.user = current_user
    @desk.address = current_user.address

    respond_to do |format|
      if @desk.save
        format.html { redirect_to @desk, notice: 'Desk was successfully created.' }
        format.json { render :show, status: :created, location: @desk }
      else
        format.html { render :new }
        format.json { render json: @desk.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @desk.destroy
    redirect_to desks_path, status: :see_other
  end

  private

  def set_desk
    @desk = Desk.find(params[:id])
  end

  def desk_params
    params.require(:desk).permit(:name, :title, :description, :price, photos: [])
  end
end
