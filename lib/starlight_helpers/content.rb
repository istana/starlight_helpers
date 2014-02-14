require 'redcarpet'
require 'action_view'

module StarlightHelpers
	module Content

		def link_to_selected(selected = false, name = nil, options = nil, html_options = {}, &block)
			if selected
				html_options.merge!(class: 'selected')
			end
			link_to(name, options, html_options, &block)
		end

		def convert_content(content, markup)
			if markup == 'plain'
				content.gsub("\n", '<br>')
			elsif markup == 'markdown'
				markdown = ::Redcarpet::Markdown.new(::Redcarpet::Render::HTML)
				markdown.render(content)
			elsif markup == 'html'
				# nothing
				content
			end
		end

	end
end

