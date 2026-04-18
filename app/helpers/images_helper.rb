module ImagesHelper
  # Generate an imgproxy URL for the given source image.
  def proxy_image(source_url, width:, height:, format: "webp")
    Imgproxy.url_for(source_url, width: width, height: height, resizing_type: :fill, format: format)
  end
end
