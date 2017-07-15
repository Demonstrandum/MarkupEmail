module MarkupEmail
  class Styler
    def self.github_md content
      document = Nokogiri::HTML(content)

      github_css = Net::HTTP.get(URI.parse("https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css"))
      document.at_css('head') << <<-HTML
        <style>
          #{github_css}
          .c1,.cd,.cm,.cs,.markdown-body .c{color:#6a737d}.markdown-body .no,.markdown-body .s .v{color:#005cc5}.markdown-body .e,.markdown-body .en,.na,.nf,.nx{color:#6f42c1}.markdown-body .gh,.w{color:#24292e}.markdown-body .nt{color:#22863a}.highlight .k,.highlight .kn,.highlight .kp,.highlight .kr,.highlight .kv,.k,.kn,.kr,.markdown-body .n{color:#d73a49}.markdown-body .cce,.markdown-body .pds,.markdown-body .s,.markdown-body .s1,.markdown-body .sr,.markdown-body .sra,.markdown-body .sre,.s2{color:#032f62}.markdown-body .smw,.markdown-body .v{color:#e36209}.markdown-body .bu{color:#b31d28}.markdown-body .ii{color:#fafbfc;background-color:#b31d28}.markdown-body .c2{color:#fafbfc;background-color:#d73a49}.markdown-body .c2::before{content:"^M"}.markdown-body .sr .cce{font-weight:700;color:#22863a}.markdown-body .ml{color:#735c0f}.markdown-body .en,.markdown-body .mh,.markdown-body .ms{font-weight:700;color:#005cc5}.markdown-body .mi{font-style:italic;color:#24292e}.markdown-body .mb{font-weight:700;color:#24292e}.markdown-body .md{color:#b31d28;background-color:#ffeef0}.markdown-body .mi1{color:#22863a;background-color:#f0fff4}.markdown-body .mc{color:#e36209;background-color:#ffebda}.markdown-body .mi2{color:#f6f8fa;background-color:#005cc5}.markdown-body .mdr{font-weight:700;color:#6f42c1}.markdown-body .ba{color:#586069}.markdown-body .sg{color:#959da5}.markdown-body .corl{text-decoration:underline;color:#032f62}
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
        </style>
      HTML
      document.to_s
    end
  end
end
