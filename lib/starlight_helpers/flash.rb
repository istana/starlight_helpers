require 'rack'
require 'action_dispatch/middleware/flash'

module StarlightHelpers
	module Flash
	
		def flash_alert(message)
			flash_something(:alert, message)
		end
		
		def flash_notice(message)
			flash_something(:notice, message)
		end

		def flash_something(what, message)
			type = what.to_sym
			if flash[type].is_a?(String)
				flash[type] = [flash[type], message]
			else
				flash[type] ||= []
				flash[type] << message
			end
		end
		
		def display_flash(what, &code)
		  type = what.to_sym
		  # something like Devise has overwritten flash
		  if flash[type].is_a?(String)
		    flash[type] = [flash[type]]
		  end

      if flash[type]
		    result = flash[type].inject([]) do |res, msg|
		      res << (block_given? ? code.call(msg) : msg)
		    end
		  end

		  # sometimes flash isn't cleared after action
			# "Please create or set 'default_locale'" is shown
			# multiple times
		  # better clear flash, it was already shown anyway
		  flash.delete(type)
		  result ? result.join(" "): nil
    end

	end
end

