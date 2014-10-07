require_relative './test_helper'

class Lester
  extend StarlightHelpers::Model
end

describe StarlightHelpers::Model do
  it '#make_uri' do
    assert "cucoriedky-nase-rastu-v-lese",
      Lester.make_uri("Čučoriedky naše rastú v lese! \n")
  end

	it '#make_uri with spec chars' do
		assert "Čučoriedka++",
			Lester.make_uri("cucoriedkaplusplus")
	end
end
 
