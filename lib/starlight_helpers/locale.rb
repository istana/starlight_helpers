module StarlightHelpers
	module Locale
	  # en_US
	  # the first segment is language, the second the country
	  # isocode has only "-", allow "_" too like in gettext 
		def format_inline
		  /([a-zA-Z]{2})(?:([-_])([a-zA-Z]{2}))?/
		end
		
		def format
		  Regexp.new("\\A#{format_inline}\\z")
		end

    # function parses user agent string from web browser (Accept-Language)
    # and returns sorted array of {quality => code} segments
		def parse_accept_language(ualangs)
			# quality? format
			qf = "q=(1|0\.[1-9])"
			lang_format = "#{format_inline}(; ?#{qf})?"
			langs_format = /\A(#{lang_format}(,#{lang_format}){0,7})\z/

			if ualangs =~ langs_format
				langs = ualangs.split(',').map(&:strip)
				langs = langs.inject({}) do |result, language|
					segment = language.split(';').map(&:strip)
					# add q=1 for language if not defined
					if segment.size == 1
						segment << 1
				  elsif segment.size == 2
				    segment[1] = segment[1].gsub('q=', '').to_f
					end
					result.merge!(segment[0] => segment[1])
				end
				Hash[langs.sort_by { |code, quality| -quality }]
			else
				{}
			end
		end

		def valid_locale?(loc)
			loc =~ format ? true : false
		end

		def language(loc)
		  loc.match(format)[1]
		end
		
		def country(loc)
		  loc.match(format)[3]
		end

		def country?(loc)
		  loc.match(format)[3] != nil
		end
		alias_method :full_locale?, :country?
	end
end

