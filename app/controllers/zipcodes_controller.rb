class ZipcodesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    render status: 406, json: {
      errors: 'Endpoint only accepts JSON'
    }
  end

  def find
    if params[:zipcode].present?
      zip = Zipcode.find_by_zipcode(params[:zipcode])
      if zip.present?
        tz = ActiveSupport::TimeZone[zip.utc_offset]
        render status: 200, json: {
          tz_name: tz.tzinfo.name,
          zipcode: zip.slice('city', 'dst', 'lat', 'lng', 'state', 'utc_offset', 'zipcode')
        }
      else
        render status: 404, json: {
          errors: 'Zipcode not found'
        }
      end
    else
      render status: 400, json: {
        errors: 'Bad request; no zipcode parameter'
      }
    end
  end
end
