require 'RMagick'

class ImageDiff
  
  #max = 20
  MATRIX = 15
  
  def generate_array(image_path)
    result = []
    main_img = Magick::Image.read(image_path).first
    unless main_img.nil?
      main_img.resize!(MATRIX, MATRIX)
      
      pixel_array = []
      avr_pixel = 0
      MATRIX.times do |i|
        pixel_array[i] = []
        MATRIX.times do |j|
          temp_pixel = main_img.pixel_color(i, j)
          pixel_array[i][j] = temp_pixel.intensity()
          avr_pixel += pixel_array[i][j]
        end
      end
      
      avr_pixel = avr_pixel.to_f / (MATRIX * MATRIX);
      
      MATRIX.times do |i|
        MATRIX.times do |j|
          row = (pixel_array[i][j] == 0) ? 0 : (2*((pixel_array[i][j] > avr_pixel) ? pixel_array[i][j].to_f / avr_pixel : (avr_pixel.to_f / pixel_array[i][j]) * -1)).round
          row_str = "#{i + 10}#{j + 10}#{255 + row}"
          result << row_str.to_i
        end
      end
    end
    return result
  end
  
  def diff_images(image_path1, image_path2)
    res_array1 = generate_array(image_path1)
    res_array2 = generate_array(image_path2)
    
    main_array = res_array1 & res_array2
    
    return sprintf('%.6f', (main_array.length.to_f / (MATRIX * MATRIX)))
  end
  
end