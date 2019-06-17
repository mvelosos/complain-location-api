class Api::V1::ComplainsController < ApplicationController

  # GET /complains
  def index
    @complains = Api::V1::ComplainsService.new.list
    render json: @complains, status: :ok
  end

   # GET /complains/:id
  def show
    @complain = Api::V1::ComplainsService.new.find(params[:id])
    render json: @complain, status: :ok
  end

   # POST /complains
  def create
    @complain = Api::V1::ComplainsService.new.create(create_params)
    if @complain.save
      render json: @complain, status: :created
    else
      render json: { error: 'something occured' }, status: :bad_request
    end
  end

  # GET /complains/search
  def search
    response = Api::V1::ComplainsService.new.search(params)
    if response
      render json: response, status: :ok
    end
  end

  # GET /complains/coodinates
  def coordinates
    result = Api::V1::ComplainsService.new.coordinates(params)
    render json: result, status: :ok
  end

  # GET /complains/:id/localization
  def localization
    result = Api::V1::ComplainsService.new.localization(params)
    render json: result, status: :ok
  end

  private
    def create_params
      params.require(:complain).permit(:name, :title, :description, :locale, :company)
    end

end
