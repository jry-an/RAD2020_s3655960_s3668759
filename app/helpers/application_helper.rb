module ApplicationHelper
  # This is a plugin that strips markdown from a field of text
  require 'redcarpet/render_strip'

  # Check what role the current user has
  def has_role?(role)
    current_user && current_user.has_role?(role)
  end

  # Majority of the below code was not mine
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, :hard_wrap => true)
    # There are many more options you can use here, these are the ones
    # I found on a forum post
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis:  true,
      autolink:           true,
      lax_html_blocks:    true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

  def strip_markdown(text)
    markdown_to_plain_text = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    markdown_to_plain_text.render(text).html_safe
  end

end