require 'singleton'
require 'securerandom'

class Service
  include Singleton

  def read_captcha(image_path)
    FileUtils.makedirs 'tmp'
    temp_file_name = SecureRandom.hex

    %x{ convert #{image_path} -contrast -contrast -morphology DilateIntensity Octagon:1 tmp/#{temp_file_name}.jpg }
    %x{ tesseract -l eng tmp/#{temp_file_name}.jpg tmp/#{temp_file_name} }

    captcha_text = File.read("tmp/#{temp_file_name}.txt").to_s.strip

    %w[jpg txt].each do |format|
      FileUtils.remove_file "tmp/#{temp_file_name}.#{format}"
    end

    captcha_text
  end
end
