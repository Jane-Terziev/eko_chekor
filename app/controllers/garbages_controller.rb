class GarbagesController < ApplicationController
  before_action :set_garbage, only: [:show, :edit, :update, :destroy]

  # GET /garbages
  def index
    @garbages = Garbage.all
    respond_to do |format|
      format.html
      format.json { render json: @garbages.as_json }
    end
  end

  # GET /garbages/1
  def show
  end

  # GET /garbages/new
  def new
    @garbage = Garbage.new
  end

  # GET /garbages/1/edit
  def edit
  end

  # POST /garbages
  def create
    @garbage = Garbage.new(garbage_params.merge(user_id: current_user.id, status: Garbage::STATUSES[:not_cleaned]))

    if @garbage.save
      redirect_back(fallback_location: map_path)
    else
      render :new
    end
  end

  # PATCH/PUT /garbages/1
  def update
    if @garbage.update(garbage_params)
      redirect_to @garbage
    else
      render :edit
    end
  end

  # DELETE /garbages/1
  def destroy
    @garbage.destroy
    redirect_to garbages_url
  end

  def map
    @garbage = Garbage.new
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garbage
      @garbage = Garbage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def garbage_params
      params.require(:garbage).permit(:description, :image, :status, :points, location_attributes: [:longitude, :latitude])
    end
end
