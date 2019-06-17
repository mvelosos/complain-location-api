class Api::V1::ComplainsService
  
  def list
    Complain.all.order(created_at: :desc)
  end

  def find(id)
    Complain.find(id)
  end

  def create(params)
    Complain.new(params)
  end

  def search(params)
    if params[:company] && params[:locale]
      @complains = Complain.where(company: /.*#{params[:company]}.*/)
                           .where(locale: /.*#{params[:locale]}.*/)
      response = get_response(@complains)
    elsif params[:company]
      @complains = Complain.any_of(company: /.*#{params[:company]}.*/)
      response = get_response(@complains)
    elsif params[:locale]
      @complains = Complain.any_of(locale: /.*#{params[:locale]}.*/)
      response = get_response(@complains)
    end
  end

  def coordinates(params)
    result = Geolocalization.coordinates(params)
  end

  def localization(params)
    @complain = Complain.find(params[:id])
    result = Geolocalization.localization([@complain.coordinates[1], @complain.coordinates[0]])
  end

  private
    def get_response(complains)
      {
        quantity: complains.count,
        complains: complains
      }
    end

end
