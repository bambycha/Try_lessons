Module Test
Bundler.setup
it 'user enter some link & find some links' do
visit '/'
puts page.body
fill_in ‘url’, :with=>’http://www.google.com.ua/doodles/’
click_button 'Send'
end
end