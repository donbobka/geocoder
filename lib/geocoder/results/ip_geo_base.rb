require 'geocoder/results/base'

module Geocoder
  module Result
    class IpGeoBase < Base
      def initialize(data)
        super
        @data = data.first.last
      end

      def address(format = :full)
        "#{city}, #{state}, #{country}".sub(/^[ ,]*/, "")
      end

      def city
        @data['city']
      end

      def state
        @data['region']
      end

      def state_code
        ''
      end
      
      def postal_code
        ''
      end

      def country
        country_code
      end

      def country_code
        @data['country']
      end

      def coordinates
        [@data['lat'].to_f, @data['lng'].to_f]
      end

      def self.response_attributes
        %w[inetnum district]
      end

      response_attributes.each do |a|
        define_method a do
          @data[a]
        end
      end
    end
  end
end
