class GarbagesController < ApplicationController
  before_action :set_garbage, only: [:show, :edit, :update_cleaned, :update_reviewed]
  before_action :index_filter, only: [:index]

  # GET /garbages
  def index
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

  def update_cleaned
    @garbage.status = 1
    @garbage.cleaner = current_user
    @garbage.image_cleaned = params[:garbage][:image]
    @garbage.save!
    redirect_to :map
  end

  def update_reviewed
    @garbage.status = 2
    @garbage.reviewer = current_user
    @garbage.save!
    redirect_to :map
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

  def index_filter
    @garbages = Garbage.all
    if current_user.present?
      user_id = current_user.id
      @garbages = @garbages.or(Garbage.filter_reported_by_me(user_id)) if params[:reported_by_me]
      @garbages = @garbages.or(Garbage.filter_cleaned_by_me(user_id)) if params[:cleaned_by_me]
      @garbages = @garbages.or(Garbage.filter_reviewed_by_me(user_id)) if params[:reviewed_by_me]
    end
    @garbages = @garbages.or(Garbage.filter_for_cleaning) if params[:for_cleaning]
    @garbages = @garbages.or(Garbage.filter_for_reviewing) if params[:for_reviewing]
    @garbages = @garbages.or(Garbage.filter_finished) if params[:filter_finished]
  end
end
