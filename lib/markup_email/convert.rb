require 'github/markup'

require 'sanitize'
require 'gemoji'
require 'rinku'
require 'html/pipeline'
require 'html/pipeline/rouge_filter'
require 'task_list/filter'

module MarkupEmail
  class Render
    include HTML
    def initialize file, sanitize=false
      @file = file
      @sanitize = sanitize
    end

    def body
      exit 1 unless package_tester
      unfiltered = File.read(@file) #GitHub::Markup.render @file, File.read(@file) # Use me :'(
      # ^^^^^ IN THE FUTURE, WHEN `HTML::Pipeline` HAS FIXED THEIR SHIT AND DON'T USE
      # ^^^^^ A HUNDRED YEAR OLD VERSION OF `github-linguist` I WILL BE ABLE TO SUPPORT
      # ^^^^^ ALL THE MARKUPS LISTED IN THE `--help` SECTION...
      context = {
        :asset_root => "https://assets-cdn.github.com/images/icons",
        :gfm => true
      }
      filters = [
        Pipeline::MarkdownFilter,
        Pipeline::SanitizationFilter,
        Pipeline::TableOfContentsFilter,
        #Pipeline::CamoFilter,
        TaskList::Filter,
        Pipeline::EmojiFilter,
        Pipeline::AutolinkFilter,
        Pipeline::SyntaxHighlightFilter
      ]
      filters.delete(Pipeline::SanitizationFilter) unless @sanitize

      pipeline = Pipeline.new filters, context
      return pipeline.call(unfiltered)[:output].to_s
    end

    def require_test(package)
      begin
        require "#{package}"
      rescue LoadError
        puts "`#{package}` not installed for you chosen markup!\nSee `--help` for more information on installing the package."
        exit 1
      else
        puts "`#{package}` installed!"
      ensure
        nil
      end
    end

    def package_tester
      if %w(.markdown .md .mdown .mkdn).include? File.extname(@file)
        require_test 'commonmarker'
        return true
      end
      if File.extname(@file) == '.textile'
        require_test 'RedCloth'
        return true
      end
      if File.extname(@file) == '.rdoc'
        require_test 'rdoc'
        return true
      end
      if File.extname(@file) == '.org'
        require_test 'org-ruby'
        return true
      end
      if File.extname(@file) == '.creole'
        require_test 'creole'
        return true
      end
      if %w(.mediawiki .wiki).include? File.extname(@file)
        require_test 'wikicloth'
        return true
      end
      if File.extname(@file) == '.rst'
        begin
          %x(python3 --version)
        rescue
          puts "python3 (Python version 3) not installed, please install `python3`!"
          exit 1
        end
        unless %x(python3 -c "import sphinx" 2>&1).empty?
          puts "python3 `sphinx` module not installed for .rst markup!\nSee `--help` for more information on installing the package."
          exit 1
        end
        return true
      end
      if %w(.asciidoc .adoc .asc).include? File.extname(@file)
        require_test 'asciidoctor'
        return true
      end
      if File.extname(@file) == '.pod'
        begin
          %x(perl -v)
        rescue
          puts "Perl not installed! Please install Perl"
          exit 1
        end
        unless %x(perl -v)[%x(perl -v).index('(v') + 2, 4].to_f >= 5.10
          puts "Your perl version is not up to date (Perl must be >= 5.10)."
          puts "your perl version is #{%x(perl -v)[%x(perl -v).index('(v'), 9]}."
          exit 1
        end
        return true # comes with perl
      end
      return true
    end

  end
end
