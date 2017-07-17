require 'markup_email/convert'
require 'markup_email/styling'
require 'markup_email/meta'

module MarkupEmail
  class Convert
    attr_reader :content

    def initialize file, title=String.new, sanitize=false
      @file = file
      body = Render.new(@file, sanitize).body
      metadata = HTMLify.new(body)
      title = "#{File.basename(file).split('.')[0..-2].join('.')}" if title.empty?
      metadata.title = title
      metadata.documentize
      metadata.meta
      @content = Styler.github_md(metadata.content)
    end

    def write name=String.new
      ext_split = File.basename(@file).split('.')
      new_file = name
      new_file = "#{ext_split[0, ext_split.length - 1][0]}-email.#{ext_split[-1]}.html" if name.empty?

      File.open("#{File.dirname(@file)}/#{new_file}", 'w') { |file| file.write @content }
      new_file
    end

  end
end
