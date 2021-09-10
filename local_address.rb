require 'socket'

def first_private_ipv4
  ipv4 = nil
  Socket.ip_address_list.map do |intf|
    ipv4 = intf if intf.ipv4_private?
  end
  Addrinfo
  ipv4
end

puts("当前 IP: #{first_private_ipv4.to_s.force_encoding("ASCII-8BIT")}")