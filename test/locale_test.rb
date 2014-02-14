require_relative './test_helper'

class Lester
  extend StarlightHelpers::Locale
end

describe StarlightHelpers::Locale do
  it '#valid_locale?' do
    assert Lester.valid_locale?('sk')
    assert Lester.valid_locale?('sk_SK')
    assert Lester.valid_locale?('sk-SK')
    
    assert !Lester.valid_locale?('sks')
    assert !Lester.valid_locale?('sks_SK')
    assert !Lester.valid_locale?('sk_SKs')
    assert !Lester.valid_locale?('sks_SKs')
    assert !Lester.valid_locale?('0a_SK')
    assert !Lester.valid_locale?('0')
    assert !Lester.valid_locale?('0_SK')
    assert !Lester.valid_locale?('sk_')    
  end

  it '#country?, #full_locale?' do
    assert Lester.country?('sk_SK')
    assert !Lester.country?('sk')
    assert Lester.full_locale?('sk_SK')
    assert !Lester.full_locale?('sk')
  end
  
  it 'only_language?' do
    assert !Lester.only_language?('sk_SK')
    assert Lester.only_language?('sk')
  end

  it '#country' do
    assert_equal 'US', Lester.country('en_US')
    assert_nil Lester.country('sk')
  end
  
  it '#language' do
    assert_equal 'en', Lester.language('en_US')
    assert_equal 'sk', Lester.language('sk')
  end
  
  it '#parse_accept_language' do
    assert_equal({'sk' => 1, 'cs' => 0.8, 'en-US' => 0.5, 'en' => 0.3}, Lester.parse_accept_language("sk,cs;q=0.8,en-US;q=0.5,en;q=0.3"))
    assert_equal({'sk' => 1, 'cs' => 0.8, 'en-US' => 0.5, 'en' => 0.3}, Lester.parse_accept_language("cs;q=0.8,en-US;q=0.5,sk,en;q=0.3"))
    assert_equal({}, Lester.parse_accept_language("sk;q=9000"))
    assert_equal({}, Lester.parse_accept_language("sk;q=0"))
    assert_equal({}, Lester.parse_accept_language("I can has?"))
  end
end
