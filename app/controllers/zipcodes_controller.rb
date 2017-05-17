class ZipcodesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    render status: 406, json: {
      errors: 'Service accepts JSON only'
    }
  end

  def find
    if params[:zipcode].present?
      zip = Zipcode.find_by_zipcode(params[:zipcode])
      if zip.present?
        tzinfo = Timezone.lookup(zip.lat, zip.lng)
        timezone = ActiveSupport::TimeZone::MAPPING.key(tzinfo.name)
        render status: 200, json: {
          tz_name: timezone,
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
