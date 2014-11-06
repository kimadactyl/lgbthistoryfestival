class Custom_Helpers < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def inline_img(src,caption)
      # Check inputs
      if !(src.is_a?(String) && caption.is_a?(String))
        raise("inline_img: invalid parameters")
      end
       "<li>
       <a href=\"#{src}\">
       <img src=\"#{src}\" alt=\"#{caption}\">
       <figcaption>#{caption}</figcaption>
       </a>
       </li>"
    end
  end
end

::Middleman::Extensions.register(:custom_helpers,Custom_Helpers)
