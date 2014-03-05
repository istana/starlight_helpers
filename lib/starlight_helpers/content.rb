require 'redcarpet'
require 'redcloth'
require 'action_view'

module StarlightHelpers
	module Content

		def link_to_selected(selected = false, name = nil, options = nil, html_options = {}, &block)
			if selected
				html_options.merge!(class: 'selected')
			end
			link_to(name, options, html_options, &block)
		end

		def render_text(content, markup = 'text/plain', options = {})
			textile_opts = []
			markdown_opts = {
				tables: true, fenced_code_blocks: true, autolink: true,
				disable_indented_code_blocks: true, strikethrough: true,
				underline: true, highlight: true, footnotes: true
			}
			if options[:not_trusted]
				textile_opts << :lite_mode << :filter_html
				markdown_opts = {filter_html: true, no_styles: true}
			end
		  
			if markup == 'text/markdown'
				renderer = Redcarpet::Render::HTML.new(markdown_opts)
				Redcarpet::Markdown.new(renderer).render(content)
			elsif markup == 'text/textile'
				RedCloth.new(content, textile_opts).to_html
			elsif markup == 'text/html' && options[:not_trusted] != true
				# nothing
				content
			# for text/plain and other
			else
				content.gsub(/["&'<>]/,
					'"' => '&quot;',
					'&' => '&amp;',
					"'" => '&apos;',
					'<' => '&lt;',
					'>' => '&gt;'
				).gsub("\n", '<br>')
			end
		end

	end
end

