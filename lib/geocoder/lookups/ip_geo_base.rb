require 'geocoder/lookups/base'
require 'geocoder/results/ip_geo_base'

module Geocoder
  module Lookup
    class IpGeoBase < Base
      def name
        'IpGeoBase'
      end

      def query_url(query)
        "#{protocol}://ipgeobase.ru:7020/geo?#{url_query_string(query)}"
      end

      def query_url_params(query)
        {
          ip: query.sanitized_text,
          json: 1
        }.merge(super)
      end

      # currently doesn't support HTTPS
      def supported_protocols
        [:http]
      end

      private 

      def valid_response?(response)
        json = parse_json(response.body)
        super(response) && json['message'] != 'Incorrect request'
      end

      def results(query)
        return [reserved_result(query.text)] if query.loopback_ip_address?

        if (doc = fetch_data(query)).nil?
          []
        else
          [doc]
        end
      end

      def response_charset(response)
        super || 'cp1251'
      end

      def reserved_result(ip)
        {'message' => 'Input string is not a valid IP address', 'code' => 401}
      end
    end
  end
end
