# encoding: utf-8
require 'test_helper'

class IpGeoBaseTest < GeocoderTestCase

  def setup
    Geocoder.configure(ip_lookup: :ip_geo_base)
  end

  def test_result_on_ip_address_search
    result = Geocoder.search("78.31.96.61").first
    assert result.is_a?(Geocoder::Result::IpGeoBase)
  end

  def test_result_components
    result = Geocoder.search("78.31.96.61").first
    assert_equal "Тверская область, Тверь", result.address
  end
end
