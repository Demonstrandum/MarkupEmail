require 'nokogiri'

require 'net/http'
require 'open-uri'

require 'rouge'

module MarkupEmail
  class HTMLify
    attr_accessor :title
    attr_reader :content
    def initialize content
      @content = content
    end

    def documentize
      @content = <<-HTML
<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <article class="markdown-body">#{@content}</article>
  </body>
</html>
HTML
    end

    def meta
      document = Nokogiri::HTML(@content)
      document.css('html')[0]['xmlns'  ] = "http://www.w3.org/1999/xhtml"
      document.css('html')[0]['xmlns:v'] = "urn:schemas-microsoft-com:vml"
      document.css('html')[0]['xmlns:o'] = "urn:schemas-microsoft-com:office:office"

      document.at_css('head') << <<-HTML
<!-- NAME: 1:2:1 COLUMN -->
<!--[if gte mso 15]>
<xml>
  <o:OfficeDocumentSettings>
  <o:AllowPNG/>
  <o:PixelsPerInch>96</o:PixelsPerInch>
  </o:OfficeDocumentSettings>
</xml>
<![endif]-->
HTML
      #github_framework = Net::HTTP.get(URI.parse("https://assets-cdn.github.com/assets/frameworks-2d2d4c150f7000385741c6b992b302689ecd172246c6428904e0813be9bceca6.css"))
      #github_primercss = Net::HTTP.get(URI.parse("https://assets-cdn.github.com/assets/github-0522ae8d3b3bdc841d2f91f90efd5f1fd9040d910905674cd134ced43a6dfea6.css"))

      # Include: #{Rouge::Themes::Tulip.render(scope: '.highlight')} in a style tag for rouge font rendering
      document.at_css('head') << <<-HTML
<title>#{@title}</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
HTML

      @content = document.to_s
    end
  end
end
