require 'rails_helper'

RSpec.describe "Complains", type: :request do

  DEFAULT_PATH = '/api/v1/'

  describe 'GET /complains' do
    it 'return success status' do
      get "#{DEFAULT_PATH}/complains"
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /complains/:id' do

    context 'when complain is valid' do
      it 'returns successfully a single complain'  do
        complain = Complain.create(
                                  name: FFaker::Name,
                                  title: FFaker::Name.first_name,
                                  description: FFaker::Name,
                                  locale: FFaker::AddressBR.full_address,
                                  company: FFaker::Company.name
                                  )
        get "#{DEFAULT_PATH}/complains/#{complain.id}"
        expect(response).to have_http_status(200)
      end
    end

    context 'when complain is not valid' do
      it 'returns not found response' do
        get "#{DEFAULT_PATH}/complains/#{FFaker::IdentificationBR.rg}"
        expect(response).to have_http_status(404)
      end
    end
    
  end

  describe 'POST /complains' do

    context 'when a complain is created' do
      it 'with all valid fields' do 
        params = { 
          complain: { 
            name: FFaker::Name, 
            title: FFaker::Name.first_name,
            description: FFaker::Name,
            locale: FFaker::AddressBR.full_address,
            company: FFaker::Company.name
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(201)
      end

      it 'without name field' do
        params = { 
          complain: { 
            title: FFaker::Name.first_name,
            description: FFaker::Name,
            locale: FFaker::AddressBR.full_address,
            company: FFaker::Company.name
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(201)
      end
    end

    context 'when a complain is not created' do
      it 'because missing title field' do
        params = { 
          complain: { 
            description: FFaker::Name,
            locale: FFaker::AddressBR.full_address,
            company: FFaker::Company.name
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(400)
      end

      it 'because missing description field' do
        params = { 
          complain: { 
            title: FFaker::Name.first_name,
            locale: FFaker::AddressBR.full_address,
            company: FFaker::Company.name
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(400)
      end

      it 'because missing locale field' do
        params = { 
          complain: { 
            title: FFaker::Name.first_name,
            description: FFaker::Name,
            company: FFaker::Company.name
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(400)
      end

      it 'because missing company field' do
        params = { 
          complain: { 
            title: FFaker::Name.first_name,
            description: FFaker::Name,
            locale: FFaker::AddressBR.full_address
            } 
          }
        post "#{DEFAULT_PATH}/complains/", params: params
        expect(response).to have_http_status(400)
      end
    end
  end

  describe ' GET /complains/search' do

    context 'when returns results' do
      it 'with locale param' do
        complain = Complain.create(
                        name: FFaker::Name,
                        title: FFaker::Name.first_name,
                        description: FFaker::Name,
                        locale: 'São Paulo, SP',
                        company: FFaker::Company.name
                       )
        get "#{DEFAULT_PATH}/complains/search?locale=#{complain.locale[2..4]}"
        expect(response).to have_http_status(200)
      end

      it 'with company param' do
        complain = Complain.create(
          name: FFaker::Name,
          title: FFaker::Name.first_name,
          description: FFaker::Name,
          locale: FFaker::AddressBR.full_address,
          company: FFaker::Company.name
         )
        get "#{DEFAULT_PATH}/complains/search?company=#{complain.company}"
        expect(response).to have_http_status(200)
      end

      it 'with company and locale param' do
        complain = Complain.create(
          name: FFaker::Name,
          title: FFaker::Name.first_name,
          description: FFaker::Name,
          locale: 'São Paulo, SP',
          company: FFaker::Company.name
         )
        get "#{DEFAULT_PATH}/complains/search?locale=#{complain.locale[2..4]}&company=#{complain.company}"
        expect(response).to have_http_status(200)
      end
    end

    context 'when results does not exists' do
      it 'with locale param' do
        get "#{DEFAULT_PATH}/complains/search?locale=#{FFaker::AddressBR.full_address[2..4]}"
        expect(response).to have_http_status(200)
      end

      it 'with company param' do
        get "#{DEFAULT_PATH}/complains/search?company=#{FFaker::Company.name}"
        expect(response).to have_http_status(200)
      end

      it 'with company and locale param' do
        complain = Complain.create(
          name: FFaker::Name,
          title: FFaker::Name.first_name,
          description: FFaker::Name,
          locale: 'São Paulo, SP',
          company: FFaker::Company.name
         )
        get "#{DEFAULT_PATH}/complains/search?locale=#{FFaker::AddressBR.full_address[2..4]}&company=#{FFaker::Company.name}"
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /complains/coodinates' do

    context 'when params is valid' do
      it 'with real coordinates' do
        get "#{DEFAULT_PATH}/complains/coordinates?lat=-7.1215981&lon=-34.882028"
        expect(response).to have_http_status(200)
      end

      it 'with unreal coordinates' do
        get "#{DEFAULT_PATH}/complains/coordinates?lat=9999&lon=9999"
        expect(response).to have_http_status(200)
      end
    end

  end

  describe 'GET /complains/:id/localization' do
    
    context 'when id is valid' do
      it 'returns data' do
        complain = Complain.create(
                                  name: FFaker::Name,
                                  title: FFaker::Name.first_name,
                                  description: FFaker::Name,
                                  locale: 'São Paulo, SP',
                                  company: FFaker::Company.name
                                  )
        get "#{DEFAULT_PATH}/complains/#{complain.id}/localization"
        expect(response).to have_http_status(200)
      end
    end

    context 'when id is not valid' do
      it 'returns not found' do
        get "#{DEFAULT_PATH}/complains/#{FFaker::IdentificationBR.rg}/localization"
        expect(response).to have_http_status(404)
      end
    end
  end

end
