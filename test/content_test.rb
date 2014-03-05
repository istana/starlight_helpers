require_relative './test_helper'
require 'action_view'

class LesterHelper
  extend ActionView::Helpers::TagHelper
  extend ActionView::Helpers::UrlHelper
  extend StarlightHelpers::Content
end

describe StarlightHelpers::Content do
  it '#link_to_selected' do
    assert_equal '<a class="selected" href="#">Ahoy</a>',    
      LesterHelper.link_to_selected(true, 'Ahoy', '#')
    assert_equal '<a href="#">Ahoy</a>',    
      LesterHelper.link_to_selected(false, 'Ahoy', '#')
  end
  
  it '#render_text' do
        text = "h1. *Ahoy*

<style>body{color: navy}</style>"

    assert_equal "<p>h1. <em>Ahoy</em></p>\n\n<style>body{color: navy}</style>\n",
      LesterHelper.render_text(text, 'text/markdown')
    
    assert_equal "<h1><strong>Ahoy</strong></h1>\n<style>body{color: navy}</style>",
      LesterHelper.render_text(text, 'text/textile')
    
    assert_equal "h1. *Ahoy*\n\n<style>body{color: navy}</style>",
      LesterHelper.render_text(text, 'text/html')
    
    assert_equal "h1. *Ahoy*<br><br>&lt;style&gt;body{color: navy}&lt;/style&gt;",
      LesterHelper.render_text(text, 'text/plain')
    
    # not trusted mode like comments
    assert_equal "<p>h1. <em>Ahoy</em></p>\n\n<p>body{color: navy}</p>\n",
      LesterHelper.render_text(text, 'text/markdown', not_trusted: true)

    assert_equal "h1. <strong>Ahoy</strong><br />\n<br />\n&lt;style&gt;body{color: navy}&lt;/style&gt;",
      LesterHelper.render_text(text, 'text/textile', not_trusted: true)

    assert_equal "h1. *Ahoy*<br><br>&lt;style&gt;body{color: navy}&lt;/style&gt;",
      LesterHelper.render_text(text, 'text/html', not_trusted: true)

    assert_equal "h1. *Ahoy*<br><br>&lt;style&gt;body{color: navy}&lt;/style&gt;",
      LesterHelper.render_text(text, 'text/plain', not_trusted: true)
    # handled like plain
    assert_equal "h1. *Ahoy*<br><br>&lt;style&gt;body{color: navy}&lt;/style&gt;",
      LesterHelper.render_text(text, 'something', not_trusted: true)
  end
end 
