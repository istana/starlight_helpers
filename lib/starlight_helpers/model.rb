require 'active_support/inflector'

module StarlightHelpers
	module Model
	  # converts text to nice uri
		def make_uri(string)
			uri = ActiveSupport::Inflector.transliterate(string)
			uri.gsub!("+", "plus")
			uri.parameterize
		end
	end
end

