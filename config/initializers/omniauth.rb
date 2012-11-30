=begin
use Rack::Session::Cookie

use OmniAuth::Builder do
#provider :facebook, '525547224122161', '87080433b183fece8b8fa73fc063c2f7' #logon
provider :facebook, '140247929457138', '87c868810882d3459873adcc0dff15ef', #loginin
           :scope => 'email,user_birthday,read_stream', :display => 'popup'
end
=end
