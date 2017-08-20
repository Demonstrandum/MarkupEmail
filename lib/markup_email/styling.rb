module MarkupEmail
  class Styler
    def self.github_md content
      document = Nokogiri::HTML(content)

      custom_css = String.new
      css_files = %w{ .markup-email.css .email.css .markup.css .markdown.css }
      css_files.each do |css_file|
        if File.file? "#{File.expand_path '~'}/#{css_file}"
          custom_css = File.read "#{File.expand_path '~' }/#{css_file}"
          break
        end
      end

      github_css = Net::HTTP.get(URI.parse("https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css"))
      document.at_css('head') << <<-HTML
        <link rel="shortcut icon" href="https://user-images.githubusercontent.com/26842759/28286954-7d4e4b02-6b29-11e7-97d6-ca223344f755.png">
        <link rel="icon" type="image/png" sizes="32x32" href="https://user-images.githubusercontent.com/26842759/28287052-c6288b08-6b29-11e7-8915-c60bc7b17b7d.png">
        <link rel="icon" type="image/png" sizes="16x16" href="https://user-images.githubusercontent.com/26842759/28287062-ca8f0fb4-6b29-11e7-945f-31486a537b01.png">

        <style>
          #{github_css}
          .c1,.cd,.cm,.cs,.markdown-body .c {
            color: #6a737d;
          }

          .markdown-body .no,.markdown-body .s, .nb, .v, .mi {
            color: #005cc5;
          }

          .markdown-body .e,.markdown-body .en,.na,.nf,.nx {
            color: #6f42c1;
          }

          .markdown-body .gh,.w {
            color: #24292e;
          }

          .markdown-body .nt {
            color: #22863a;
          }

          .highlight .k,.highlight .kn,.highlight .kp,.highlight .kr,.highlight .kv,.k,.kn,.kr,.markdown-body .o, .nb {
            color: #d73a49;
          }
          .highlight-shell .o {
            color: inherit;
          }
          .highlight-shell .nb {
            color: #005cc5;
          }

          .markdown-body .cce,.markdown-body .pds,.markdown-body .s,.markdown-body .s1,.markdown-body .sr,.markdown-body .sra,.markdown-body .sre,.s2 {
            color: #032f62;
          }

          .markdown-body .smw,.markdown-body .v {
            color: #e36209;
          }

          .markdown-body .bu {
            color: #b31d28;
          }

          .markdown-body .ii {
            color: #fafbfc;
            background-color: #b31d28;
          }

          .markdown-body .c2 {
            color: #fafbfc;
            background-color: #d73a49;
          }

          .markdown-body .c2::before {
            content: "^M";
          }

          .markdown-body .sr .cce {
            font-weight: 700;
            color: #22863a;
          }

          .markdown-body .ml {
            color: #735c0f;
          }

          .markdown-body .en,.markdown-body .mh,.markdown-body .ms {
            font-weight: 700;
            color: #005cc5;
          }

          .markdown-body .mb {
            font-weight: 700;
            color: #24292e;
          }

          .markdown-body .md {
            color: #b31d28;
            background-color: #ffeef0;
          }

          .markdown-body .mi1 {
            color: #22863a;
            background-color: #f0fff4;
          }

          .markdown-body .mc {
            color: #e36209;
            background-color: #ffebda;
          }

          .markdown-body .mi2 {
            color: #f6f8fa;
            background-color: #005cc5;
          }

          .markdown-body .mdr {
            font-weight: 700;
            color: #6f42c1;
          }

          .markdown-body .ba {
            color: #586069;
          }

          .markdown-body .sg {
            color: #959da5;
          }

          .markdown-body .corl {
            text-decoration: underline;
            color: #032f62;
          }
        </style>

        <style>
          body {
            margin: 100px auto;
            width: 980px;
            font-size: 16px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
            padding: 0;
          }
          .markdown-body {
            display: block;
            padding: 45px;
            border-radius: 5px;
            border: 1px solid #ddd;

          }
          .markdown-body:first-child {
            box-shadow: 0 10px 50px rgba(0, 0, 0, 0.2);
          }
          img {
            border-radius: 5px;
          }
          a {
            border-bottom: 1px solid rgba(3, 102, 214, 0.3);
            transition: all .075s ease-in-out;
          }
          a:hover {
            text-decoration: none !important;
            border-bottom: 1px solid rgb(3, 102, 214);
          }
          .selected {
            border-bottom: 1px solid #1c0ec4 !important;
            text-decoration: none;
            color: #1c0ec4 !important;
            cursor: not-allowed;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
          }
          .selected:hover {
            border-bottom: 1px solid #1c0ec4 !important;
            color: #1c0ec4 !important;
            cursor: not-allowed;
          }
          .anchor {
            border: none !important;
          }
        </style>

        <!-- User custom style overide -->
        <style>
          #{custom_css}
        </style>

      HTML
      document.to_s.gsub("<span aria-hidden=\"true\" class=\"octicon octicon-link\"></span>", "<svg aria-hidden=\"true\" class=\"octicon octicon-link\" height=\"16\" version=\"1.1\" viewBox=\"0 0 16 16\" width=\"16\"><path fill-rule=\"evenodd\" d=\"M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0
      3-1.69 3-3.5S14.5 6 13 6z\"></path></svg>")
    end
  end
end
