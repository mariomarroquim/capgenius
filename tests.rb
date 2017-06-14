require 'minitest/autorun'
require 'rest-client'

require_relative 'service'

class Test < Minitest::Test
  def test_scenario_0
    assert Service.instance.read_captcha('captchas/0.jpg') == 'n7f85'
  end

  def test_scenario_1
    assert Service.instance.read_captcha('captchas/1.jpg') == 'trm5q'
  end

  def test_scenario_2
    assert Service.instance.read_captcha('captchas/2.jpg') == 'ugss3'
  end

  def test_scenario_3
    assert Service.instance.read_captcha('captchas/3.jpg') == 'zvpyc'
  end

  def test_endpoint
    url = 'localhost:3000'
    response = RestClient.post(url, captcha: File.open('captchas/0.jpg'))
    assert response == 'n7f85'
  end
end
