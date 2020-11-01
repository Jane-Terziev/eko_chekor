class GarbagesController < ApplicationController
  before_action :set_garbage, only: [:show, :edit, :update_cleaned, :update_reviewed]
  before_action :index_filter, only: [:index]
  include EkoChekor::Import[
               web_client: 'web_client'
           ]
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
      body = { image_url: @garbage.image.url }.to_json
      response = JSON.parse(web_client.post(ENV['IMAGE_PROCESSOR_HOST'], :body => body).body)
      @garbage.points = response["result"]
      @garbage.save
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
    if params.to_unsafe_h[:filters]
      @garbages = Garbage.none
      filters = params.to_unsafe_h[:filters].reduce({}, :merge)
      if current_user.present?
        user_id = current_user.id
        @garbages = @garbages.or(Garbage.filter_reported_by_me(user_id)) if filters['reported_by_me']
        @garbages = @garbages.or(Garbage.filter_cleaned_by_me(user_id)) if filters['cleaned_by_me']
        @garbages = @garbages.or(Garbage.filter_reviewed_by_me(user_id)) if filters['reviewed_by_me']
      end
      @garbages = @garbages.or(Garbage.filter_for_cleaning) if filters['for_cleaning']
      @garbages = @garbages.or(Garbage.filter_for_reviewing) if filters['for_reviewing']
      @garbages = @garbages.or(Garbage.filter_finished) if filters['filter_finished']
    else
      @garbages = Garbage.all
    end
  end
end
