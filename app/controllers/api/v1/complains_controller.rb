class Api::V1::ComplainsController < ApplicationController

  # GET /complains
  def index
    @complains = Complain.all.order(created_at: :desc)
    render json: @complains, status: :ok
  end

   # GET /complains/:id
  def show
    p params
    @complain = Complain.find(params[:id])
    render json: @complain, status: :ok
  end

   # POST /complains
  def create
    @complain = Complain.new(create_params)
    if @complain.save
      render json: @complain, status: :created
    else
      render json: { error: 'something occured' }, status: :bad_request
    end
  end

  # GET /complains/search
  def search
    if params[:company] && params[:locale]
      @complains = Complain.where(company: /.*#{params[:company]}.*/)
                           .where(locale: /.*#{params[:locale]}.*/)
      response = get_response(@complains)
      render json: response, status: :ok
    elsif params[:company]
      @complains = Complain.any_of(company: /.*#{params[:company]}.*/)
      response = get_response(@complains)
      render json: response, status: :ok
    elsif params[:locale]
      @complains = Complain.any_of(locale: /.*#{params[:locale]}.*/)
      response = get_response(@complains)
      render json: response, status: :ok
    end
  end

  private
    def create_params
      params.require(:complain).permit(:name, :title, :description, :locale, :company)
    end

    def get_response(complains)
      {
        quantity: complains.count,
        complains: complains
      }
    end

end
